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
    
    @IBOutlet weak var imgLeft : UIImageView!
    @IBOutlet weak var lblLeftImage : UILabel!
    
    @IBOutlet weak var imgRight : UIImageView!
    @IBOutlet weak var lblRightImage : UILabel!
    
    @IBOutlet weak var imgFace : UIImageView!
    @IBOutlet weak var lblFaceImage : UILabel!
    
    @IBOutlet weak var imgRoof : UIImageView!
    @IBOutlet weak var lblRoofImage : UILabel!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    
    
    private var faceImage = UIImage()
    private var roofImage = UIImage()
    private var leftImage = UIImage()
    private var rightImage = UIImage()
    
    
    var reportData = UnderGroundMappingReportDataTable()
    private var arrAttribute : [JSON] = []
    private var arrReportDetails : [JSON] = [
//        [
//            "key" : kMapSerialNo,
//            "value" : ""
//        ],
        [
            "key" : kNameColn,
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
            "key" : kScaleColnm,
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
    
    var ugOfflineReportDetail : JSON = .null
    private var vwUGMappingReportListOffline : UnderGroundMappingReportListDraftVM = UnderGroundMappingReportListDraftVM()
    
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
        self.removeClassObservers()
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
        self.addClassObservers()
        
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
        
        self.lblFaceImage.applyLabelStyle(text: kFACE,fontSize :  14,fontName : .InterSemibol)
//        self.imgFace.contentMode = .scaleAspectFit
        self.imgFace.layer.cornerRadius = 10
        
        self.lblLeftImage.applyLabelStyle(text: kLEFT,fontSize :  14,fontName : .InterSemibol)
//        self.imgLeft.contentMode = .scaleAspectFit
        self.imgLeft.layer.cornerRadius = 10
        
        self.lblRoofImage.applyLabelStyle(text: kROOF,fontSize :  14,fontName : .InterSemibol)
//        self.imgRoof.contentMode = .scaleAspectFit
        self.imgRoof.layer.cornerRadius = 10
        
        self.lblRightImage.applyLabelStyle(text: kRIGHT,fontSize :  14,fontName : .InterSemibol)
//        self.imgRight.contentMode = .scaleAspectFit
        self.imgRight.layer.cornerRadius = 10
        
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
    
    @IBAction func btnEditTapped(_ sender : UIButton){
        self.view.endEditing(true)
        let vc = AppStoryBoard.main.viewController(viewControllerClass: EditAttributeUGGeoAttributeVC.self)
        vc.ugReportDetail = self.ugOfflineReportDetail
        vc.isOfflineDataUpdate = true
        vc.faceImage = self.faceImage
        vc.roofImage = self.roofImage
        vc.leftImage = self.leftImage
        vc.rightImage = self.rightImage
        self.navigationController?.pushViewController(vc, animated: true)
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
           /* if self.arrReportDetails[i]["key"].stringValue == kMapSerialNo{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.mapSerialNo as Any).stringValue
            }
            */
            if self.arrReportDetails[i]["key"].stringValue == kNameColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.name as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kDateColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.ugDate as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kShiftColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.shift as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kMappedByColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.mappedBy as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kScaleColnm{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.scale as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kLocationColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.location as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kVeinloadColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.veinOrLoad as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kXCoordinateColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.xCoordinate as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kYCoordinateColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.yCoordinate as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kZCoordinateColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.zCoordinate as Any).stringValue.deshOrText
            }
        }
        arrAttribute = []
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
        
        
        self.ugOfflineReportDetail = [
            "xCordinate" : JSON(reportData.xCoordinate as Any).stringValue,
            "venieLoad" : JSON(reportData.veinOrLoad as Any).stringValue,
            "yCordinate" : JSON(reportData.yCoordinate as Any).stringValue,
            "leftImage" : "",
            "name" : JSON(reportData.name as Any).stringValue,
            "mappedBy" : JSON(reportData.mappedBy as Any).stringValue,
            "ugDate" : JSON(reportData.ugDate as Any).stringValue,
            "scale" : JSON(reportData.scale as Any).stringValue,
            "location" : JSON(reportData.location as Any).stringValue,
            "faceImage" : "",
            "userId" : JSON(reportData.userId as Any).stringValue,
            "zCordinate" : JSON(reportData.zCoordinate as Any).stringValue,
            "attribute" : self.arrAttribute,
            "roofImage" : "",
            "shift" : JSON(reportData.shift as Any).stringValue,
            "mapSerialNo" : JSON(reportData.mapSerialNo as Any).stringValue,
            "rightImage" : "",
            "comment" : JSON(reportData.comment as Any).stringValue,
//            "iD" : JSON(reportData.iD as Any).stringValue
        ]
        
        guard let faceimg = reportData.faceImage , let rightimg = reportData.rightImage , let leftimg = reportData.leftImage, let roofimg = reportData.roofImage else {return}
        
        self.faceImage = UIImage(data: faceimg)!
        self.roofImage = UIImage(data: roofimg)!
        self.leftImage = UIImage(data: leftimg)!
        self.rightImage = UIImage(data: rightimg)!
        
        self.imgRoof.contentMode = .scaleToFill
        self.imgRight.contentMode = .scaleToFill
        self.imgFace.contentMode = .scaleToFill
        self.imgLeft.contentMode = .scaleToFill
        
        self.imgRoof.image = UIImage(data: roofimg)!
        self.imgRight.image = UIImage(data: rightimg)!
        self.imgFace.image = UIImage(data: faceimg)!
        self.imgLeft.image = UIImage(data: leftimg)!
    }
    
    
}

//----------------------------------------------------------------------------
//MARK: - Class observers Methods
//----------------------------------------------------------------------------
extension UnderGroundReportOfflineDetailVC {
    func addClassObservers() {
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.reploadPageData(_:)), name: NSNotification.Name.updateUGOfflineReport, object: nil)
    }
    
    func removeClassObservers() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.updateUGOfflineReport, object: nil)
       
    }

    
    @objc func reploadPageData(_ notification : NSNotification){
        
        if let dataModel = notification.object as? JSON ,dataModel["offline_id"].stringValue == JSON(self.reportData.mapSerialNo as Any).stringValue{
            
            self.reportData = UnderGroundMappingReportDataModel.shared.arrUnderGroundMappingReportData.filter{JSON($0.mapSerialNo as Any).stringValue == dataModel["offline_id"].stringValue}.first!
            
            self.setDraftDetail(self.reportData)
        }
    }
}
