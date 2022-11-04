//
//  UploadUnderMappingImagesVC.swift
//  NSC_iOS
//
//  Created by vishal parmar on 27/10/22.
//

import UIKit

class UploadUnderMappingImagesVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    
    @IBOutlet weak var imgRoof : UIImageView!
    @IBOutlet weak var imgFace : UIImageView!
    @IBOutlet weak var imgLeft : UIImageView!
    @IBOutlet weak var imgRight : UIImageView!
    
    
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
        
        self.imgRoof.backgroundColor = .colorSkyBlue
        self.imgLeft.backgroundColor = .colorSkyBlue
        self.imgRight.backgroundColor = .colorSkyBlue
        self.imgFace.backgroundColor = .colorSkyBlue
        
        self.imgRoof.tag = 1
        self.imgLeft.tag = 2
        self.imgRight.tag = 3
        self.imgFace.tag = 4
        
        self.imgRoof.layer.cornerRadius = 30
        self.imgLeft.layer.cornerRadius = 30
        self.imgRight.layer.cornerRadius = 30
        self.imgFace.layer.cornerRadius = 30
        
        self.btnSubmit.setTitle(kSubmit, for: .normal)
        self.btnSubmit.isSelect = true
        
        let tapGestureToRoof = UITapGestureRecognizer(target: self, action: #selector(self.selectPhoto(_:)))
        self.imgRoof.isUserInteractionEnabled = true
        tapGestureToRoof.view?.tag = self.imgRoof.tag
        self.imgRoof.addGestureRecognizer(tapGestureToRoof)
        
        let tapGestureToLeft = UITapGestureRecognizer(target: self, action: #selector(self.selectPhoto(_:)))
        self.imgLeft.isUserInteractionEnabled = true
        tapGestureToLeft.view?.tag = self.imgLeft.tag
        self.imgLeft.addGestureRecognizer(tapGestureToLeft)
        
        let tapGestureToRight = UITapGestureRecognizer(target: self, action: #selector(self.selectPhoto(_:)))
        self.imgRight.isUserInteractionEnabled = true
        tapGestureToRight.view?.tag = self.imgRight.tag
        self.imgRight.addGestureRecognizer(tapGestureToRight)
        
        let tapGestureToFace = UITapGestureRecognizer(target: self, action: #selector(self.selectPhoto(_:)))
        self.imgFace.isUserInteractionEnabled = true
        tapGestureToFace.view?.tag = self.imgFace.tag
        self.imgFace.addGestureRecognizer(tapGestureToFace)
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
//MARK: - Image Upload
//----------------------------------------------------------------------------
extension UploadUnderMappingImagesVC{
    
    @objc func selectPhoto(_ gesture : UIGestureRecognizer){
        if checkInternet(showToast: true) == false {
            return
        }
        
        self.view.endEditing(true)
        let arrayTitles = [kTakeAPhoto, kChooseFromGallary]
        
        
        showActionSheet(title: "", message: Theme.strings.profile_image_options, titles: arrayTitles, cancelButtonTitle: Theme.strings.cancel_small) { (buttonTitle) in
            DispatchQueue.main.async {
                self.handleImageOptions(buttonTitle: buttonTitle, tag: gesture.view!.tag)
            }
        }
    }
    
    
    //MARK:- IMAGE UPLOAD
    func handleImageOptions(buttonTitle : String,tag : Int) {
        
        
        switch buttonTitle {
        case kTakeAPhoto:
            DispatchQueue.main.async {
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                    let picker = UIImagePickerController()
                    picker.navigationBar.tag = tag
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
                picker.navigationBar.tag = tag
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
    
    func setPhoto(_ tag : Int, _ selectedImage : UIImage){
        if tag == self.imgRoof.tag{
            self.imgRoof.image = selectedImage
        }
        
        if tag == self.imgLeft.tag{
            self.imgLeft.image = selectedImage
        }
        
        if tag == self.imgRight.tag{
            self.imgRight.image = selectedImage
        }
        
        if tag == self.imgFace.tag{
            self.imgFace.image = selectedImage
        }
    }
}
    
    
//----------------------------------------------------------------------------
//MARK: - UIImagePickerControllerDelegate Methods
//----------------------------------------------------------------------------
extension UploadUnderMappingImagesVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            
            self.setPhoto(picker.navigationBar.tag, image)
            
        }
        else if let image = info[.originalImage] as? UIImage {
            
            self.setPhoto(picker.navigationBar.tag, image)
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

