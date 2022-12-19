//
//  ContactUSVC.swift


import UIKit



class ContactUSVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    
    @IBOutlet weak var txtName: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtMobileNo: ACFloatingTextfield!
    @IBOutlet weak var txtSubject: ACFloatingTextfield!
    
    @IBOutlet weak var tvMessage: IQTextView!
    
    @IBOutlet weak var btnSubmit : AppThemeBlueButton!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    
    
    
    //----------------------------------------------------------------------------
    //MARK: - Memory management
    //----------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Custome Methods
    //----------------------------------------------------------------------------
    //Desc:- Centre method to call Of View Config.
    func setUpView(){
        
        self.configureUI()
    }
    
    
    
    //Desc:- Set layout desing customize
    
    func configureUI(){
        self.view.backgroundColor = .colorBGSkyBlueLight
        self.title = kContantUs
        
        self.txtName.applyStyleFlotingTextfield(placeholderTitle : kName, fontsize : 14,fontname : .InterSemibol)
        self.txtEmail.applyStyleFlotingTextfield(placeholderTitle : kEmail, fontsize : 14, fontname : .InterSemibol)
        self.txtMobileNo.applyStyleFlotingTextfield(placeholderTitle : kMobile, fontsize : 14,fontname : .InterSemibol)
        self.txtSubject.applyStyleFlotingTextfield(placeholderTitle : kSubject, fontsize : 14, fontname : .InterSemibol)
        
        self.tvMessage.applyTextViewStyle(placeholderText : kEnterMessage, fontSize : 14,fontName : .InterSemibol,placeholerColor : .colorTextPlaceHolderGray)
       
        self.btnSubmit.setTitle(kSubmit, for: .normal)
        self.setUserData()
        self.buttonEnableDisable()
    }
    
    func checkValidation() -> String? {
        self.view.endEditing(true)
        var message : String? = nil
        
        if self.txtName.text!.trim.count < Validations.NameLength.Minimum.rawValue || self.txtName.text!.trim.count > Validations.NameLength.Maximum.rawValue {
            
            message = kEnterValidName
        }
        else if !self.txtMobileNo.text!.trim.isEmpty && (self.txtMobileNo.text?.count)! < Validations.PhoneNumber.Minimum.rawValue{
            
            message = kPleaseProvideValidMobileNumber
        }
        else if !self.txtEmail.text!.trim.isValidEmail{
            
            message = kPleaseProvideValidEmailAddress
        }
       
       
        return message
    }
    
    func setUserData(){
        let userData = UserModelClass.current
//        self.txtName.text = JSON(userData.name as Any).stringValue
//        self.txtEmail.text = JSON(userData.email as Any).stringValue
//        self.txtEmail.isUserInteractionEnabled = JSON(userData.email as Any).stringValue.isEmpty
//        self.txtMobileNo.text = JSON(userData.mobile as Any).stringValue
//        self.txtMobileNo.isUserInteractionEnabled = JSON(userData.mobile as Any).stringValue.isEmpty
    }
    
    func buttonEnableDisable(){
        
        self.btnSubmit.isSelect = !self.txtName.text!.isEmpty && !self.txtEmail.text!.isEmpty && !self.txtMobileNo.text!.isEmpty && !self.txtSubject.text!.isEmpty && !self.tvMessage.text!.isEmpty
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitTapped(_ sender : UIButton){
        
        if let errorMessage = self.checkValidation(){
            
            GFunctions.shared.showSnackBar(message: errorMessage)
        }
        else{
            
            let parameters = APIParametersModel()
            parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
            parameters.name = JSON(self.txtName.text as Any).stringValue
            parameters.mobile = JSON(self.txtMobileNo.text as Any).stringValue
            parameters.email = JSON(self.txtEmail.text as Any).stringValue
            parameters.subject = JSON(self.txtSubject.text as Any).stringValue
            parameters.message = JSON(self.tvMessage.text as Any).stringValue
            
            let vwContactUs = ContactUSVM()
            vwContactUs.callAPIContactUS(parameters: parameters) { responseJSON, statusCode, message, completion in
                if completion{
                    
                    self.navigationController?.popViewController(animated: true)
                }
                GFunctions.shared.showSnackBar(message: JSON(message as Any).stringValue)
            }
        }
    }
    
    
    
    
    //----------------------------------------------------------------------------
    //MARK: - View life cycle
    //----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

//----------------------------------------------------------------------------
//MARK: - UITextFieldDelegate
//----------------------------------------------------------------------------
extension ContactUSVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtName {

            self.txtMobileNo.becomeFirstResponder()
        } else if textField == self.txtMobileNo {

            self.txtEmail.becomeFirstResponder()
        } else if textField == self.txtEmail {

            self.txtSubject.becomeFirstResponder()
        }
        else if textField == self.txtSubject {

            self.tvMessage.becomeFirstResponder()
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.buttonEnableDisable()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return false
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        if textField == self.txtName {
            if updatedText.count > 16 {
                return false
            }
        }
        else if textField == self.txtMobileNo{
            
            if (self.txtMobileNo.text?.count)! == Validations.PhoneNumber.Maximum.rawValue {
                if !(range.length == 1) {
                    return false
                }
            }
            let cs: CharacterSet = NSCharacterSet.decimalDigits.inverted as CharacterSet
            let filtered: String = (string.components(separatedBy: cs)).joined(separator: "")
            return (string == filtered)
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
}

//----------------------------------------------------------------------------
//MARK: - UITextFieldDelegate
//----------------------------------------------------------------------------
extension ContactUSVC : UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        self.buttonEnableDisable()
    }
}
