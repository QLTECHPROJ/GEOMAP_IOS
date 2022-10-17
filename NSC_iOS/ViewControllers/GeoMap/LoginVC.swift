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
    
    // MARK: - ACTIONS
    @IBAction func loginClicked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: HomeVC.self)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
}


// MARK: - UITextFieldDelegate
// MARK: - UITextFieldDelegate
extension LoginVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if txtUser.text != "" {
            btnUser.setImage(UIImage(named: "UserBlue"), for: .normal)
        }
        if txtPassword.text != ""{
            btnPassword.setImage(UIImage(named: "PasswordBlue"), for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if txtUser.text != "" {
            btnUser.setImage(UIImage(named: "UserBlue"), for: .normal)
        }
        if txtPassword.text != ""{
            btnPassword.setImage(UIImage(named: "PasswordBlue"), for: .normal)
        }
    }
    
}

