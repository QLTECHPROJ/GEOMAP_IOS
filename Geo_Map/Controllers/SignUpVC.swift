//
//  SignUpVC.swift
//  Geo_Map
//
//  Created by  on 13/07/23.
//

import UIKit

class SignUpVC: ClearNaviagtionBarVC {
    //---------------------------------------------------------------------------------
    // MARK: - Outlets
    //---------------------------------------------------------------------------------
    
    @IBOutlet weak var txtNameUser: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var txtConfirmPassword: ACFloatingTextfield!
    
    @IBOutlet weak var btnSignUp: AppThemeBlueButton!
    
    @IBOutlet weak var btnPassword: UIButton!
    
    @IBOutlet weak var btnConfirmPassword: UIButton!
    
    //---------------------------------------------------------------------------------
    // MARK: - Variables
    //---------------------------------------------------------------------------------
    
    private var vmLogInSignUp : LoginViewModel = LoginViewModel()
    
    
   
    
    //---------------------------------------------------------------------------------
    // MARK: - Functions
    //---------------------------------------------------------------------------------
    
    private func setUpView(){
        self.configureUI()
    }
    
    private func configureUI(){
        self.view.backgroundColor = UIColor.colorBGSkyBlueLight
        self.title = kSignUp
        self.txtNameUser.applyStyleFlotingTextfield(placeholderTitle : kName, fontsize : 14,fontname : .InterSemibol)
        self.txtEmail.applyStyleFlotingTextfield(placeholderTitle : kEmail, fontsize : 14,fontname : .InterSemibol)
        self.txtPassword.applyStyleFlotingTextfield(placeholderTitle : kPassword, fontsize : 14, fontname : .InterSemibol)
        self.txtConfirmPassword.applyStyleFlotingTextfield(placeholderTitle : kConfirmPassword, fontsize : 14, fontname : .InterSemibol)
        
        self.btnSignUp.setTitle(kSignUp, for: .normal)
        self.buttonEnableDisable()
    }
    
     private func buttonEnableDisable() {
        
         if JSON(self.txtNameUser.text as Any).stringValue.trim.isEmpty || JSON(self.txtEmail.text as Any).stringValue.trim.isEmpty || JSON(self.txtPassword.text as Any).stringValue.trim.isEmpty || JSON(self.txtConfirmPassword.text as Any).stringValue.trim.isEmpty{
             
             self.btnSignUp.isSelect = false
         }
         else{
             self.btnSignUp.isSelect = true
         }
    }
    
    private func checkValidation() -> String? {
        self.view.endEditing(true)
        var message : String? = nil
        
        if self.txtNameUser.text!.trim.count < Validations.NameLength.Minimum.rawValue || self.txtNameUser.text!.trim.count > Validations.NameLength.Maximum.rawValue {
            
            message = kEnterValidName
        }
        else if !self.txtEmail.text!.trim.isValidEmail{
            
            message = kPleaseProvideValidEmailAddress
        }
        else if JSON(self.txtPassword.text as Any).stringValue != JSON(self.txtConfirmPassword.text as Any).stringValue{
            
            message = kPasswordMismacth
        }
    
        return message
    }


    //---------------------------------------------------------------------------------
    // MARK: - Actions Methods
    //---------------------------------------------------------------------------------
   
    @IBAction func btnBackTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPasswordVisibiltyTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        guard !self.txtPassword.text!.trim.isEmpty else {return}
        self.txtPassword.isSecureTextEntry = !self.txtPassword.isSecureTextEntry
        self.btnPassword.isSelected = !self.btnPassword.isSelected
    }
    
    @IBAction func btnConfirmPasswordVisibiltyTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        guard !self.txtConfirmPassword.text!.trim.isEmpty else {return}
        self.txtConfirmPassword.isSecureTextEntry = !self.txtConfirmPassword.isSecureTextEntry
        self.btnConfirmPassword.isSelected = !self.btnConfirmPassword.isSelected
    }
    
    @IBAction func btnSignUpTapped(_ sender : UIButton){
        
        if let errorMessage = self.checkValidation(){
            GFunctions.shared.showSnackBar(message: errorMessage)
        }
        else {
        
          let parameters = APIParametersModel()
            
            parameters.name = JSON(self.txtNameUser.text as Any).stringValue
            parameters.email = JSON(self.txtEmail.text as Any).stringValue
            parameters.password = JSON(self.txtPassword.text as Any).stringValue
            
            debugPrint(parameters.toDictionary())
            self.vmLogInSignUp.callAPISignUp(parameter: parameters) { responseData, statusCode, message, completion in
                if completion{
                    AppDelegate.shared.updateWindow(.home)
                    GFunctions.shared.showSnackBar(message: kWelcomeToTheAppAfterLogin)
                 }
                 else{
                     GFunctions.shared.showSnackBar(message: message ?? kAPIRequestFailed)
                 }
            }
        }
    }
    
    //---------------------------------------------------------------------------------
    // MARK: - View Life Cycle
    //---------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}

//---------------------------------------------------------------------------------
// MARK: - UITextFieldDelegate Methods
//---------------------------------------------------------------------------------
extension SignUpVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtNameUser {

            self.txtEmail.becomeFirstResponder()
            
        }
        else if textField == self.txtEmail {

            self.txtPassword.becomeFirstResponder()
            
        }
        else if textField == self.txtPassword {

            self.txtConfirmPassword.becomeFirstResponder()
            
        }else if textField == self.txtConfirmPassword {

            textField.becomeFirstResponder()
        }
        return true
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
        
        if textField == self.txtNameUser || textField == self.txtPassword || textField == self.txtConfirmPassword {
            if updatedText.count > 24 {
                return false
            }
        }
        
        return true
    }
    
}
