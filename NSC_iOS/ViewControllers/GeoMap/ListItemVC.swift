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
    private var strNoData = Theme.strings.alert_search_term_not_found

    var didSelectItem : ((JSON) -> Void)?
    
    var arrList : [JSON] = []
    private var arrListSearch : [JSON] = []
    
    
    var arrAnyObject : [Any] = []
    
    private var searchText : String = ""
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
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
        self.viewBackground.addGestureRecognizer(tapGesture)
        self.viewBackground.isUserInteractionEnabled = true
        
        self.tableView.register(nibWithCellClass: ListItemCell.self)
        self.tableView.reloadData()
                
        self.txtSearch.addTarget(self, action: #selector(self.searchValueChanged(_:)), for: .allEditingEvents)
    }
    
    
    @objc func searchValueChanged(_ sender : UITextField){
        
        self.searchText = sender.text!
        self.searchText = self.searchText.lowercased()
        self.arrListSearch = self.arrList.compactMap({ (obj) -> JSON? in
            
            if obj["name"].stringValue.lowercased().contains(self.searchText){
                
                return obj
            }
            else{
                
                return nil
            }
        })
        
        if sender.text! == ""{
            self.arrListSearch = self.arrList
        }
        self.btnClear.isHidden = self.searchText.trim.isEmpty
        self.tableView.reloadData()
    }
    
    func setUpTitle(){
        
        switch listType {
            
        case .attributes:
            lblTitle.text = kChooseYourAttributes
            txtSearch.placeholder = kChooseYourAttributes
            
            self.arrAnyObject = AttributeDataModel.shared.arrAttributeData
           
        case .Nos:
            lblTitle.text = kChooseYourNos
            txtSearch.placeholder = kChooseYourNos
            
        case .sampleCollected:
            lblTitle.text = kChooseYourSampleCollected
            txtSearch.placeholder = kChooseYourSampleCollected
            
            self.arrAnyObject = SampleCollectedModel.shared.arrSampleCollected
            
            
        case .weathering:
            lblTitle.text = kChooseYourWeathering
            txtSearch.placeholder = kChooseYourWeathering
            
            self.arrAnyObject = WeatheringDataModel.shared.arrWeathering
           
        case .rockStrenght:
            lblTitle.text = kChooseYourRockStrenght
            txtSearch.placeholder = kChooseYourRockStrenght
            
            self.arrAnyObject = RockStrengthDataModel.shared.arrRockStrenght
            
        case .waterCollection:
            lblTitle.text = kChooseYourWaterCondition
            txtSearch.placeholder = kChooseYourWaterCondition
            
            self.arrAnyObject = WaterConditionDataModel.shared.arrWaterCondition
            
        case .typeOfGeologicalStructure:
            lblTitle.text = kChooseYourTypeOfGeologicalStructure
            txtSearch.placeholder = kChooseYourTypeOfGeologicalStructure
            
            self.arrAnyObject = TypeOfGeologicalStructuresModel.shared.arrTypeOfGeologicalStructures
        case .typeOfFaults:
            lblTitle.text = kChooseYourTypeOfFault
            txtSearch.placeholder = kChooseYourTypeOfFault
            
            self.arrAnyObject = TypeOfFaultsDataModel.shared.arrTypeOfFault
        }
        
        if self.listType == .Nos{
            self.setupData()
        }
        else{
            
            guard checkInternet() else {
                
                return
            }
            self.apiCalling()
        }
    }
    
    func apiCalling(){
        let listDataVM = ListDataViewModel()
        let parameters = APIParametersModel()
        
        listDataVM.callItemListAPI(parameters: parameters.toDictionary(), listType: self.listType) { responsJSON, statusCode, message, completion in
            if completion , let data = responsJSON{
                debugPrint(data)
                self.arrList = data["ResponseData"].arrayValue
                self.setupData()
            }
        }
    }

    
    func setupData() {

        self.arrListSearch = self.arrList
        self.tableView.reloadData()
        self.lblNoData.isHidden = self.arrListSearch.count != 0
        self.tableView.isHidden = self.arrListSearch.count == 0
    }
    
    func openPopUpVisiable(){
        UIView.animate(withDuration: 0.5, delay: 0.0) {
            self.view.alpha = 1
        }
    }
    
    func closePopUpVisiable(isCompletion : Bool = false, selectedData : JSON? = nil){
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            
            self.view.alpha = 0
            
        }, completion: { (finished: Bool) in
            self.dismiss(animated: false) {
                if isCompletion,let _ = selectedData{
                    if let _ = self.didSelectItem{
                        self.didSelectItem!(selectedData!)
                    }
                }
            }
        })
    }
    
    @objc func textFieldValueChanged(textField : UITextField ) {
        btnClear.isHidden = textField.text?.count == 0
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        self.closePopUpVisiable()
    }
    
    
    // MARK: - ACTIONS
    @IBAction func clearSearchClicked(_ sender: UIButton) {
        txtSearch.text = ""
        self.arrListSearch = self.arrList
        btnClear.isHidden = true
        lblNoData.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
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

        self.closePopUpVisiable(isCompletion: true,selectedData: self.arrListSearch[indexPath.row])
    }
}
