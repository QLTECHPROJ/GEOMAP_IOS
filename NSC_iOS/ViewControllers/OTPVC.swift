//
//  OTPVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 22/06/21.
//  Copyright © 2021 Dhruvit. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import FirebaseAuth

class OTPVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblSupport: TTTAttributedLabel!
    
    @IBOutlet weak var txtOTP: UITextField!
    @IBOutlet weak var btnDone: UIButton!
    
    
    // MARK: - VARIABLES
    var isFromSignUp = false
    var strFName = ""
    var strLName = ""
    var strMobile = ""
    var strEmail = ""
    var strPromoCode = ""
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSupportLabel(lblSupport: lblSupport)
        self.txtOTP.becomeFirstResponder()
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
        let strSMSSent = "We've sent SMS with a 6-digit code to \n+\(AppVersionDetails.countryCode)\(strMobile)."
        lblSubTitle.attributedText = strSMSSent.attributedString(alignment: .center, lineSpacing: 5)
        
        // txtOTP.tintColor = UIColor.clear
        txtOTP.delegate = self
        txtOTP.addTarget(self, action: #selector(textFieldEdidtingDidChange(_ :)), for: .editingChanged)
        
        if #available(iOS 12.0, *) {
            txtOTP.textContentType = .oneTimeCode
        } else {
            // Fallback on earlier versions
        }
        
        buttonEnableDisable()
    }
    
    override func buttonEnableDisable() {
        if (txtOTP.text?.trim.count ?? 0) < 6 {
            btnDone.isUserInteractionEnabled = false
            btnDone.backgroundColor = Theme.colors.gray_7E7E7E
            btnDone.removeGradient()
        } else {
            btnDone.isUserInteractionEnabled = true
            btnDone.backgroundColor = Theme.colors.theme_dark
        }
    }
    
    @objc func textFieldEdidtingDidChange(_ textField :UITextField) {
        let attributedString = NSMutableAttributedString(string: textField.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(8.0), range: NSRange(location: 0, length: attributedString.length))
        textField.attributedText = attributedString
    }
    
    func checkValidation() -> Bool {
        if (txtOTP.text?.trim.count ?? 0) < 6 {
            self.lblError.text = Theme.strings.alert_invalid_otp
            return false
        }
        
        return true
    }
    
    func isStringContainsOnlyNumbers(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func sendOTP() {
        showHud()
        
        let phoneString = "+" + AppVersionDetails.countryCode + strMobile
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneString, uiDelegate: nil) { verificationID, error in
            
            hideHud()
            
            if let error = error {
                showAlertToast(message: error.localizedDescription)
                return
            }
            
            showAlertToast(message: Theme.strings.sms_sent)
            
            // Sign in using the verificationID and the code sent to the user
            authVerificationID = verificationID ?? ""
        }
    }
    
    func autoVerifyOTP() {
        self.view.endEditing(true)
        
        if checkValidation() {
            let strOTP = txtOTP.text ?? ""
            verifyOTP(verificationCode: strOTP)
        }
    }
    
    func verifyOTP(verificationCode : String) {
        showHud()
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: authVerificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            
            hideHud()
            
            if let error = error {
                if error.localizedDescription == Theme.strings.invalid_otp_firebase {
                    showAlertToast(message: Theme.strings.alert_invalid_otp)
                } else {
                    showAlertToast(message: error.localizedDescription)
                }
                return
            }
            
            // OTP Verification Successful
            self.goNext()
        }
    }
    
    override func goNext() {
        if isFromSignUp {
            handleSignUp()
        } else {
            handleLogin()
        }
    }
    
    func handleSignUp() {
        // Call Coach Register API
        let parameters = ["fname":strFName,
                          "lname":strLName,
                          "countryCode":AppVersionDetails.countryCode,
                          "mobile":strMobile,
                          "email":strEmail,
                          "referCode":strPromoCode,
                          "deviceType":APP_TYPE,
                          "deviceId":DEVICE_UUID,
                          "deviceToken":FCM_TOKEN]
        
        let signUpVM = SignUpViewModel()
        signUpVM.callCoachRegisterAPI(parameters: parameters) { success in
            if success {
                self.handleLoginUserRedirection()
            }
        }
    }
    
    func handleLogin() {
        // Call Coach Login API
        let parameters = ["mobile":strMobile,
                          "countryCode":AppVersionDetails.countryCode,
                          "deviceType":APP_TYPE,
                          "deviceId":DEVICE_UUID,
                          "deviceToken":FCM_TOKEN]
        
        let loginVM = LoginViewModel()
        loginVM.callLoginAPI(parameters: parameters) { success in
            if success {
                self.handleLoginUserRedirection()
            }
        }
    }
    
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAccountClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.autoVerifyOTP()
    }
    
    @IBAction func resendSMSClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        txtOTP.text = ""
        lblError.isHidden = true
        
        buttonEnableDisable()
        
        self.sendOTP()
    }
    
    @IBAction func editNumberClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - UITextFieldDelegate, BackspaceTextFieldDelegate
extension OTPVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if isStringContainsOnlyNumbers(string: string) == false {
            return false
        }
        
        let text = textField.text
        let textRange = Range(range, in:text!)
        let updatedText = text!.replacingCharacters(in: textRange!, with: string).trim
        
        if updatedText.count < 6 {
            return true
        } else if updatedText.count > 6 {
            return false
        }
        
        let attributedString = NSMutableAttributedString(string: updatedText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(8.0), range: NSRange(location: 0, length: attributedString.length))
        textField.attributedText = attributedString
        
        // textField.text = updatedText
        buttonEnableDisable()
        self.autoVerifyOTP()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        buttonEnableDisable()
    }
    
}

