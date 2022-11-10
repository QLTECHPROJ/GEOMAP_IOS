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

class UGReportDetailVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
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
        ],
        [
            "key" : kAttributesColn,
            "value" : ""
        ],
        [
            "key" : kNosColn,
            "value" : ""
        ],
        [
            "key" : kPropertiesColn,
            "value" : ""
        ]
    ]
    
    var underGroundDetail : JSON = .null
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.tableView.register(nibWithCellClass: ContactCell.self)
        
        self.lblTitle.applyLabelStyle(text: kUndergroundsMappingReportDetails,fontSize :  20,fontName : .InterBold)
        self.lblTitle.adjustsFontSizeToFitWidth = true
        self.view.backgroundColor = .colorBGSkyBlueLight
        
        self.btnViewPDF.isSelect = false
        self.btnViewPDF.setTitle(kViewPDF, for: .normal)
        
        self.apiCallForDetail()
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
        let vc = AppStoryBoard.main.viewController(viewControllerClass: ViewPDFVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//----------------------------------------------------------------------------
// MARK: - UITableView Methods
//----------------------------------------------------------------------------
extension UGReportDetailVC: UITableViewDelegate, UITableViewDataSource {
    
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
            if self.arrReportDetails[i]["key"].stringValue == kAttributesColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["attribute"].compactMap({ (_ , Obj) -> String in
                    return Obj["name"].stringValue
                }).joined(separator: ",")
                
            }
            if self.arrReportDetails[i]["key"].stringValue == kNosColn{
                self.arrReportDetails[i]["value"].stringValue = reportData["attribute"].compactMap({ (_ , Obj) -> String in
                    return Obj["nose"].stringValue
                }).joined(separator: ",")
            }
            if self.arrReportDetails[i]["key"].stringValue == kPropertiesColn{
                self.arrReportDetails[i]["value"].stringValue = "-" //reportData["ugDate"].stringValue
                
                let arr = reportData["attribute"].compactMap({ (_ , Obj) -> JSON in
                    print(Obj["properties"])
                    return Obj
                })
                print(arr)
            }
        }
        self.tableView.reloadData()
    }
}
