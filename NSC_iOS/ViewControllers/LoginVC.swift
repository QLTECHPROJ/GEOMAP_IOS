//
//  LoginVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 23/03/21.
//  Copyright © 2021 Dhruvit. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import FirebaseAuth

class LoginVC: BaseViewController {
    
    // MARK: - OUTLETS
    //UILabel
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblErrMobileNo: UILabel!
    @IBOutlet weak var lblPrivacy: TTTAttributedLabel!
    @IBOutlet weak var lblSupport: TTTAttributedLabel!
    
    //UIButton
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var btnGetSMSCode: UIButton!
    
    //UITextfield
    @IBOutlet weak var txtMobile: UITextField!
    
    //UIStackView
    @IBOutlet weak var stackView: UIStackView!
    
    
    // MARK: - VARIABLES
    var loginCheckVM : LoginCheckViewModel?
    var isFromOTP = false
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPrivacyLabel(lblPrivacy: lblPrivacy)
        setupSupportLabel(lblSupport: lblSupport)
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFromOTP {
            txtMobile.becomeFirstResponder()
        } else {
            txtMobile.text = ""
        }
        
        buttonEnableDisable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
        txtMobile.delegate = self
        lblTitle.text = Theme.strings.login_title
        lblSubTitle.attributedText = Theme.strings.login_subtitle.attributedString(alignment: .center, lineSpacing: 5)
    }
    
    override func setupData() {
       
        buttonEnableDisable()
    }
    
    override func buttonEnableDisable() {
        let mobile = txtMobile.text?.trim
        
        if mobile?.count == 0 {
            btnGetSMSCode.isUserInteractionEnabled = false
            btnGetSMSCode.backgroundColor = Theme.colors.gray_7E7E7E
            btnGetSMSCode.removeGradient()
        } else {
            btnGetSMSCode.isUserInteractionEnabled = true
            btnGetSMSCode.backgroundColor = Theme.colors.theme_dark
        }
    }
    
    func checkValidation() -> Bool {
        var isValid = true
        let strMobile = txtMobile.text?.trim ?? ""
        if strMobile.count == 0 {
            isValid = false
            self.lblErrMobileNo.isHidden = false
            self.lblErrMobileNo.text = Theme.strings.alert_invalid_mobile_error
        } else if strMobile.count < AppVersionDetails.mobileMinDigits || strMobile.count > AppVersionDetails.mobileMaxDigits {
            isValid = false
            self.lblErrMobileNo.isHidden = false
            self.lblErrMobileNo.text = Theme.strings.alert_invalid_mobile_error
        } else if strMobile.isPhoneNumber == false {
            isValid = false
            lblErrMobileNo.isHidden = false
            lblErrMobileNo.text = Theme.strings.alert_invalid_mobile_error
        }
        
        return isValid
    }
    
    override func goNext() {
        if loginCheckVM?.loginFlag == "0" {
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: SignUpVC.self)
            aVC.strMobile = txtMobile.text ?? ""
            aVC.mobileNoDidChange = { mobileNo in
                self.txtMobile.text = mobileNo
            }
            self.navigationController?.pushViewController(aVC, animated: true)
        } else {
            sendOTP()
        }
    }
    
    func sendOTP() {
        // showHud()
        self.view.isUserInteractionEnabled = false
        
        let phoneString = "+" + AppVersionDetails.countryCode + (txtMobile.text ?? "")
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneString, uiDelegate: nil) { verificationID, error in
            
            // hideHud()
            self.view.isUserInteractionEnabled = true
            
            if let error = error {
                showAlertToast(message: error.localizedDescription)
                return
            }
            
            showAlertToast(message: Theme.strings.sms_sent)
            
            // Sign in using the verificationID and the code sent to the user
            authVerificationID = verificationID ?? ""
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:OTPVC.self)
            aVC.strMobile = self.txtMobile.text ?? ""
            self.navigationController?.pushViewController(aVC, animated: true)
        }
    }
    
    
    // MARK: - ACTIONS
    @IBAction func loginClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if checkValidation() {
            lblErrMobileNo.isHidden = true
            isFromOTP = true
            
            let parameters = ["mobile":txtMobile.text ?? "",
                              "countryCode":AppVersionDetails.countryCode]
            
            loginCheckVM = LoginCheckViewModel()
            loginCheckVM?.callLoginCheckAPI(parameters: parameters, completion: { success in
                if success {
                    self.goNext()
                }
            })
        }
    }
    
}


// MARK: - UITextFieldDelegate
extension LoginVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.lblErrMobileNo.isHidden = true
        if textField.text != "" {
            btnCountryCode.setImage(UIImage(named: "String"), for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        buttonEnableDisable()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string).trim
            if !updatedText.isNumber || updatedText.count > AppVersionDetails.mobileMaxDigits {
                return false
            }
        }
        
        let inValidCharacterSet = NSCharacterSet.whitespaces
        guard let firstChar = string.unicodeScalars.first else {
            return true
        }
        
        return !inValidCharacterSet.contains(firstChar)
    }
    
}

