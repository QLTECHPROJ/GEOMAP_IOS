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
        
        let tapGestureToFace = UITapGestureRecognizer(target: self, action: #selector(self.selectPhoto(_:)))
        self.imgFront.isUserInteractionEnabled = true
        self.imgFront.addGestureRecognizer(tapGestureToFace)
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

//----------------------------------------------------------------------------
//MARK: - Image Upload
//----------------------------------------------------------------------------
extension AddOpenCastMappingImagesVC{
    
    @objc func selectPhoto(_ gesture : UIGestureRecognizer){
        if checkInternet(showToast: true) == false {
            return
        }
        
        self.view.endEditing(true)
        let arrayTitles = [kTakeAPhoto, kChooseFromGallary]
        
        
        showActionSheet(title: "", message: Theme.strings.profile_image_options, titles: arrayTitles, cancelButtonTitle: Theme.strings.cancel_small) { (buttonTitle) in
            DispatchQueue.main.async {
                self.handleImageOptions(buttonTitle: buttonTitle)
            }
        }
    }
    
    
    //MARK:- IMAGE UPLOAD
    func handleImageOptions(buttonTitle : String) {
        
        
        switch buttonTitle {
        case kTakeAPhoto:
            DispatchQueue.main.async {
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                    let picker = UIImagePickerController()
                    picker.sourceType = .camera
                    picker.delegate = self
                    picker.allowsEditing = true
                    self.present(picker, animated: true, completion: nil)
                } else {
                    //                    showAlertToast(message: Theme.strings.alert_camera_not_available)
                    GFunctions.shared.showSnackBar(message: kAlert_camera_not_available)
                }
            }
        case kChooseFromGallary:
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            }
        case kRemovePhoto:
            print("Remove photo")
            LoginDataModel.currentUser?.profileInformation?.profileimage = ""
        default:
            break
        }
    }

}
    
    
//----------------------------------------------------------------------------
//MARK: - UIImagePickerControllerDelegate Methods
//----------------------------------------------------------------------------
extension AddOpenCastMappingImagesVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            
            self.imgFront.image = image
            
        }
        else if let image = info[.originalImage] as? UIImage {
            
            self.imgFront.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
