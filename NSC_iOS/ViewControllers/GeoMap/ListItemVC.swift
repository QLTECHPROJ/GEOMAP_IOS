//
//  CountryListVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 07/05/22.
//

import UIKit

enum ListItemType : Int {
    case country = 0
    case state
    case city
    case sport
    case role
}

class ListItemVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    
    
    // MARK: - VARIABLES
    var listType : ListItemType = .country
    var strID = ""
    var strNoData = Theme.strings.alert_search_term_not_found
    
    var arrayItem = [ListItem]()
    var arrayItemSearch = [ListItem]()
    var didSelectItem : ((ListItem) -> Void)?
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let listDataVM = ListDataViewModel()
        listDataVM.callItemListAPI(strID: self.strID, listType: self.listType) { success in
            if success {
                self.arrayItem = listDataVM.listItemData ?? [ListItem]()
            }
            self.setupData()
        }
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        btnClear.isHidden = true
        lblNoData.isHidden = true
        
        switch listType {
        case .country:
            lblTitle.text = "Choose your country"
            txtSearch.placeholder = "Search for country"
        case .state:
            lblTitle.text = "Choose your state"
            txtSearch.placeholder = "Search for state"
        case .city:
            lblTitle.text = "Choose your city"
            txtSearch.placeholder = "Search for city"
        case .sport:
            lblTitle.text = "Choose your sport"
            txtSearch.placeholder = "Search for sport"
        case .role:
            lblTitle.text = "Choose your role"
            txtSearch.placeholder = "Search for role"
        }
        
        if checkInternet(showToast: true) == false {
            txtSearch.isUserInteractionEnabled = false
            lblNoData.isHidden = true
        } else {
            txtSearch.isUserInteractionEnabled = true
            lblNoData.isHidden = false
            lblNoData.text = strNoData
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        viewBackground.addGestureRecognizer(tapGesture)
        viewBackground.isUserInteractionEnabled = true
        
        tableView.register(nibWithCellClass: ListItemCell.self)
        tableView.reloadData()
        
        txtSearch.addTarget(self, action: #selector(textFieldValueChanged(textField:)), for: UIControl.Event.editingChanged)
    }
    
    func setupData() {
        arrayItemSearch = arrayItem
        tableView.reloadData()
        lblNoData.isHidden = arrayItemSearch.count != 0
        tableView.isHidden = arrayItemSearch.count == 0
    }
    
    @objc func textFieldValueChanged(textField : UITextField ) {
        btnClear.isHidden = textField.text?.count == 0
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - ACTIONS
    @IBAction func clearSearchClicked(_ sender: UIButton) {
        txtSearch.text = ""
        arrayItemSearch = arrayItem
        btnClear.isHidden = true
        lblNoData.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
}


// MARK: - UITextFieldDelegate
extension ListItemVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string).trim
            arrayItemSearch = arrayItem.filter({ (model:ListItem) -> Bool in
                return model.Name.lowercased().contains(updatedText.lowercased())
            })
            
            if updatedText.trim.count == 0 {
                arrayItemSearch = arrayItem
            }
            
            if arrayItemSearch.count > 0 {
                lblNoData.isHidden = true
            } else {
                lblNoData.isHidden = false
                lblNoData.text = strNoData // "Couldn't find " + updatedText + " Try searching again"
            }
            lblNoData.isHidden = arrayItemSearch.count != 0
            tableView.isHidden = arrayItemSearch.count == 0
            tableView.reloadData()
        }
        
        return true
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListItemVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItemSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ListItemCell.self)
        cell.configureCell(data: arrayItemSearch[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem?(arrayItemSearch[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
}
