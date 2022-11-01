//
//  ProfileVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 26/04/22.
//

import UIKit
import SDWebImage

class ProfileVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    // UIImage
    @IBOutlet weak var imgUser: ImageThemeBorderClass!
    
    @IBOutlet weak var imgCamara: UIImageView!
    
    // UITextfield
    
    @IBOutlet weak var txtName: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtMobile: ACFloatingTextfield!
    @IBOutlet weak var txtDOB: ACFloatingTextfield!
    
    
    // UIButton
    @IBOutlet weak var btnConfirm: AppThemeBlueButton!
    @IBOutlet weak var btnDeleteAccount: AppThemeBorderBlueButton!
    
   
    // MARK: - VARIABLES
    var isFromEdit = false
    var strImage : String?
    var imageData = UploadDataModel()
    
    let bodDatePicker = UIDatePicker()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        
        self.view.backgroundColor = .colorBGSkyBlueLight
        self.txtName.applyStyleFlotingTextfield(placeholderTitle : kName, fontsize : 16,fontname : .InterSemibol)
        self.txtEmail.applyStyleFlotingTextfield(placeholderTitle : kEmail, fontsize : 16, fontname : .InterSemibol)
        self.txtMobile.applyStyleFlotingTextfield(placeholderTitle : kMobile, fontsize : 16,fontname : .InterSemibol)
        self.txtDOB.applyStyleFlotingTextfield(placeholderTitle : kDOB, fontsize : 16, fontname : .InterSemibol)
        
        self.btnConfirm.setTitle(kConfirm, for: .normal)
        self.btnDeleteAccount.setTitle(kDeleteAccount, for: .normal)
        
        self.setupData()
        self.buttonEnableDisable()
        self.initDatePicker()

        
        let tapGestureToChooseProfile1 = UITapGestureRecognizer(target: self, action: #selector(self.selectProfilePicture(_:)))
        self.imgUser.isUserInteractionEnabled = true
        self.imgUser.addGestureRecognizer(tapGestureToChooseProfile1)
        
        let tapGestureToChooseProfile2 = UITapGestureRecognizer(target: self, action: #selector(self.selectProfilePicture(_:)))
        self.imgCamara.isUserInteractionEnabled = true
        self.imgCamara.addGestureRecognizer(tapGestureToChooseProfile2)
    }
    
    func setupData() {
        self.imgUser.image = UIImage(named: "profile1")
        self.txtName.text = "John Doe"
        self.txtEmail.text = "johndoe@gmail.com"
        self.txtMobile.text = "3253534534"
        self.txtDOB.text = "12 Jun 1994"
    }
    
    func initDatePicker(){
        self.bodDatePicker.datePickerMode = .date
        self.bodDatePicker.maximumDate = Date()
        self.txtDOB.inputView = self.bodDatePicker
        
        if #available(iOS 14, *) {// Added condition for iOS 14
            self.bodDatePicker.preferredDatePickerStyle  = .wheels
            self.bodDatePicker.sizeToFit()
        }
        
        let dateFormattor = DateFormatter()
        dateFormattor.dateFormat = DateTimeFormaterEnum.ddmm_yyyy.rawValue
        self.bodDatePicker.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateTimeFormaterEnum.ddmm_yyyy.rawValue
        self.txtDOB.text = dateFormatter.string(from: sender.date)
        
    }
    
    func checkValidation() -> String? {
        self.view.endEditing(true)
        var message : String? = nil
        
        if self.txtName.text!.trim.count < Validations.UserNameLenght.Minimum.rawValue || self.txtName.text!.trim.count > Validations.UserNameLenght.Maximum.rawValue {
            
            message = kEnterValidName
        }
        else if !self.txtEmail.text!.trim.isValidEmail{
            
            message = kPleaseProvideValidEmailAddress
        }
        else if !self.txtMobile.text!.trim.isEmpty && (self.txtMobile.text?.count)! < Validations.PhoneNumber.Minimum.rawValue{
            
            message = kPleaseProvideValidMobileNumber
        }
        else if self.txtDOB.text!.trim.isEmpty{
            
            message = kPleaseProvideDOB
        }
        return message
    }
    
    
   @objc func selectProfilePicture(_ gesture : UIGestureRecognizer){
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
                    showAlertToast(message: Theme.strings.alert_camera_not_available)
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
            LoginDataModel.currentUser?.Profile_Image = ""
        default:
            break
        }
        
    }
    
    
    // MARK: - ACTION
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnConfirmTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if let errorMessage = self.checkValidation(){
            GFunctions.shared.showSnackBar(message: errorMessage)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }

    
    func buttonEnableDisable(){
        
        self.btnConfirm.isSelect = !self.txtName.text!.isEmpty && !self.txtEmail.text!.isEmpty && !self.txtMobile.text!.isEmpty && !self.txtDOB.text!.isEmpty
    }
    
    @IBAction func btnDeleteAccountTapped(_ sender: UIButton) {
        
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
//        self.present(aVC, animated: false, completion: nil)
        self.present(aVC, animated: false, completion :{
            aVC.openPopUpVisiable()
        })
        
    }
    
}

// MARK: - UITextFieldDelegate
extension ProfileVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
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
        else if textField == self.txtMobile{
            
            if (self.txtMobile.text?.count)! == Validations.PhoneNumber.Maximum.rawValue {
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
//        self.buttonEnableDisable()
    }
    
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            imgUser.image = image
            
            imageData = UploadDataModel(name: "image.jpeg", key: "profileImage", data: image.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            self.strImage = imageData.name
            
//            self.buttonEnableDisable()
            
        } else if let image = info[.originalImage] as? UIImage {
            imgUser.image = image
            imageData = UploadDataModel(name: "image.jpeg", key: "profileImage", data: image.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            self.strImage = imageData.name
            
//            self.buttonEnableDisable()
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
//                APPDELEGATE.logout()
                AppDelegate.shared.updateWindow()
            })
            
        }
    }
    
}

