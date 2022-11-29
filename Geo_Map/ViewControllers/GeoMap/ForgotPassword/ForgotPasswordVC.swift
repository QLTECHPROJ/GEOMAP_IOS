//
//  ForgotPasswordVC.swift


import UIKit

class ForgotPasswordVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    @IBOutlet weak var lblTitle : UILabel!
   
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    
    @IBOutlet weak var btnConfirm : AppThemeBlueButton!
    @IBOutlet weak var btnCancel : AppThemeBorderBlueButton!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
   
    var didCompleteOperation : ((Bool)->Void)?
    
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
    
    func buttonEnableDisable(){
        
        self.btnConfirm.isSelect = !self.txtEmail.text!.isEmpty
    }
    
    func checkValidation() -> String? {
        self.view.endEditing(true)
        var message : String? = nil
        
        if !self.txtEmail.text!.trim.isValidEmail{
            
            message = kPleaseProvideValidEmailAddress
        }
       
        return message
    }
    
    
    //Desc:- Set layout desing customize
    
    func configureUI(){
       
        self.view.alpha = 0
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        self.lblTitle.applyLabelStyle(text : kForgotPassword,fontSize : 16,fontName : .InterBold)
        
        self.txtEmail.applyStyleFlotingTextfield(placeholderTitle : kEmail, fontsize : 14, fontname : .InterSemibol)
        
        self.btnConfirm.setTitle(kConfirm, for: .normal)
        self.btnCancel.setTitle(kCancel, for: .normal)
        
        self.buttonEnableDisable()
    }
    
    func openPopUpVisiable(){
        UIView.animate(withDuration: 0.5, delay: 0.0) {
            self.view.alpha = 1
        }
    }
    
    func closePopUpVisiable(isCompletion : Bool = false){
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            
            self.view.alpha = 0
            
        }, completion: { (finished: Bool) in
            self.dismiss(animated: false) {
                if isCompletion, let _ = self.didCompleteOperation{
                    self.didCompleteOperation!(true)
                }
            }
        })
    }
    
  
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------

    @IBAction func btnCancelTapped(_ sender : UIButton){
        self.closePopUpVisiable()
    }
    
    
    @IBAction func btnConfirmTapped(_ sender : UIButton){
        if let errorMessage = self.checkValidation(){
            
            GFunctions.shared.showSnackBar(message: errorMessage)
        }
        else{
            
            let viewModel = ForgotPasswordVM()
            let parameters = APIParametersModel()
            parameters.email = JSON(self.txtEmail.text as Any).stringValue
            viewModel.callAPIForgotPassword(parameters: parameters) { responseJSON, statucCode, message, completion in
                
                if completion{
                    
                    self.closePopUpVisiable(isCompletion: true)
                    
                }
                GFunctions.shared.showSnackBar(message: message!)
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
extension ForgotPasswordVC : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.buttonEnableDisable()
    }
}
