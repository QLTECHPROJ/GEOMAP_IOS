//
//  OpenCastReportOfflineDetailVC.swift


import UIKit

class OpenCastReportOfflineDetailVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    @IBOutlet weak var lblTitle : UILabel!
    
    @IBOutlet weak var btnEdit : AppThemeBlueButton!
    
    @IBOutlet weak var tblView : UITableView!
    
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lblGeologistSign: UILabel!
    @IBOutlet weak var imgGeologistSign: UIImageView!
    
    @IBOutlet weak var lblClientGeologistSign: UILabel!
    @IBOutlet weak var imgClientGeologistSign: UIImageView!
    
    @IBOutlet weak var lblDrawImage : UILabel!
    @IBOutlet weak var imgDrawImage: UIImageView!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    
    var reportData = OpenCastMappingReportDataTable()
    var ocOfflineReportDetail : JSON = .null
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
            "key" : kMineSitenameColn,
            "value" : ""
        ],
        [
            "key" : kPitnameColn,
            "value" : ""
        ],
        [
            "key" : kPitLocationColn,
            "value" : ""
        ],
        [
            "key" : kShiftInchargeNameColn,
            "value" : ""
        ],
        [
            "key" : kGeologistNameColn,
            "value" : ""
        ],
        [
            "key" : kFaceLocationColn,
            "value" : ""
        ],
        [
            "key" : kFaceLenghtMColn,
            "value" : ""
        ],
        [
            "key" : kFaceAreaM2Coln,
            "value" : ""
        ],
        [
            "key" : kFaceRockTypeColn,
            "value" : ""
        ],
        [
            "key" : kBenchRLColmn,
            "value" : ""
        ],
        [
            "key" : kBenchHeightAndWidthMColn,
            "value" : ""
        ],
        [
            "key" : kBenchAngleColn,
            "value" : ""
        ],
        [
            "key" : kDipDirectionAndAngleColn,
            "value" : ""
        ],
        [
            "key" : kThicknessOfOreCoalseamColn,
            "value" : ""
        ],
        [
            "key" : kThicknessOfOverburdenMColn,
            "value" : ""
        ],
        [
            "key" : kThicknessOfInterburdenMColn,
            "value" : ""
        ],
        [
            "key" : kObservedGradeOfOreColn,
            "value" : ""
        ],
        [
            "key" : kSampleCollectedColn,
            "value" : ""
        ],
        [
            "key" : kActualGradeOfOreLabGradeColn,
            "value" : ""
        ],
        [
            "key" : kWeatheringColn,
            "value" : ""
        ],
        [
            "key" : kRockStrengthColn,
            "value" : ""
        ],
        [
            "key" : kWaterConditionColn,
            "value" : ""
        ],
        [
            "key" : kTypeOfGeologicalStructuresColn,
            "value" : ""
        ],
        [
            "key" : kTypeOfFaultsColn,
            "value" : ""
        ]
    ]
    
    var geologistSignImage : UIImage?
    var clientGeologistSignImage : UIImage?
    var drawImage : UIImage?
    
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
        self.removeClassObservers()
    }
    //----------------------------------------------------------------------------
    //MARK: - Custome Methods
    //----------------------------------------------------------------------------
    //Desc:- Centre method to call Of View Config.
    func setUpView(){
        self.addClassObservers()
        self.configureUI()
    }
    
    
    
    //Desc:- Set layout desing customize
    
    func configureUI(){
        self.view.backgroundColor = .colorBGSkyBlueLight
        
        self.lblTitle.applyLabelStyle(isAdjustFontWidth : true,text: kOpenCastMappingReportDetails,fontSize :  16,fontName : .InterBold)
        self.tblView.register(nibWithCellClass: ContactCell.self)
        
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: [.new ], context: nil)
        
        self.lblGeologistSign.applyLabelStyle(text: kGeologistSign,fontSize :  15,fontName : .InterSemibol)
        self.lblClientGeologistSign.applyLabelStyle(text: kClientGeologistSign,fontSize :  15,fontName : .InterSemibol)
        self.lblDrawImage.applyLabelStyle(text: kImage,fontSize :  15,fontName : .InterSemibol)
        
        self.btnEdit.setTitle(kEdit, for: .normal)
        self.btnEdit.isSelect = true
        self.setDraftDetail(self.reportData)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let newSize = change?[.newKey] as? CGSize {
            
            if let tblView = object as? UITableView{
                if tblView == self.tblView {
                    self.tblViewHeight.constant = newSize.height
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
    
    @IBAction func btnEditDetailTapped(_ sender : Any){
        self.view.endEditing(true)
        let vc = AppStoryBoard.main.viewController(viewControllerClass: EditOCGeoAttributeVC.self)
        vc.ocReportDetail = self.ocOfflineReportDetail
        vc.isOfflineDataUpdate = true
        vc.geologistSignImage = self.geologistSignImage
        vc.clientGeologistSignImage = self.clientGeologistSignImage
        vc.drawImage = self.drawImage
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
extension OpenCastReportOfflineDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrReportDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withClass: ContactCell.self)
        cell.configureDataInCell(self.arrReportDetails[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//----------------------------------------------------------------------------
// MARK: - Data Manipulate Methods
//----------------------------------------------------------------------------
extension OpenCastReportOfflineDetailVC {
    
    func setDraftDetail(_ reportData : OpenCastMappingReportDataTable){
        
        for (i, _) in self.arrReportDetails.enumerated(){
            
            if self.arrReportDetails[i]["key"].stringValue == kMapSerialNo{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.mappingSheetNo as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kDateColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.ocDate as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kMineSitenameColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.minesSiteName as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kPitnameColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.pitName as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kPitLocationColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.pitLocation as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kShiftInchargeNameColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.shiftInChargeName as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kGeologistNameColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.geologistName as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceLocationColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.faceLocation as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceLenghtMColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.faceLength as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceAreaM2Coln{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.faceArea as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceRockTypeColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.faceRockTypes as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchRLColmn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.benchRL as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchHeightAndWidthMColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.benchHeightWidth as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchAngleColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.benchAngle as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kDipDirectionAndAngleColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.dipdirectionandAngle as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfOreCoalseamColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.thicknessOfOre as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfOverburdenMColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.thicknessOfOverburden as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfInterburdenMColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.thicknessOfInterBurden as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kObservedGradeOfOreColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.observedGradeOfOre as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kSampleCollectedColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.sampleCollected as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kActualGradeOfOreLabGradeColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.actualGradOfOre as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kWeatheringColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.weathering as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kRockStrengthColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.rockStrength as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kWaterConditionColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.waterCondition as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kTypeOfGeologicalStructuresColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.typeOfGeologicalStructures as Any).stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kTypeOfFaultsColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.typeOfFaults as Any).stringValue.deshOrText
            }
        }
        self.tblView.reloadData()
        
        self.ocOfflineReportDetail = [
            "mappingSheetNo" : JSON(reportData.iD as Any).stringValue,
            "minesSiteName" : JSON(reportData.minesSiteName as Any).stringValue,
            "pitName" : JSON(reportData.pitName as Any).stringValue,
            "pitLoaction" : JSON(reportData.pitLocation as Any).stringValue,
            "shiftInchargeName" : JSON(reportData.shiftInChargeName as Any).stringValue,
            "geologistName" : JSON(reportData.geologistName as Any).stringValue,
            "faceLocation" : JSON(reportData.faceLocation as Any).stringValue,
            "faceLength" : JSON(reportData.faceLength as Any).stringValue,
            "faceArea" : JSON(reportData.faceArea as Any).stringValue,
            "faceRockType" : JSON(reportData.faceRockTypes as Any).stringValue,
            "benchRl" : JSON(reportData.benchRL as Any).stringValue,
            "benchHeightWidth" : JSON(reportData.benchHeightWidth as Any).stringValue,
            "benchAngle" : JSON(reportData.benchAngle as Any).stringValue,
            "thicknessOfOre" : JSON(reportData.thicknessOfOre as Any).stringValue,
            "thicknessOfOverburdan" : JSON(reportData.thicknessOfOverburden as Any).stringValue,
            "thicknessOfInterburden" : JSON(reportData.thicknessOfInterBurden as Any).stringValue,
            "observedGradeOfOre" : JSON(reportData.observedGradeOfOre as Any).stringValue,
            "sampleColledted" : JSON(reportData.sampleCollected as Any).stringValue,
            "actualGradeOfOre" : JSON(reportData.actualGradOfOre as Any).stringValue,
            "weathring" : JSON(reportData.weathering as Any).stringValue,
            "rockStregth" : JSON(reportData.rockStrength as Any).stringValue,
            "waterCondition" : JSON(reportData.waterCondition as Any).stringValue,
            "typeOfGeologist" : JSON(reportData.typeOfGeologicalStructures as Any).stringValue,
            "typeOfFaults" : JSON(reportData.typeOfFaults as Any).stringValue,
            "notes" : JSON(reportData.notes as Any).stringValue,
            "shift" : JSON(reportData.shift as Any).stringValue,
            "ocDate" : JSON(reportData.ocDate as Any).stringValue,
            "dipDirectionAndAngle" : JSON(reportData.dipdirectionandAngle as Any).stringValue,
        ]
        
        guard let geologistSignature = reportData.geologistSign , let clientGeologistSignature = reportData.clientsGeologistSign , let imageDrawn = reportData.imagedrawn else {return}
        
        
        self.geologistSignImage = UIImage(data: geologistSignature)
        self.clientGeologistSignImage = UIImage(data: clientGeologistSignature)
        self.drawImage = UIImage(data: imageDrawn)
        
        self.imgGeologistSign.contentMode = .scaleToFill
        self.imgGeologistSign.image = UIImage(data: geologistSignature)
        self.imgClientGeologistSign.contentMode = .scaleToFill
        self.imgClientGeologistSign.image = UIImage(data: clientGeologistSignature)
        self.imgDrawImage.contentMode = .scaleToFill
        self.imgDrawImage.image = UIImage(data: imageDrawn)
    }
}


//----------------------------------------------------------------------------
//MARK: - Class observers Methods
//----------------------------------------------------------------------------
extension OpenCastReportOfflineDetailVC {
    func addClassObservers() {
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.reploadPageData(_:)), name: NSNotification.Name.updateOCOfflineReport, object: nil)
    }
    
    func removeClassObservers() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.updateOCOfflineReport, object: nil)
       
    }

    
    @objc func reploadPageData(_ notification : NSNotification){
        
        if let dataModel = notification.object as? JSON ,dataModel["offline_id"].stringValue == JSON(self.reportData.iD as Any).stringValue{
            
            self.reportData = OpenCastMappingReportDataModel.shared.arrOpenCastMappingReportData.filter{JSON($0.iD as Any).stringValue == dataModel["offline_id"].stringValue}.first!
            
            self.setDraftDetail(self.reportData)
        }
    }
}
