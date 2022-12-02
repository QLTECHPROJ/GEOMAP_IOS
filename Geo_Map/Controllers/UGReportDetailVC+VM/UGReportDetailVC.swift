//
//  UGReportDetailVC.swift


import Foundation
import ContactsUI
import MessageUI
import EVReflection

enum PDFReportViewType : String {
    case uGReport = "ug"
    case oCReport = "oc"
}


class UGReportDetailVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    @IBOutlet weak var lblAttribute : UILabel!
    
    @IBOutlet weak var tblView : UITableView!
    
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tblAttribute : UITableView!
    @IBOutlet weak var tblAttributeHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnViewPDF: AppThemeBlueButton!
    
    // MARK: - VARIABLES
    
    var reportListType : ReportListType = .underGroundReport
    
    private var vwUnderGroundReportDetail : UGReportDetailVM = UGReportDetailVM()
    
    var reportId : String = ""
    
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
    private var arrAttribute : [JSON] = []
    var underGroundDetail : JSON = .null
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        
        self.lblTitle.applyLabelStyle(text: kUndergroundsMappingReportDetails,fontSize :  20,fontName : .InterBold)
        self.lblTitle.adjustsFontSizeToFitWidth = true
        self.view.backgroundColor = .colorBGSkyBlueLight
        
        self.btnViewPDF.isSelect = false
        self.btnViewPDF.setTitle(kViewPDF, for: .normal)
        
        self.lblAttribute.applyLabelStyle(text: kAttributesColn,fontSize :  12,fontName : .InterMedium,textColor: .colorTextPlaceHolderGray)
        
        self.tblView.register(nibWithCellClass: ContactCell.self)
        self.tblView.isScrollEnabled = false
        self.tblAttribute.register(nibWithCellClass: AttributesDataTblCell.self)
        self.tblAttribute.isScrollEnabled = false
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: [.new ], context: nil)
        self.tblAttribute.addObserver(self, forKeyPath: "contentSize", options: [.new ], context: nil)
        
        self.apiCallForDetail()
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
    
    
    func apiCallForDetail(){
        let parameters = APIParametersModel()
        parameters.iD = self.reportId
        self.vwUnderGroundReportDetail.callAPIUnderGroundReportDetails(parameters: parameters.toDictionary()) { responseData, statusCode, message, completion in
            if completion , let data = responseData{
                debugPrint(data)
                self.underGroundDetail = data["ResponseData"]
                
                self.setDetail(self.underGroundDetail)
                
            }
        }
    }
    
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnViewPDF(_ sender : UIButton) {
    
        self.view.endEditing(true)

        let vwUnderGroundReportDetail = UGReportDetailVM()
        let parameters = APIParametersModel()
        parameters.iD = self.reportId
        parameters.reportType = PDFReportViewType.uGReport.rawValue
        parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
        debugPrint(parameters.toDictionary())
        
        vwUnderGroundReportDetail.callAPIGetReportDetailViewInPDF(parameters: parameters.toDictionary()) { responseJson, statusCode, message, completion in
            if completion , let data = responseJson{
               debugPrint(data)
//                let vc = AppStoryBoard.main.viewController(viewControllerClass: WebViewVC.self)
//                vc.loadUrl = data["ResponseData"]["pdfLink"].stringValue
//                self.navigationController?.pushViewController(vc, animated: true)
                
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
extension UGReportDetailVC: UITableViewDelegate, UITableViewDataSource {
    
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
            cell.btnDelete.isHidden = true
            cell.lblNameLeadingConstraint.constant = 15
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


//----------------------------------------------------------------------------
// MARK: - Data Manipulate Methods
//----------------------------------------------------------------------------
extension UGReportDetailVC {
    
    func setDetail(_ reportData : JSON){
    
        self.btnViewPDF.isSelect = true
        print(reportData)
        for (i, _) in self.arrReportDetails.enumerated(){
            if self.arrReportDetails[i]["key"].stringValue == kMapSerialNo{
                self.arrReportDetails[i]["value"].stringValue = reportData["mapSerialNo"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kDateColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["ugDate"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kShiftColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["shift"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kMappedByColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["mappedBy"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kScale{
                self.arrReportDetails[i]["value"].stringValue = reportData["scale"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kLocationColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["location"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kVeinloadColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["venieLoad"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kXCoordinateColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["xCordinate"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kYCoordinateColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["yCordinate"].stringValue
            }
            if self.arrReportDetails[i]["key"].stringValue == kZCoordinateColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["zCordinate"].stringValue
            }
        }
        self.arrAttribute = reportData["attribute"].arrayValue
//        self.lblAttribute.isHidden = reportData["attribute"].arrayValue.isEmpty
        self.tblView.reloadData()
        self.tblAttribute.reloadData()
    }
}
