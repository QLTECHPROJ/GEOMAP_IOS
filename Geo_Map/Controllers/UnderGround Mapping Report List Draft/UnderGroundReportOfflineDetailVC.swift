//
//  UnderGroundReportOfflineDetailVC.swift


import UIKit

class UnderGroundReportOfflineDetailVC : ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    @IBOutlet weak var lblTitle : UILabel!
    
    @IBOutlet weak var lblAttribute : UILabel!
    
    @IBOutlet weak var tblView : UITableView!
    
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tblAttribute : UITableView!
    @IBOutlet weak var tblAttributeHeight: NSLayoutConstraint!
    
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    
    var reportData = UnderGroundMappingReportDataTable()
    private var arrAttribute : [JSON] = []
    private var arrReportDetails : [JSON] = [
        [
            "key" : kMapSerialNo,
            "value" : ""
        ],
        [
            "key" : kDateColn,
            "value" : ""
        ],
        [
            "key" : kShiftColn,
            "value" : ""
        ],
        [
            "key" : kMappedByColn,
            "value" : ""
        ],
        [
            "key" : kScale,
            "value" : ""
        ],
        [
            "key" : kLocationColn,
            "value" : ""
        ],
        [
            "key" : kVeinloadColn,
            "value" : ""
        ],
        [
            "key" : kXCoordinateColn,
            "value" : ""
        ],
        [
            "key" : kYCoordinateColn,
            "value" : ""
        ],
        [
            "key" : kZCoordinateColn,
            "value" : ""
        ]
    ]
    
    
    
    //----------------------------------------------------------------------------
    //MARK: - Memory management
    //----------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        if let _ = self.tblView {
            self.tblView.removeObserver(self, forKeyPath: "contentSize")
        }
        if let _ = self.tblAttribute {
            self.tblAttribute.removeObserver(self, forKeyPath: "contentSize")
        }
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
        
        self.lblTitle.applyLabelStyle(isAdjustFontWidth : true,text: kUndergroundsMappingReportDetails,fontSize :  16,fontName : .InterBold)
        self.lblAttribute.applyLabelStyle(text: kAttributesColn,fontSize :  12,fontName : .InterMedium,textColor: .colorTextPlaceHolderGray)
        
        self.setDraftDetail(self.reportData)
        
        self.tblView.register(nibWithCellClass: ContactCell.self)
        self.tblView.isScrollEnabled = false
        self.tblAttribute.register(nibWithCellClass: AttributesDataTblCell.self)
        self.tblAttribute.isScrollEnabled = false
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: [.new ], context: nil)
        self.tblAttribute.addObserver(self, forKeyPath: "contentSize", options: [.new ], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let newSize = change?[.newKey] as? CGSize {
            
            if let tblView = object as? UITableView{
                if tblView == self.tblView {
                    self.tblViewHeight.constant = newSize.height
                }
                if tblView == self.tblAttribute {
                    self.tblAttributeHeight.constant = newSize.height
                }
            }
        }
    }
    
    
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
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
// MARK: - UITableView Methods
//----------------------------------------------------------------------------
extension UnderGroundReportOfflineDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableView == self.tblView ? self.arrReportDetails.count : self.arrAttribute.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tblView{
            let cell = tableView.dequeueReusableCell(withClass: ContactCell.self)
            cell.configureDataInCell(self.arrReportDetails[indexPath.row])
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withClass: AttributesDataTblCell.self)
            cell.configuredCell(with: self.arrAttribute[indexPath.row])
            cell.lblNameLeadingConstraint.constant = 15
            cell.btnDelete.isHidden = true
            return cell
        }
        
    }
    
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
}

//----------------------------------------------------------------------------
// MARK: - Data Manipulate Methods
//----------------------------------------------------------------------------
extension UnderGroundReportOfflineDetailVC {
    
    func setDraftDetail(_ reportData : UnderGroundMappingReportDataTable){
        
        for (i, _) in self.arrReportDetails.enumerated(){
            if self.arrReportDetails[i]["key"].stringValue == kMapSerialNo{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.mapSerialNo as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kDateColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.ugDate as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kShiftColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.shift as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kMappedByColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.mappedBy as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kScale{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.scale as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kLocationColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.location as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kVeinloadColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.veinOrLoad as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kXCoordinateColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.xCoordinate as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kYCoordinateColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.yCoordinate as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kZCoordinateColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.zCoordinate as Any).stringValue
            }
            
        }
        
        if let array = reportData.attributeUndergroundMapping,let nosArray = array.allObjects as? [AttributeUndergroundMappingTable]{
            for nosData in nosArray{
                debugPrint(nosData)
                self.arrAttribute.append([
                    "name" : JSON(nosData.name as Any).stringValue,
                    "nose" : JSON(nosData.nose as Any).stringValue,
                    "properties" : JSON(nosData.properties as Any).stringValue])
            }
        }
        self.tblView.reloadData()
        self.tblAttribute.reloadData()
    }
}
