//
//  NotificationVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 19/07/22.
//

import UIKit

enum ReportListType  : String{
    case underGroundReport = "underGroundReport"
    case opneCastReport = "opneCastReport"
}

class UGListVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    // MARK: - VARIABLES
    
    lazy var refreshControl                                 : UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
          #selector(self.refreshData),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.colorSkyBlue
        return refreshControl
    }()
    
    var reportListType : ReportListType = .underGroundReport
    
    private var vwReportList : ReportListVM = ReportListVM()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
      
    }
    
    
    // MARK: - FUNCTIONS
    
    func setUpUI(){
     
        self.lblTitle.applyLabelStyle(text: self.reportListType == .underGroundReport ? kUndergroundsMappingReport : kOpenCastMappingReport,fontSize :  16,fontName : .InterBold)
        self.lblTitle.adjustsFontSizeToFitWidth = true
        self.view.backgroundColor = .colorBGSkyBlueLight
        
        self.tableView.addSubview(self.refreshControl)
        self.tableView.register(nibWithCellClass: NotificationListCell.self)
        self.apiCallReportList(true)
    }
    
    @objc func refreshData(){

        self.apiCallReportList()
    }
    
    func apiCallReportList(_ isLoader : Bool = false) {
        
        let parameters = APIParametersModel()
        parameters.userId = DeviceDetail.shared.isSimulator ? "1" : JSON(UserModelClass.current.userId as Any).stringValue
        
        
        self.vwReportList.callReportListAPI(router:self.reportListType == .underGroundReport ?   APIRouter.ur_listing_view_all(parameters.toDictionary()) : APIRouter.or_listing_view_all(parameters.toDictionary()),isLoader : isLoader) { responseJson, statusCode, message, completion in
            
            self.refreshControl.endRefreshing()
            
            if completion, let data = responseJson{
                debugPrint(data)
                
                self.tableView.reloadData()
            }
        }
    }
   
    
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension UGListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vwReportList.numberOfRowsInSectionInTableviewList(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: NotificationListCell.self)
        cell.configureCell(self.vwReportList.cellForRowAtInTableviewList(indexPath), self.reportListType.rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.reportListType == .underGroundReport{

            let vc = AppStoryBoard.main.viewController(viewControllerClass: UGReportDetailVC.self)
            vc.reportListType = .underGroundReport
            vc.reportId = self.vwReportList.cellForRowAtInTableviewList(indexPath)["id"].stringValue
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else {

            let vc = AppStoryBoard.main.viewController(viewControllerClass: OCReportDetailVC.self)
            vc.reportListType = .opneCastReport
            vc.reportId = self.vwReportList.cellForRowAtInTableviewList(indexPath)["id"].stringValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

