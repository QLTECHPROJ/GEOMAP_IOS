//
//  CampListVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 27/04/22.
//

import UIKit

class HomeVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnAddReport: UIButton!
    
    
    
    // MARK: - VARIABLES
    
    
    private var vwReportList : ReportListVM = ReportListVM()
    
    lazy var refreshControl                                 : UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
          #selector(self.refreshData),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.colorSkyBlue
        return refreshControl
    }()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        
        self.view.backgroundColor = .colorBGSkyBlueLight
        self.btnAddReport.applystyle(isAdjustToFont : true ,fontname : .InterSemibol,fontsize : 14,titleText : kAddReport,titleColor : .colorSkyBlue)
        
        let stringAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Theme.colors.theme_dark,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        
        let strTitle = kApplyNow
        let titleRange = (strTitle as NSString).range(of: strTitle)
        
        let attributedString = NSMutableAttributedString.getAttributedString(fromString: strTitle)
        attributedString.addAttributes(stringAttributes, range: titleRange)
                
        self.tableView.register(nibWithCellClass: NotificationListCell.self)
        self.tableView.register(nibWithCellClass: TitleLabelCell.self)
        self.tableView.register(nibWithCellClass: NotificationListCell.self)
        self.tableView.addSubview(self.refreshControl)
        self.apiCallReportList(true)
    }
    
    @objc func refreshData(){

        self.apiCallReportList()
    }
    
    func apiCallReportList(_ isLoader : Bool = false) {
        
        let parameters = APIParametersModel()
        parameters.userId = DeviceDetail.shared.isSimulator ? "1" : JSON(UserModelClass.current.userId as Any).stringValue
        
        self.vwReportList.callHomeReportListAPI(parameters: parameters.toDictionary(),isLoader : isLoader) { responseJson, statusCode, message, completion in
            self.refreshControl.endRefreshing()
            if completion, let data = responseJson{
                debugPrint(data)
                
                self.tableView.reloadData()
            }
        }
    }

    
    // MARK: - ACTION
    @IBAction func addReportClicked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: DescriptionPopupVC.self)        
        aVC.modalPresentationStyle = .overFullScreen
        aVC.delegate = self
        self.present(aVC, animated: false, completion :{
            aVC.openPopUpVisiable()
        })
    }
  
    @IBAction func btnOpenMenuTapped(_ sender : UIButton){
        let aVC = AppStoryBoard.main.viewController(viewControllerClass:UserListPopUpVC.self)
        navigationController?.pushViewController(aVC, animated: true)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.vwReportList.numberOfSectionsInTableview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.vwReportList.numberOfRowsInSectionInTableview(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withClass: NotificationListCell.self)
        cell.configureCell(self.vwReportList.cellForRowAtInTableview(indexPath),self.vwReportList.viewForHeaderInSectionData(indexPath.section)["type"].stringValue)
        debugPrint(self.vwReportList.viewForHeaderInSectionData(indexPath.section))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withClass: TitleLabelCell.self)
        cell.contentView.backgroundColor = .colorBGSkyBlueLight
        cell.btnViewAll.tag = section
        
        cell.lblTitle.text = self.vwReportList.viewForHeaderInSectionData(section)["title"].stringValue
        
        cell.btnViewAll.handleTapToAction {
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:UGListVC.self)
            aVC.self.reportListType = self.vwReportList.viewForHeaderInSectionData(section)["type"].stringValue == ReportListType.underGroundReport.rawValue ? .underGroundReport : .opneCastReport
            self.navigationController?.pushViewController(aVC, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let type = self.vwReportList.viewForHeaderInSectionData(indexPath.section)["type"].stringValue
        
        if type == ReportListType.underGroundReport.rawValue{

            let vc = AppStoryBoard.main.viewController(viewControllerClass: UGReportDetailVC.self)
            vc.reportListType = .underGroundReport
            vc.reportId = self.vwReportList.viewForHeaderInSectionData(indexPath.section)["data"][indexPath.row]["id"].stringValue
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else {

            let vc = AppStoryBoard.main.viewController(viewControllerClass: OCReportDetailVC.self)
            vc.reportListType = .opneCastReport // kOpenCastMappingReportDetails
            vc.reportId = self.vwReportList.viewForHeaderInSectionData(indexPath.section)["data"][indexPath.row]["id"].stringValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


// MARK: - AlertPopUpVCDelegate
extension HomeVC : AddReportPopUpDelegate {
    
    func handleAction(sender: UIButton, popUpTag: Int) {
        if popUpTag == 0 {
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: UGGeoAttributeVC.self)
            self.navigationController?.pushViewController(aVC, animated: true)
            
        }else {
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: OCGeoAttributeVC.self)
            self.navigationController?.pushViewController(aVC, animated: true)
        }
    }
}
