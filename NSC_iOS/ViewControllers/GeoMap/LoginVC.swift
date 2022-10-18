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
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblPrivacy: TTTAttributedLabel!
    @IBOutlet weak var lblSupport: TTTAttributedLabel!
    
    //UIButton
    @IBOutlet weak var btnUser: UIButton!
    
    @IBOutlet weak var btnPassword: UIButton!
    @IBOutlet weak var btnGetSMSCode: UIButton!
    
    //UITextfield
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //UIStackView
    @IBOutlet weak var stackView: UIStackView!
    
    
    // MARK: - VARIABLES
    var loginCheckVM : LoginCheckViewModel?
    var isFromOTP = false
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonEnableDisable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
       
    }
    
    override func setupData() {
       
       
    }
    
    override func buttonEnableDisable() {
        let fname = txtUser.text?.trim
        let password = txtPassword.text?.trim
       
        if fname?.count == 0  || password?.count == 0 {
            btnGetSMSCode.isUserInteractionEnabled = false
            btnGetSMSCode.backgroundColor = Theme.colors.gray_7E7E7E
            btnUser.setImage(UIImage(named: "UserGray"), for: .normal)
            btnPassword.setImage(UIImage(named: "passwordGray"), for: .normal)
        } else {
            btnGetSMSCode.isUserInteractionEnabled = true
            btnGetSMSCode.backgroundColor = Theme.colors.theme_dark
            btnUser.setImage(UIImage(named: "UserBlue"), for: .normal)
            btnPassword.setImage(UIImage(named: "passwordBlue"), for: .normal)
        }
       
    }
    
    func checkValidation() -> Bool {
        var isValid = true
       
        if txtUser.text?.trim.count == 0 {
            isValid = false
            lblError.isHidden = false
            lblError.text = Theme.strings.alert_blank_firstname_error
        }
        
        if txtPassword.text?.trim.count == 0 {
            isValid = false
            lblError.isHidden = false
            lblError.text = Theme.strings.alert_blank_password_error
    
        } else if !txtPassword.text!.isValidPassword() {
            isValid = false
            lblError.isHidden = false
            lblError.text = Theme.strings.alert_invalid_password_error
        }
        
        return isValid
    }
    
    // MARK: - ACTIONS
    @IBAction func loginClicked(_ sender: UIButton) {
        if checkValidation() {
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: HomeVC.self)
            self.navigationController?.pushViewController(aVC, animated: true)
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
       
        buttonEnableDisable()
        
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
