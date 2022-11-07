//
//  CountryListVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 07/05/22.
//

import UIKit

enum ListItemType {
    
    case attributes
    case Nos
    case sampleCollected
    case weathering
    case rockStrenght
    case waterCollection
    case typeOfGeologicalStructure
    case typeOfFaults
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
    var listType : ListItemType = .attributes
    var strID = ""
    var strNoData = Theme.strings.alert_search_term_not_found
    
    var arrayItem = [ListItem]()
    var arrayItemSearch = [ListItem]()
    var didSelectItem : ((ListItem) -> Void)?
    
    
    var arrList : [JSON] = []
    var arrListSearch : [JSON] = []
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.view.alpha = 0
        btnClear.isHidden = true
        lblNoData.isHidden = true
        
        self.lblTitle.applyLabelStyle(fontSize :  14,fontName : .InterSemibol)
        self.txtSearch.applyStyle(fontsize: 13, fontname: .InterMedium)
        
        self.setUpTitle()
        
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
    
    func setUpTitle(){
        switch listType {
        case .attributes:
            lblTitle.text = kChooseYourAttributes
            txtSearch.placeholder = kChooseYourAttributes
            
        case .Nos:
            lblTitle.text = kChooseYourNos
            txtSearch.placeholder = kChooseYourNos
            
        case .sampleCollected:
            lblTitle.text = kChooseYourSampleCollected
            txtSearch.placeholder = kChooseYourSampleCollected
            
        case .weathering:
            lblTitle.text = kChooseYourWeathering
            txtSearch.placeholder = kChooseYourWeathering
            
        case .rockStrenght:
            lblTitle.text = kChooseYourRockStrenght
            txtSearch.placeholder = kChooseYourRockStrenght
            
        case .waterCollection:
            lblTitle.text = kChooseYourWaterCondition
            txtSearch.placeholder = kChooseYourWaterCondition
            
        case .typeOfGeologicalStructure:
            lblTitle.text = kChooseYourTypeOfGeologicalStructure
            txtSearch.placeholder = kChooseYourTypeOfGeologicalStructure
            
        case .typeOfFaults:
            lblTitle.text = kChooseYourTypeOfFault
            txtSearch.placeholder = kChooseYourTypeOfFault
        }
        
        self.apiCalling()
    }
    
    func apiCalling(){
        let listDataVM = ListDataViewModel()
        let parameters = APIParametersModel()
        
        listDataVM.callItemListAPI(parameters: parameters.toDictionary(), listType: self.listType) { responsJSON, statusCode, message, completion in
            if completion , let data = responsJSON{
                self.arrList = data.arrayValue
                self.setupData()
            }
        }
    }
    
    func setupData() {

        self.arrListSearch = self.arrList
        tableView.reloadData()
        lblNoData.isHidden = self.arrListSearch.count != 0
        tableView.isHidden = self.arrListSearch.count == 0
    }
    
    func openPopUpVisiable(){
        UIView.animate(withDuration: 0.5, delay: 0.0) {
            self.view.alpha = 1
        }
    }
    
    func closePopUpVisiable(isCompletion : Bool = false,sender : UIButton,tagInt : Int?){
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            
            self.view.alpha = 0
            
        }, completion: { (finished: Bool) in
            self.dismiss(animated: false) {
                if isCompletion,let _ = tagInt{
                    
                }
            }
        })
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
        return self.arrListSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ListItemCell.self)
        cell.configureCell(data: self.arrListSearch[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        didSelectItem?(arrayItemSearch[indexPath.row])
//        self.dismiss(animated: true, completion: nil)
    }
    
}
