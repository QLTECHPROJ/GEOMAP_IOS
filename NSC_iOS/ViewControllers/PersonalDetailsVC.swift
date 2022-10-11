//
//  PersonalDetailsVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 06/05/22.
//

import UIKit

class PersonalDetailsVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    // TextFields
    @IBOutlet weak var txtDOB: DJPickerView!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtPostCode: UITextField!
    @IBOutlet weak var txtCamps: UITextField!
    @IBOutlet weak var txtRole: UITextField!
    
    // Error Labels
    @IBOutlet weak var lblErrDOB: UILabel!
    @IBOutlet weak var lblErrStreet: UILabel!
    @IBOutlet weak var lblErrState: UILabel!
    @IBOutlet weak var lblErrCity: UILabel!
    @IBOutlet weak var lblErrPostCode: UILabel!
    @IBOutlet weak var lblErrCamps: UILabel!
    @IBOutlet weak var lblErrRole: UILabel!
    @IBOutlet weak var lblErrVaccinated: UILabel!
    
    // Vaccinated - Yes / No
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    
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
        
        btnBack.isHidden = !isFromEdit
        
        setupUI()
        setupData()
        setupInitialData()
        
        self.fetchCoachDetails {
            self.setupInitialData()
        }
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
        arrayErrorLabels = [lblErrDOB, lblErrStreet, lblErrState, lblErrCity, lblErrPostCode, lblErrCamps, lblErrRole, lblErrVaccinated]
        
        for label in arrayErrorLabels {
            label.isHidden = true
        }
        
        btnYes.setImage(UIImage(named: "CheckDeselect"), for: .normal)
        btnNo.setImage(UIImage(named: "CheckDeselect"), for: .normal)
        
        txtState.isEnabled = false
        txtCity.isEnabled = false
        txtCamps.isEnabled = false
        txtRole.isEnabled = false
    }
    
    override func setupData() {
        if vaccinated == "1" {
            btnYes.setImage(UIImage(named: "CheckSelect"), for: .normal)
            btnNo.setImage(UIImage(named: "CheckDeselect"), for: .normal)
        } else if vaccinated == "0" {
            btnYes.setImage(UIImage(named: "CheckDeselect"), for: .normal)
            btnNo.setImage(UIImage(named: "CheckSelect"), for: .normal)
        }
        
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
        
        if let strName = selectedCamps?.Name {
            txtCamps.text = strName
        } else {
            txtCamps.text = ""
        }
        
        if let strName = selectedRole?.Name {
            txtRole.text = strName
        } else {
            txtRole.text = ""
        }
        
        initDOBPickerView()
        buttonEnableDisable()
    }
    
    func setupInitialData() {
        if let userData = LoginDataModel.currentUser {
            if userData.Address.trim.count > 0 {
                txtStreet.text = userData.Address
            }
            
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
            
            if userData.PostCode.trim.count > 0 {
                txtPostCode.text = userData.PostCode
            }
            
            if self.vaccinated.trim.count == 0 {
                vaccinated = userData.Vaccinated
            }
        }
        
        setupData()
    }
    
    private func initDOBPickerView() {
        let prevDate = Calendar.current.date(byAdding: .year, value: -14, to: Date()) ?? Date()
        selectedDOB = prevDate
        
        var dob : Date?
        
        txtDOB.type = .date
        txtDOB.pickerDelegate = self
        txtDOB.datePicker?.datePickerMode = .date
        txtDOB.datePicker?.maximumDate = prevDate
        txtDOB.dateFormatter.dateFormat = Theme.dateFormats.DOB_App
        
        let strDOB = LoginDataModel.currentUser?.DOB ?? ""
        
        if strDOB.count > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Theme.dateFormats.DOB_App
            dob = dateFormatter.date(from: strDOB)
            selectedDOB = dob ?? Date()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Theme.dateFormats.DOB_App
        dateFormatter.timeZone = TimeZone.current
        
        if let DOB = dob {
            txtDOB.text = dateFormatter.string(from: DOB)
            txtDOB.datePicker?.date = DOB
        } else {
            txtDOB.text = dateFormatter.string(from: prevDate)
            txtDOB.datePicker?.date = prevDate
        }
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
    
    override func buttonEnableDisable() {
        var shouldEnable = true
        
        if txtStreet.text?.trim.count == 0 || txtPostCode.text?.trim.count == 0 || vaccinated.trim.count == 0 {
            shouldEnable = false
        }
        
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
        let strStreet = txtStreet.text?.trim ?? ""
        let strPostCode = txtPostCode.text?.trim ?? ""
        
        if txtDOB.text?.trim.count == 0 || selectedDOB.differenceWith(Date(), inUnit: NSCalendar.Unit.year) < 14 {
            isValid = false
            lblErrDOB.isHidden = false
            lblErrDOB.text = Theme.strings.alert_dob_error
        }
        
        if strStreet.count == 0 {
            isValid = false
            lblErrStreet.isHidden = false
            lblErrStreet.text = Theme.strings.alert_blank_street_error
        }
        
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
        
        if strPostCode.count == 0 {
            isValid = false
            lblErrPostCode.isHidden = false
            lblErrPostCode.text = Theme.strings.alert_invalid_postcode_error
        } else if strPostCode.count < AppVersionDetails.postCodeMinDigits || strPostCode.count > AppVersionDetails.postCodeMaxDigits {
            isValid = false
            lblErrPostCode.isHidden = false
            lblErrPostCode.text = Theme.strings.alert_invalid_postcode_error
        } else if strPostCode.isNumber == false {
            isValid = false
            lblErrPostCode.isHidden = false
            lblErrPostCode.text = Theme.strings.alert_invalid_postcode_error
        }
        
        if selectedCamps == nil {
            isValid = false
            lblErrCamps.isHidden = false
            lblErrCamps.text = Theme.strings.alert_select_sport
        }
        
        if selectedRole == nil {
            isValid = false
            lblErrRole.isHidden = false
            lblErrRole.text = Theme.strings.alert_select_role
        }
        
        if vaccinated.trim.count == 0 {
            isValid = false
            lblErrVaccinated.isHidden = false
            lblErrVaccinated.text = Theme.strings.alert_blank_vaccination_error
        }
        
        return isValid
    }
    
    override func goNext() {
        let coachDetailVM = CoachDetailViewModel()
        coachDetailVM.callCoachDetailsAPI { success in
            
            self.fetchCoachDetails()
            
            if self.isFromEdit {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.handleLoginUserRedirection()
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
    
    @IBAction func vaccinatedOptionClicked(_ sender: UIButton) {
        if sender == btnYes {
            vaccinated = "1"
        } else {
            vaccinated = "0"
        }
        
        setupData()
    }
    
    @IBAction func confirmClicked(_ sender: UIButton) {
        if checkValidation() {
            for label in arrayErrorLabels {
                label.isHidden = true
            }
            
            var parameters = ["coachId":LoginDataModel.currentUser?.ID ?? "",
                              "dob":txtDOB.text ?? "",
                              "country":AppVersionDetails.countryCode,
                              "state":selectedState?.ID ?? "",
                              "city":selectedCity?.ID ?? ""]
            
            parameters["address"] = txtStreet.text ?? ""
            parameters["postCode"] = txtPostCode.text ?? ""
            parameters["role"] = selectedRole?.ID ?? ""
            parameters["vaccinated"] = vaccinated
            parameters["sport_id"] = selectedCamps?.ID ?? ""
            
            let personalDetailVM = PersonalDetailViewModel()
            personalDetailVM.callUpdatePersonalDetailsAPI(parameters: parameters) { success in
                if success {
                    self.goNext()
                }
            }
        }
    }
    
}


// MARK: - UITextFieldDelegate
extension PersonalDetailsVC : UITextFieldDelegate {
    
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
        
        if textField == txtStreet && updatedText.count > 100 {
            return false
        } else if textField == txtPostCode {
            if !updatedText.isNumber || updatedText.count > AppVersionDetails.postCodeMaxDigits {
                return false
            }
        }
        
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
extension PersonalDetailsVC : DJPickerViewDelegate {
    
    func textPickerView(_ textPickerView: DJPickerView, didSelectDate date: Date) {
        self.view.endEditing(true)
        print("DOB :- ",date)
        selectedDOB = date
    }
    
}
