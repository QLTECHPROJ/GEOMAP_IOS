//
//  PersonalDetailsVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 06/05/22.
//

import UIKit

class UGGeoAttributeVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    // TextFields
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    
    // Error Labels
    @IBOutlet weak var lblErrState: UILabel!
    @IBOutlet weak var lblErrCity: UILabel!
    // Vaccinated - Yes / No

    // MARK: - VARIABLES
    var isFromEdit = false
    var arrayErrorLabels = [UILabel]()
    
    var selectedDOB = Date()
    var selectedState : ListItem?
    var selectedCity : ListItem?
    var selectedCamps : ListItem?
    var selectedRole : ListItem?
    var vaccinated = ""
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        arrayErrorLabels = [ lblErrState, lblErrCity]
        
        for label in arrayErrorLabels {
            label.isHidden = true
        }
        
        txtState.isEnabled = false
        txtCity.isEnabled = false
    }
    
    func setupData() {
        
        if let strName = selectedState?.Name {
            txtState.text = strName
        } else {
            txtState.text = ""
        }
        
        if let strName = selectedCity?.Name {
            txtCity.text = strName
        } else {
            txtCity.text = ""
        }
        
        buttonEnableDisable()
    }
    
    func setupInitialData() {
        if let userData = LoginDataModel.currentUser {
           
            if userData.State.trim.count > 0 && userData.StateName.trim.count > 0 {
                selectedState = ListItem(id: userData.State, name: userData.StateName)
            }
            
            if userData.City.trim.count > 0 && userData.CityName.trim.count > 0 {
                selectedCity = ListItem(id: userData.City, name: userData.CityName)
            }
            
            if userData.SportId.trim.count > 0 && userData.SportName.trim.count > 0 {
                selectedCamps = ListItem(id: userData.SportId, name: userData.SportName)
            }
            
            if userData.RoleId.trim.count > 0 && userData.Role.trim.count > 0 {
                selectedRole = ListItem(id: userData.RoleId, name: userData.Role)
            }
            
        }
        
        setupData()
    }
    
   
    
    func setSelectedListItem(listType : ListItemType ,selectedItem : ListItem) {
        switch listType {
        case .state:
            self.selectedState = selectedItem
            self.selectedCity = nil
        case .city:
            self.selectedCity = selectedItem
        case .sport:
            self.selectedCamps = selectedItem
        case .role:
            self.selectedRole = selectedItem
        default:
            break
        }
        
        self.setupData()
    }
    
    func buttonEnableDisable() {
        var shouldEnable = true
        
        
        if selectedState == nil || selectedCity == nil || selectedCamps == nil || selectedRole == nil {
            shouldEnable = false
        }
        
        if shouldEnable {
            btnConfirm.isUserInteractionEnabled = true
            btnConfirm.backgroundColor = Theme.colors.theme_dark
        } else {
            btnConfirm.isUserInteractionEnabled = false
            btnConfirm.backgroundColor = Theme.colors.gray_7E7E7E
            btnConfirm.removeGradient()
        }
    }
    
    func checkValidation() -> Bool {
        var isValid = true
        
        if selectedState == nil {
            isValid = false
            lblErrState.isHidden = false
            lblErrState.text = Theme.strings.alert_select_state
        }
        
        if selectedCity == nil {
            isValid = false
            lblErrCity.isHidden = false
            lblErrCity.text = Theme.strings.alert_select_city
        }
        
        return isValid
    }
    
    func goNext() {
        let coachDetailVM = CoachDetailViewModel()
        coachDetailVM.callCoachDetailsAPI { success in
            
//            self.fetchCoachDetails()
            
            if self.isFromEdit {
                self.navigationController?.popViewController(animated: true)
            } else {
//                self.handleLoginUserRedirection()
            }
        }
    }
    
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func listViewClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let listType = ListItemType(rawValue: sender.tag) ?? .state
        var strID = ""
        
        switch listType {
        case .country:
            break
        case .state:
            strID = AppVersionDetails.countryID
        case .city:
            if selectedState == nil {
                showAlertToast(message: "Please select state first")
                return
            }
            strID = selectedState?.ID ?? ""
        case .sport:
            break
        case .role:
            break
        }
        
        let aVC = AppStoryBoard.main.viewController(viewControllerClass:ListItemVC.self)
        aVC.listType = listType
        aVC.strID = strID
        aVC.didSelectItem = { selectedItem in
            self.setSelectedListItem(listType: listType, selectedItem: selectedItem)
        }
        aVC.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(aVC, animated: true, completion: nil)
    }
    
    @IBAction func confirmClicked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: UGGeoAttributeVC2.self)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
}


// MARK: - UITextFieldDelegate
extension UGGeoAttributeVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for label in arrayErrorLabels {
            label.isHidden = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
              let textRange = Range(range, in: text) else {
            return false
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        buttonEnableDisable()
    }
    
}


// MARK: - DJPickerViewDelegate
extension UGGeoAttributeVC : DJPickerViewDelegate {
    
    func textPickerView(_ textPickerView: DJPickerView, didSelectDate date: Date) {
        self.view.endEditing(true)
        print("DOB :- ",date)
        selectedDOB = date
    }
    
}
