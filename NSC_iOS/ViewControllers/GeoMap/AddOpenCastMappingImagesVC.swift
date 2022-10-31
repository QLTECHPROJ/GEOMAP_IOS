//
//  AddOpenCastMappingImagesVC.swift
//  NSC_iOS
//
//  Created by vishal parmar on 27/10/22.
//

import UIKit
import IQKeyboardManagerSwift

class AddOpenCastMappingImagesVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    
    @IBOutlet weak var imgFront : UIImageView!
    @IBOutlet weak var tvDescription : IQTextView!
    
   
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

        self.title = kGeologicalMapping
        
        self.imgFront.backgroundColor = .colorSkyBlue
       
        self.imgFront.layer.cornerRadius = 30
       
        self.tvDescription.applyTextViewStyle(placeholderText : kAddDescripstion, fontSize : 16,fontName : .InterSemibol,placeholerColor : .colorTextPlaceHolderGray)
        
        self.buttonEnableDisable()
        self.btnSubmit.setTitle(kSubmit, for: .normal)
        self.btnSubmit.isSelect = true
    }
 
    func buttonEnableDisable(){
        
        var isEnable : Bool = false
        
        if !self.tvDescription.text!.trim.isEmpty{
            
            isEnable = true
        }
        self.btnSubmit.isSelect = isEnable
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitTapped(_ sender : UIButton){
        self.view.endEditing(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            AppDelegate.shared.updateWindow(.home)
        }
    }
    
    
    
    
    //----------------------------------------------------------------------------
    //MARK:- View life cycle
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

//--------------------------------------------------------------------------------------
// MARK: - UITextFieldDelegate

extension AddOpenCastMappingImagesVC : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.buttonEnableDisable()
    }
}
