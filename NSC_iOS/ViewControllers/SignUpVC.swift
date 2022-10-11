//
//  SignUpVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 23/03/21.
//  Copyright © 2021 Dhruvit. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import FirebaseAuth

class SignUpVC: BaseViewController {
    
    // MARK: - OUTLETS
    //UIStackView
    @IBOutlet weak var stackView: UIStackView!
    
    //UITextfield
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPromoCode: UITextField!
    
    // UIButton
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var btnGetSMSCode: UIButton!
    
    // UILabel
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblPrivacy: TTTAttributedLabel!
    @IBOutlet weak var lblSupport: TTTAttributedLabel!
    
    @IBOutlet weak var lblErrFName: UILabel!
    @IBOutlet weak var lblErrLName: UILabel!
    @IBOutlet weak var lblErrMobileNo: UILabel!
    @IBOutlet weak var lblErrEmail: UILabel!
    @IBOutlet weak var lblErrPromoCode: UILabel!
    @IBOutlet weak var viewApply: UIView!
    
    
    // MARK: - VARIABLES
    var loginCheckVM : LoginCheckViewModel?
    
    var mobileNoDidChange : ((String?) -> Void)?
    
    var isFromOTP = false
    var isCountrySelected = false
    var strMobile:String?
    var promoCode = ""
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupPrivacyLabel(lblPrivacy: lblPrivacy)
        setupSupportLabel(lblSupport: lblSupport)
        setupData()
        
        if strMobile != "" {
            txtMobile.text = strMobile
        }
        viewApply.addDashedBorder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFromOTP {
            txtMobile.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
        lblTitle.text = Theme.strings.register_title
        lblSubTitle.attributedText = Theme.strings.register_subtitle.attributedString(alignment: .center, lineSpacing: 5)
        
        lblErrMobileNo.isHidden = true
        lblErrFName.isHidden = true
        lblErrLName.isHidden = true
        lblErrEmail.isHidden = true
        lblErrPromoCode.isHidden = true
        
        txtFName.delegate = self
        txtLName.delegate = self
        txtMobile.delegate = self
        txtEmail.delegate = self
        
        buttonEnableDisable()
    }
    
    override func setupData() {
        let countryText = AppVersionDetails.countryShortName + " +" + AppVersionDetails.countryCode
        btnCountryCode.setTitle(countryText, for: .normal)
        
        buttonEnableDisable()
    }
    
    override func buttonEnableDisable() {
        let fname = txtFName.text?.trim
        let lname = txtLName.text?.trim
        let mobile = txtMobile.text?.trim
        let email = txtEmail.text?.trim
        
        
        if fname?.count == 0 || lname?.count == 0 || mobile?.count == 0 || email?.count == 0 {
            btnGetSMSCode.isUserInteractionEnabled = false
            btnGetSMSCode.backgroundColor = Theme.colors.gray_7E7E7E
        } else {
            btnGetSMSCode.isUserInteractionEnabled = true
            btnGetSMSCode.backgroundColor = Theme.colors.theme_dark
        }
        
        DispatchQueue.main.async {
            if self.txtPromoCode.text?.trim.count == 0 {
                self.btnApply.isUserInteractionEnabled = false
                self.btnApply.setTitleColor(Theme.colors.gray_7E7E7E, for: .normal)
            } else {
                self.btnApply.isUserInteractionEnabled = true
                self.btnApply.setTitleColor(Theme.colors.theme_dark, for: .normal)
            }
        }
    }
    
    func checkValidation() -> Bool {
        var isValid = true
        let strMobile = txtMobile.text?.trim ?? ""
        
        if txtFName.text?.trim.count == 0 {
            isValid = false
            lblErrFName.isHidden = false
            lblErrFName.text = Theme.strings.alert_blank_firstname_error
        }
        
        if txtLName.text?.trim.count == 0 {
            isValid = false
            lblErrLName.isHidden = false
            lblErrLName.text = Theme.strings.alert_blank_lastname_error
        }
        
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
        
        if txtEmail.text?.trim.count == 0 {
            isValid = false
            lblErrEmail.isHidden = false
            lblErrEmail.text = Theme.strings.alert_invalid_email_error
        } else if !txtEmail.text!.isValidEmail {
            isValid = false
            lblErrEmail.isHidden = false
            lblErrEmail.text = Theme.strings.alert_invalid_email_error
        }
        
        return isValid
    }
    
    override func goNext() {
        if loginCheckVM?.loginFlag == "0" {
            sendOTP()
        } else {
            if strMobile != txtMobile.text {
                self.mobileNoDidChange?(txtMobile.text)
            }
            self.navigationController?.popViewController(animated: true)
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
            aVC.strFName = self.txtFName.text ?? ""
            aVC.strLName = self.txtLName.text ?? ""
            aVC.strEmail = self.txtEmail.text ?? ""
            aVC.strPromoCode = self.txtPromoCode.text ?? ""
            aVC.isFromSignUp = true
            self.navigationController?.pushViewController(aVC, animated: true)
        }
    }
    
    func checkLogin() {
        let parameters = ["mobile":txtMobile.text ?? "",
                          "countryCode":AppVersionDetails.countryCode]
        
        loginCheckVM = LoginCheckViewModel()
        loginCheckVM?.callLoginCheckAPI(parameters: parameters, completion: { success in
            if success {
                self.goNext()
            }
        })
    }
    
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if (txtPromoCode.text?.trim.count ?? 0) == 5 {
            let verifyReferCodeVM = VerifyReferCodeViewModel()
            verifyReferCodeVM.callVerifyReferCodeAPI(referCode: txtPromoCode.text ?? "") { success in
                if success {
                    print("promocode applied")
                    self.promoCode = self.txtPromoCode.text ?? ""
                }
            }
        } else {
            lblErrPromoCode.isHidden = false
            lblErrPromoCode.text = Theme.strings.alert_invalid_promocode_error
        }
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if checkValidation() {
            lblErrFName.isHidden = true
            lblErrLName.isHidden = true
            lblErrMobileNo.isHidden = true
            lblErrEmail.isHidden = true
            lblErrPromoCode.isHidden = true
            isFromOTP = true
            
            if (txtPromoCode.text?.trim.count ?? 0) > 0 {
                if promoCode == txtPromoCode.text {
                    self.checkLogin()
                } else {
                    let verifyReferCodeVM = VerifyReferCodeViewModel()
                    verifyReferCodeVM.callVerifyReferCodeAPI(referCode: txtPromoCode.text ?? "") { success in
                        if success {
                            print("promocode applied")
                            self.promoCode = self.txtPromoCode.text ?? ""
                            self.checkLogin()
                        }
                    }
                }
            } else {
                self.checkLogin()
            }
        }
    }
    
}


// MARK: - UITextFieldDelegate
extension SignUpVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lblErrFName.isHidden = true
        lblErrLName.isHidden = true
        lblErrMobileNo.isHidden = true
        lblErrEmail.isHidden = true
        lblErrPromoCode.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return false
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        if textField == txtFName || textField == txtLName {
            if updatedText.count > 16 {
                return false
            }
        } else if textField == txtMobile {
            if !updatedText.isNumber || updatedText.count > AppVersionDetails.mobileMaxDigits {
                return false
            }
        } else if textField == txtPromoCode && updatedText.count > 5 {
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        buttonEnableDisable()
    }
    
}
