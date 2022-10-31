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

class LoginVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    //UILabel
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    
    //UIButton
    @IBOutlet weak var btnUser: UIButton!
    
    @IBOutlet weak var btnPassword: UIButton!
    
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnGetSMSCode: AppThemeBlueButton!
    
    //UITextfield
    @IBOutlet weak var txtUser: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    
    //UIStackView
    
    
    // MARK: - VARIABLES
    var loginCheckVM : LoginCheckViewModel?
    var isFromOTP = false
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    
    // MARK: - FUNCTIONS
    
    func setupUI() {
        self.view.backgroundColor = UIColor.colorBGSkyBlueLight
                
        self.lblTitle.applyLabelStyle(text : kHelloAgian,fontSize :  27,fontName : .InterBold)
        self.lblSubTitle.applyLabelStyle(text : kInstructionTitleLogin,fontSize : 20,fontName : .InterMedium)
        
        self.btnForgotPassword.applystyle(fontname : .InterMedium,fontsize : 14,titleText : kForgotPassword,titleColor : .colorTextPlaceHolderGray)
        
        self.btnGetSMSCode.setTitle(kSignIn, for: .normal)
        
        self.txtUser.applyStyleFlotingTextfield(placeholderTitle : kName, fontsize : 16,fontname : .InterSemibol)
        self.txtPassword.applyStyleFlotingTextfield(placeholderTitle : kPassword, fontsize : 16, fontname : .InterSemibol)
        
        self.buttonEnableDisable()
    }
    
     func buttonEnableDisable() {
        let fname = txtUser.text!.trim
        let password = txtPassword.text!.trim
                
        self.btnUser.isSelected = !fname.isEmpty
        self.btnPassword.isSelected = !password.isEmpty
       
        if fname.isEmpty  || password.isEmpty {

            self.btnGetSMSCode.isSelect = false
            
        } else {

            self.btnGetSMSCode.isSelect = true
        }
    }
    
    func checkValidation() -> String? {
        self.view.endEditing(true)
        var message : String? = nil
        
        if txtUser.text?.trim.count == 0 {
           
            message = Theme.strings.alert_blank_firstname_error
        }
        else if txtPassword.text?.trim.count == 0 {
            
            message = Theme.strings.alert_blank_password_error
    
        }
        /*else if !txtPassword.text!.isValidPassword() {
            
            message = Theme.strings.alert_invalid_password_error
        }*/
        
        return message
    }
    
    
    // MARK: - ACTIONS
    
    @IBAction func btnForgotPassowrdTapped(_ sender: UIButton) {
       
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
       
        if let errorMessage = self.checkValidation(){
            GFunctions.shared.showSnackBar(message: errorMessage)
        }
        else {
//            AppDelegate.shared.updateWindow(.home)
            
            
            let parameters : [String:String] = [
                APIParameters.userName.rawValue : JSON(self.txtUser.text).stringValue,
                APIParameters.password.rawValue : JSON(self.txtPassword.text).stringValue,
                APIParameters.deviceToken.rawValue : GFunctions.shared.getDeviceToken(),
                APIParameters.deviceId.rawValue : DeviceDetail.shared.uuid,
                APIParameters.deviceType.rawValue : DeviceDetail.shared.deviceType
            ]
            
//            debugPrint(parameters)
            
            self.loginCheckVM?.callLoginCheckAPI(parameters: parameters, completion: { isCompleted in
               if isCompleted{
                    
                }
            })
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension LoginVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.buttonEnableDisable()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.buttonEnableDisable()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return false
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        if textField == txtUser || textField == txtPassword {
            if updatedText.count > 24 {
                return false
            }
        }
        
        return true
    }
    
}
