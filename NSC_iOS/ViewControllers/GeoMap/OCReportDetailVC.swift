//
//  ContactVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 13/05/22.
//

import Foundation
import ContactsUI
import MessageUI
import EVReflection

class OCReportDetailVC : ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnViewPDF: AppThemeBlueButton!
    
    // MARK: - VARIABLES
   
    var reportId : String = ""
    
    var reportListType : ReportListType = .opneCastReport
    
    private var vwUnderGroundReportDetail : UGReportDetailVM = UGReportDetailVM()
    
    
    var arrReportDetails : [JSON] = [
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
//        [
//            "key" : kMappingParametersColn,
//            "value" : ""
//        ],
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
    
    private var openCastDetail : JSON = .null
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.tableView.register(nibWithCellClass: ContactCell.self)
      
        self.lblTitle.applyLabelStyle(text: kOpenCastMappingReportDetails,fontSize :  20,fontName : .InterBold)
        self.lblTitle.adjustsFontSizeToFitWidth = true
        self.view.backgroundColor = .colorBGSkyBlueLight
        self.tableView.reloadData()
        self.btnViewPDF.isSelect = false
        self.btnViewPDF.setTitle(kViewPDF, for: .normal)
        
        self.apiCallForDetail()
    }
    
    func apiCallForDetail(){
        let parameters = APIParametersModel()
        parameters.iD = self.reportId
        self.vwUnderGroundReportDetail.callAPIOpenCastReportDetails(parameters: parameters.toDictionary()) { responseData, statusCode, message, completion in
            if completion , let data = responseData{
                debugPrint(data)
                self.openCastDetail = data["ResponseData"]
                
                self.setDetail(self.openCastDetail)
                
            }
        }
    }
  
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnViewPDF(_ sender : UIButton) {
        let vc = AppStoryBoard.main.viewController(viewControllerClass: ViewPDFVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//----------------------------------------------------------------------------
// MARK: - UITableView Methods
//----------------------------------------------------------------------------
extension OCReportDetailVC: UITableViewDelegate, UITableViewDataSource {
    
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
extension OCReportDetailVC {
    
    func setDetail(_ reportData : JSON){
    
        self.btnViewPDF.isSelect = true
        print(reportData)
        
        for (i, _) in self.arrReportDetails.enumerated(){
            
            if self.arrReportDetails[i]["key"].stringValue == kMapSerialNo{
                self.arrReportDetails[i]["value"].stringValue = reportData["mappingSheetNo"].stringValue 
            }
            if self.arrReportDetails[i]["key"].stringValue == kDateColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["ocDate"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kMineSitenameColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["minesSiteName"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kPitnameColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["pitName"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kPitLocationColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["pitLoaction"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kShiftInchargeNameColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["shiftInchargeName"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kGeologistNameColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["geologistName"].stringValue
            }
//            if self.arrReportDetails[i]["key"].stringValue == kMappingParametersColn{
//                self.arrReportDetails[i]["value"].stringValue = "-"
//            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceLocationColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["faceLocation"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceLenghtMColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["faceLength"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceAreaM2Coln{
                self.arrReportDetails[i]["value"].stringValue = reportData["faceArea"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceRockTypeColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["faceRockType"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchRL{
                self.arrReportDetails[i]["value"].stringValue = reportData["benchRl"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchHeightWidthM{
                self.arrReportDetails[i]["value"].stringValue = reportData["benchHeightWidth"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchAngleColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["benchAngle"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kDipDirectionAndAngleColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["dipDirectionAndAngle"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfOreCoalSeam{
                self.arrReportDetails[i]["value"].stringValue = reportData["thicknessOfOre"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfOverburdenMColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["thicknessOfOverburdan"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfInterburdenMColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["thicknessOfInterburden"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kObservedGradeOfOreColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["observedGradeOfOre"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kSampleCollectedColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["sampleColledted"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kActualGradeOfOreLabGradeColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["actualGradeOfOre"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kWeatheringColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["weathring"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kRockStrengthColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["rockStregth"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kWaterConditionColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["waterCondition"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kTypeOfGeologicalStructuresColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["typeOfGeologist"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kTypeOfFaultsColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["typeOfFaults"].stringValue
            }
        }
        self.tableView.reloadData()
    }
}

