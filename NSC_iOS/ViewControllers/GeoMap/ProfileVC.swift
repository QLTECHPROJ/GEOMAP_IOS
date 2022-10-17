//
//  ProfileVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 26/04/22.
//

import UIKit
import SDWebImage

class ProfileVC: BaseViewController {
    
    // MARK: - OUTLETS
    // UIImage
    @IBOutlet weak var imgUser: UIImageView!
    
    // UITextfield
    @IBOutlet weak var txtFMobileNo: UITextField!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtFEmailAdd: UITextField!
    
    // UIButton
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    
    // UILabel
    @IBOutlet weak var lblErrLastName: UILabel!
    @IBOutlet weak var lblErrName: UILabel!
    @IBOutlet weak var lblErrMobileNo: UILabel!
    @IBOutlet weak var lblErrEmail: UILabel!
    
    
    // MARK: - VARIABLES
    var isFromEdit = false
    var strImage : String?
    var imageData = UploadDataModel()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
        
    }
    
    override func setupData() {
      
    }
    
    //MARK:- IMAGE UPLOAD
    func handleImageOptions(buttonTitle : String) {
        switch buttonTitle {
        case Theme.strings.take_a_photo:
            DispatchQueue.main.async {
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                    let picker = UIImagePickerController()
                    picker.sourceType = .camera
                    picker.delegate = self
                    picker.allowsEditing = true
                    self.present(picker, animated: true, completion: nil)
                } else {
                    showAlertToast(message: Theme.strings.alert_camera_not_available)
                }
            }
        case Theme.strings.choose_from_gallary:
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            }
        case Theme.strings.remove_photo:
            print("Remove photo")
            LoginDataModel.currentUser?.Profile_Image = ""
        default:
            break
        }
        
    }
    
    
    // MARK: - ACTION
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateClicked(_ sender: UIButton) {
       
    }
    
    @IBAction func editClicked(_ sender: UIButton) {
        if checkInternet(showToast: true) == false {
            return
        }
        
        self.view.endEditing(true)
        let arrayTitles = [Theme.strings.take_a_photo, Theme.strings.choose_from_gallary]
        //        if let imageStr = LoginDataModel.currentUser?.Profile_Image, imageStr.trim.count > 0 {
        //            arrayTitles.append(Theme.strings.remove_photo)
        //        }
        
        showActionSheet(title: "", message: Theme.strings.profile_image_options, titles: arrayTitles, cancelButtonTitle: Theme.strings.cancel_small) { (buttonTitle) in
            DispatchQueue.main.async {
                self.handleImageOptions(buttonTitle: buttonTitle)
            }
        }
    }
    @IBAction func onTappedDeleteAccount(_ sender: UIButton) {
        
        if checkInternet(showToast: true) == false {
            return
        }
        
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: AlertPopUpVC.self)
        aVC.titleText = Theme.strings.deleteCoach
        aVC.detailText = Theme.strings.delete_user_alert_title
        aVC.firstButtonTitle = Theme.strings.ok
        aVC.secondButtonTitle = Theme.strings.close
        aVC.modalPresentationStyle = .overFullScreen
        aVC.delegate = self
        self.present(aVC, animated: false, completion: nil)
        
    }
    
}

// MARK: - UITextFieldDelegate
extension ProfileVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lblErrName.isHidden = true
        lblErrMobileNo.isHidden = true
        lblErrEmail.isHidden = true
        lblErrLastName.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return false
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        if textField == txtFName || textField == txtLName {
            if updatedText.count > 16 {
                return false
            }
        } else if textField == txtFMobileNo {
            if !updatedText.isNumber || updatedText.count > AppVersionDetails.mobileMaxDigits {
                return false
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.buttonEnableDisable()
    }
    
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            imgUser.image = image
            
            imageData = UploadDataModel(name: "image.jpeg", key: "profileImage", data: image.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            self.strImage = imageData.name
            
            self.buttonEnableDisable()
            
        } else if let image = info[.originalImage] as? UIImage {
            imgUser.image = image
            imageData = UploadDataModel(name: "image.jpeg", key: "profileImage", data: image.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            self.strImage = imageData.name
            
            self.buttonEnableDisable()
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - AlertPopUpVCDelegate
extension ProfileVC : AlertPopUpVCDelegate {
    
    func handleAction(sender: UIButton, popUpTag: Int) {
        if sender.tag == 0 {
            if checkInternet(showToast: true) == false {
                return
            }
            
            let deleteCoachVM = DeleteCoachViewModel()
            deleteCoachVM.callDeleteCoachAPI(completion: { success in
                APPDELEGATE.logout()
            })
            
        }
    }
    
}


