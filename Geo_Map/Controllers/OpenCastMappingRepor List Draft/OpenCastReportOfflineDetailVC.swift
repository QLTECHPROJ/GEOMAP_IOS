//
//  OpenCastReportOfflineDetailVC.swift


import UIKit

class OpenCastReportOfflineDetailVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    @IBOutlet weak var lblTitle : UILabel!
    
    @IBOutlet weak var tblView : UITableView!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    
    var reportData = OpenCastMappingReportDataTable()
    
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
            "key" : kBenchRL,
            "value" : ""
        ],
        [
            "key" : kBenchHeightWidthM,
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
            "key" : kThicknessOfOreCoalSeam,
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
    
    //----------------------------------------------------------------------------
    //MARK: - Memory management
    //----------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
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
        
        self.lblTitle.applyLabelStyle(isAdjustFontWidth : true,text: kOpenCastMappingReportDetails,fontSize :  16,fontName : .InterBold)
        self.tblView.register(nibWithCellClass: ContactCell.self)
        
        self.setDraftDetail(self.reportData)
        
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
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.mappingSheetNo as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kDateColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.ocDate as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kMineSitenameColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.minesSiteName as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kPitnameColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.pitName as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kPitLocationColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.pitLocation as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kShiftInchargeNameColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.shiftInChargeName as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kGeologistNameColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.geologistName as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceLocationColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.faceLocation as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceLenghtMColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.faceLength as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceAreaM2Coln{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.faceArea as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceRockTypeColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.faceRockTypes as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchRL{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.benchRL as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchHeightWidthM{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.benchHeightWidth as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchAngleColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.benchAngle as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kDipDirectionAndAngleColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.dipdirectionandAngle as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfOreCoalSeam{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.thicknessOfOre as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfOverburdenMColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.thicknessOfOverburden as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfInterburdenMColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.thicknessOfInterBurden as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kObservedGradeOfOreColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.observedGradeOfOre as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kSampleCollectedColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.sampleCollected as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kActualGradeOfOreLabGradeColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.actualGradOfOre as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kWeatheringColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.weathering as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kRockStrengthColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.rockStrength as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kWaterConditionColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.waterCondition as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kTypeOfGeologicalStructuresColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.typeOfGeologicalStructures as Any).stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kTypeOfFaultsColn{
                self.arrReportDetails[i]["value"].stringValue = JSON(reportData.typeOfFaults as Any).stringValue
            }
        }
        self.tblView.reloadData()
    }
}
