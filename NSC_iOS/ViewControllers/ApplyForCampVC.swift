//
//  ApplyForCampVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 13/05/22.
//

import UIKit

class ApplyForCampVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnApply: UIButton!
    
    
    // MARK: - VARIABLES
    var maxCount = 3
    var arrayCamp = [ApplyCampModel]()
    var arrayCampSearch = [ApplyCampModel]()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        buttonEnableDisable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let applyForACampVM = ApplyForACampViewModel()
        applyForACampVM.callItemListAPI { success in
            if success {
                self.maxCount = applyForACampVM.maxCount
                self.arrayCamp = applyForACampVM.arrayCamps ?? [ApplyCampModel]()
                self.setupData()
            }
        }
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
        tableView.register(nibWithCellClass: ApplyForCampCell.self)
        
        btnClear.isHidden = true
        lblNoData.isHidden = true
        
        lblNoData.isHidden = true
        lblNoData.text = Theme.strings.no_camps_to_display
        lblNoData.textColor = Theme.colors.textColor
        
        txtSearch.placeholder = Theme.strings.search_camps
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(textFieldValueChanged(textField:)), for: UIControl.Event.editingChanged)
        
        tableView.reloadData()
    }
    
    override func setupData() {
        arrayCampSearch = arrayCamp
        tableView.reloadData()
        
        lblNoData.isHidden = arrayCampSearch.count != 0
        tableView.isHidden = arrayCampSearch.count == 0
        
        buttonEnableDisable()
    }
    
    @objc func textFieldValueChanged(textField : UITextField ) {
        btnClear.isHidden = textField.text?.count == 0
    }
    
    override func buttonEnableDisable() {
        let count = arrayCamp.filter({ $0.Selected == "1" }).count
        
        DispatchQueue.main.async {
            if count > 0 {
                self.btnApply.isUserInteractionEnabled = true
                self.btnApply.backgroundColor = Theme.colors.theme_dark
            } else {
                self.btnApply.isUserInteractionEnabled = false
                self.btnApply.backgroundColor = Theme.colors.gray_7E7E7E
            }
        }
    }
    
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender : UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearSearchClicked(_ sender: UIButton) {
        txtSearch.text = ""
        arrayCampSearch = arrayCamp
        btnClear.isHidden = true
        lblNoData.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    @IBAction func applyClicked(_ sender : UIButton) {
        self.view.endEditing(true)
        
        let selectedCamps = arrayCamp.filter({ $0.Selected == "1" })
        let selectedIDs = selectedCamps.map({ $0.ID })
        
        if selectedIDs.count > 0 {
            let strCampIDs = selectedIDs.joined(separator: ",")
            print("selectedIDs - \(strCampIDs)")
            
            let saveAppliedCampsVM = SaveAppliedCampsViewModel()
            saveAppliedCampsVM.callSaveAppliedCampsAPI(campIds: strCampIDs) { success in
                if success {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            showAlertToast(message: Theme.strings.alert_select_camp)
        }
    }
    
}


// MARK: - UITextFieldDelegate
extension ApplyForCampVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            print("Search text :- ",updatedText)
            
            arrayCampSearch = arrayCamp.filter({ (model:ApplyCampModel) -> Bool in
                return model.Name.lowercased().contains(updatedText.lowercased())
            })
            
            if updatedText.trim.count == 0 {
                arrayCampSearch = arrayCamp
            }
            
            if arrayCampSearch.count > 0 {
                lblNoData.isHidden = true
            } else {
                lblNoData.isHidden = false
                lblNoData.text = Theme.strings.alert_search_term_not_found
            }
            
            lblNoData.isHidden = arrayCampSearch.count != 0
            tableView.isHidden = arrayCampSearch.count == 0
            tableView.reloadData()
        }
        
        return true
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ApplyForCampVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCampSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ApplyForCampCell.self)
        cell.configureSelectionCell(data: arrayCampSearch[indexPath.row])
        cell.lblSeparator.isHidden = (indexPath.row == arrayCampSearch.count - 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrayCampSearch[indexPath.row].Selected == "1" {
            arrayCampSearch[indexPath.row].Selected = "0"
        } else {
            let count = arrayCamp.filter({ $0.Selected == "1" }).count
            
            if count < maxCount {
                arrayCampSearch[indexPath.row].Selected = "1"
            } else {
                showAlertToast(message: "You can pick up to \(self.maxCount) camps. They can be changed anytime.")
            }
        }
        
        tableView.reloadData()
        buttonEnableDisable()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
}
