//
//  NotificationVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 19/07/22.
//

import UIKit

enum ReportListType  : String{
    case underGroundReport
    case opneCastReport
}

class UGListVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    // MARK: - VARIABLES
        
    var arrReportsList : [JSON] = []
    
    var reportListType : ReportListType = .underGroundReport
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        self.tableView.register(nibWithCellClass: NotificationListCell.self)
        
        self.apiCallReportList()
    }
    
    
    // MARK: - FUNCTIONS
    
    func setUpUI(){
     
        self.lblTitle.applyLabelStyle(text: self.reportListType == .underGroundReport ? kUndergroundsMappingReport : kOpenCastMappingReport,fontSize :  20,fontName : .InterBold)
        self.lblTitle.adjustsFontSizeToFitWidth = true
        self.view.backgroundColor = .colorBGSkyBlueLight
    }
    
    func apiCallReportList() {
        let vwReportList = ReportListVM()
        let parameters = APIParametersModel()
        parameters.userId = "1"
        
        vwReportList.callReportListAPI(parameters: parameters.toDictionary()) { responseJson, statusCode, message, completion in
            
            if completion, let data = responseJson{
                debugPrint(data)
                
                self.tableView.reloadData()
            }
        }
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.refreshData()
        refreshControl.endRefreshing()
    }
    
    func refreshData() {
        
        self.apiCallReportList()
        
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: NotificationListCell.self)
        //cell.configureCell(data: arrayNotifications[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.reportListType == .underGroundReport{

            let vc = AppStoryBoard.main.viewController(viewControllerClass: UGReportDetailVC.self)
            vc.reportListType = .underGroundReport
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else {

            let vc = AppStoryBoard.main.viewController(viewControllerClass: OCReportDetailVC.self)
            vc.reportListType = .opneCastReport
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

