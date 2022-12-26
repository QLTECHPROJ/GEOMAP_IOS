//
//  ContactVC.swift

import Foundation
import ContactsUI
import MessageUI
import EVReflection

class OCReportDetailVC : ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblGeologistSign: UILabel!
    @IBOutlet weak var imgGeologistSign: UIImageView!
    
    @IBOutlet weak var lblClientGeologistSign: UILabel!
    @IBOutlet weak var imgClientGeologistSign: UIImageView!
    
    @IBOutlet weak var lblDrawImage : UILabel!
    @IBOutlet weak var imgDrawImage: UIImageView!
    
    
    @IBOutlet weak var btnViewPDF: AppThemeBlueButton!
    
    // MARK: - VARIABLES
   
    var reportId : String = ""
    
    var reportListType : ReportListType = .openCastReport
    
    private var vwUnderGroundReportDetail : UGReportDetailVM = UGReportDetailVM()
    
    
    var arrReportDetails : [JSON] = [
//        [
//            "key" : kMapSerialNo,
//            "value" : ""
//        ],
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
    
    deinit {
        if let _ = self.tableView {
            self.tableView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    
    private var openCastDetail : JSON = .null
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.tableView.register(nibWithCellClass: ContactCell.self)
      
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: [.new ], context: nil)
        
        self.lblTitle.applyLabelStyle(text: kOpenCastMappingReportDetails,fontSize :  20,fontName : .InterBold)
        
        self.lblGeologistSign.applyLabelStyle(text: kGeologistSign,fontSize :  15,fontName : .InterSemibol)
        self.lblClientGeologistSign.applyLabelStyle(text: kClientGeologistSign,fontSize :  15,fontName : .InterSemibol)
        self.lblDrawImage.applyLabelStyle(text: kImage,fontSize :  15,fontName : .InterSemibol)
        
        self.lblTitle.adjustsFontSizeToFitWidth = true
        self.view.backgroundColor = .colorBGSkyBlueLight
        self.tableView.reloadData()
        self.btnViewPDF.isSelect = false
        self.btnViewPDF.setTitle(kViewPDF, for: .normal)
        
        self.apiCallForDetail()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let newSize = change?[.newKey] as? CGSize {
            
            if let tblView = object as? UITableView{
                if tblView == self.tableView {
                    self.tblViewHeight.constant = newSize.height
                }
            }
        }
    }
    
    func apiCallForDetail(){
        let parameters = APIParametersModel()
        parameters.mappingSheetNo = self.reportId
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
    
    @IBAction func btnEditDetailTapped(_ sender : UIButton){
        
        self.view.endEditing(true)
        let vc = AppStoryBoard.main.viewController(viewControllerClass: EditOCGeoAttributeVC.self)
        vc.ocReportDetail = self.openCastDetail
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnViewPDF(_ sender : UIButton) {
        
        self.view.endEditing(true)

        let vwUnderGroundReportDetail = UGReportDetailVM()
        let parameters = APIParametersModel()
        parameters.iD = self.reportId
        parameters.reportType = PDFReportViewType.oCReport.rawValue
        parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
        debugPrint(parameters.toDictionary())
        
        vwUnderGroundReportDetail.callAPIGetReportDetailViewInPDF(parameters: parameters.toDictionary()) { responseJson, statusCode, message, completion in
            if completion , let data = responseJson{
               debugPrint(data)
                if let url = URL(string: data["ResponseData"]["pdfLink"].stringValue) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}

//----------------------------------------------------------------------------
// MARK: - UITableView Methods
//----------------------------------------------------------------------------
extension OCReportDetailVC: UITableViewDelegate, UITableViewDataSource,UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        print("fileDownload: documentInteractionControllerViewControllerForPreview")
        return self
    }
    
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
            
//            if self.arrReportDetails[i]["key"].stringValue == kMapSerialNo{
//                self.arrReportDetails[i]["value"].stringValue = reportData["mappingSheetNo"].stringValue
//            }
            if self.arrReportDetails[i]["key"].stringValue == kDateColn{
                self.arrReportDetails[i]["value"].stringValue = GFunctions.shared.convertDateFormat(dt: reportData["ocDate"].stringValue, inputFormat: DateTimeFormaterEnum.ddMMMyyyy.rawValue, outputFormat: DateTimeFormaterEnum.ddmm_yyyy.rawValue, status: .NOCONVERSION).str 
            }
            if self.arrReportDetails[i]["key"].stringValue == kMineSitenameColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["minesSiteName"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kPitnameColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["pitName"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kPitLocationColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["pitLoaction"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kShiftInchargeNameColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["shiftInchargeName"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kGeologistNameColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["geologistName"].stringValue.deshOrText
            }
//            if self.arrReportDetails[i]["key"].stringValue == kMappingParametersColn{
//                self.arrReportDetails[i]["value"].stringValue = "-"
//            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceLocationColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["faceLocation"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceLenghtMColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["faceLength"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceAreaM2Coln{
                self.arrReportDetails[i]["value"].stringValue = reportData["faceArea"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kFaceRockTypeColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["faceRockType"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchRLColmn{
                self.arrReportDetails[i]["value"].stringValue = reportData["benchRl"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchHeightAndWidthMColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["benchHeightWidth"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kBenchAngleColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["benchAngle"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kDipDirectionAndAngleColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["dipDirectionAndAngle"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfOreCoalseamColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["thicknessOfOre"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfOverburdenMColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["thicknessOfOverburdan"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kThicknessOfInterburdenMColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["thicknessOfInterburden"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kObservedGradeOfOreColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["observedGradeOfOre"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kSampleCollectedColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["sampleColledted"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kActualGradeOfOreLabGradeColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["actualGradeOfOre"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kWeatheringColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["weathring"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kRockStrengthColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["rockStregth"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kWaterConditionColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["waterCondition"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kTypeOfGeologicalStructuresColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["typeOfGeologist"].stringValue.deshOrText
            }
            if self.arrReportDetails[i]["key"].stringValue == kTypeOfFaultsColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["typeOfFaults"].stringValue.deshOrText
            }
        }
        self.tableView.reloadData()
        
        if let imgGeologistSign = self.fetchImage(reportData["geologistSign"].stringValue.url()){
           
            self.imgGeologistSign.contentMode = .scaleToFill
            self.imgGeologistSign.image = imgGeologistSign
        }
        if let imgClientsGeologistSign = self.fetchImage(reportData["clientsGeologistSign"].stringValue.url()){
            self.imgClientGeologistSign.contentMode = .scaleToFill
            self.imgClientGeologistSign.image = imgClientsGeologistSign
        }
        if let imgDraw = self.fetchImage(reportData["image"].stringValue.url()){
            self.imgDrawImage.contentMode = .scaleToFill
            self.imgDrawImage.image = imgDraw
        }
    }
    
    func fetchImage(_ imgUrl: URL) -> UIImage?{
        
        //        DispatchQueue.main.async {
        do{
            let imageData: Data = try Data(contentsOf: imgUrl)
            
            
            let image = UIImage(data: imageData)
            return image
            //                }
        }catch{
            print("Unable to load data: \(error)")
            return nil
        }
        //        }
    }
}

