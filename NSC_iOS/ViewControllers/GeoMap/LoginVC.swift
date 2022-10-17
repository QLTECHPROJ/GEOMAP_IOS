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
    }
    
}


// MARK: - UITextFieldDelegate
extension LoginVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
    }
    
}

