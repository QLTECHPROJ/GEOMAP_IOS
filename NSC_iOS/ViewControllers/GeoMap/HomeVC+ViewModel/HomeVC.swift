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
    
    @IBOutlet weak var imgMenu: UIImageView!
    
    
    // MARK: - VARIABLES
    
    var arrUnderGroundList = [CampDetailModel]()
    var arrayUpcomingCampList = [CampDetailModel]()
    
    var vwReportList : ReportListVM = ReportListVM()
    
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
        
        let tapGestureToOpenMenu = UITapGestureRecognizer(target: self, action: #selector(self.openMenu(_:)))
        self.imgMenu.isUserInteractionEnabled = true
        self.imgMenu.addGestureRecognizer(tapGestureToOpenMenu)
        
        tableView.register(nibWithCellClass: NotificationListCell.self)
        tableView.register(nibWithCellClass: TitleLabelCell.self)
        tableView.register(nibWithCellClass: NotificationListCell.self)
        self.apiCallReportList()
    }
    
    func apiCallReportList() {
        
        let parameters = APIParametersModel()
        parameters.userId = "1"
        
        self.vwReportList.callReportListAPI(parameters: parameters.toDictionary()) { responseJson, statusCode, message, completion in
            
            if completion, let data = responseJson{
                debugPrint(data)
                
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func openMenu(_ gesture : UIGestureRecognizer){
        let aVC = AppStoryBoard.main.viewController(viewControllerClass:UserListPopUpVC.self)
        navigationController?.pushViewController(aVC, animated: true)
     }

    
    //MARK: - ACTION
  
    
    // MARK: - ACTION
    @IBAction func addReportClicked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: DescriptionPopupVC.self)        
        aVC.modalPresentationStyle = .overFullScreen
        aVC.delegate = self
        self.present(aVC, animated: false, completion :{
            aVC.openPopUpVisiable()
        })
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
            vc.reportListType = .underGroundReport//kUndergroundsMappingReportDetails
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else {

            let vc = AppStoryBoard.main.viewController(viewControllerClass: OCReportDetailVC.self)
            vc.reportListType = .opneCastReport // kOpenCastMappingReportDetails
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
