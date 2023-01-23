//
//  HomeVC.swift


import UIKit
import DZNEmptyDataSet

class HomeVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnAddReport: UIButton!
    
    @IBOutlet weak var vwEmpty: UIView!
    
    @IBOutlet weak var btnAddReportEmpty: AppThemeBlueButton!
    
    
    
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
    
    private var emptyMessage : String = ""
    
    //----------------------------------------------------------------------------
    //MARK: - Memory management
    //----------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self.removeClassObservers()
    }
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.vwReportList.isDataEmpty{
            self.apiCallReportList(true)
        }
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.addClassObservers()
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
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.addSubview(self.refreshControl)
        self.apiCallReportList(true)
        
        self.btnAddReportEmpty.isSelect = true
        
//        self.btnAddReportEmpty.isHidden = !checkInternet()
        self.vwEmpty.bounds = self.view.bounds
    }
    
    @objc func refreshData(){

        self.apiCallReportList()
    }
    
    func apiCallReportList(_ isLoader : Bool = false) {
        
        let parameters = APIParametersModel()
        parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
        
        self.vwReportList.callHomeReportListAPI(parameters: parameters.toDictionary(),isLoader : isLoader) { responseJson, statusCode, message, completion in
            self.refreshControl.endRefreshing()
            if completion, let data = responseJson{
                debugPrint(data)
                
                
                self.tableView.reloadData()
            }
            else if let _ = message{
                
                self.emptyMessage = message!
                self.tableView.reloadData()
            }
            if self.vwReportList.numberOfSectionsInTableview() < 1{
                self.emptyMessage = kNoReportsFound
            }
            self.btnAddReportEmpty.isHidden = false // (checkInternet() && self.vwReportList.numberOfSectionsInTableview() < 1) ? false : true
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
    
    @IBAction func btnAddReportTapped(_ sender: UIButton) {
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


//-------------------------------------------------------------------
//MARK: - Empty TableView Methods
//-------------------------------------------------------------------
extension HomeVC : DZNEmptyDataSetDelegate, DZNEmptyDataSetSource{
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString {

        let text = (checkInternet() && self.vwReportList.numberOfSectionsInTableview() < 1) ? self.emptyMessage : ""
        let attributes = [NSAttributedString.Key.font: UIFont.applyCustomFont(fontName: .InterMedium, fontSize: 13), NSAttributedString.Key.foregroundColor: UIColor.colorTextBlack]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return !checkInternet() ? UIImage(named: "offline_page")! : UIImage()
        //return UIImage(named: "offline_page")!
    }
    
//    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
//        return self.vwEmpty
//    }
}

//-------------------------------------------------------------------
//MARK: - UITableView Methods
//-------------------------------------------------------------------
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
            aVC.self.reportListType = self.vwReportList.viewForHeaderInSectionData(section)["type"].stringValue == ReportListType.underGroundReport.rawValue ? .underGroundReport : .openCastReport
            self.navigationController?.pushViewController(aVC, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let type = self.vwReportList.viewForHeaderInSectionData(indexPath.section)["type"].stringValue
        
        guard checkInternet(true) else {
            return
        }
        
        if type == ReportListType.underGroundReport.rawValue{

            let vc = AppStoryBoard.main.viewController(viewControllerClass: UGReportDetailVC.self)
            vc.reportListType = .underGroundReport
            vc.reportId = self.vwReportList.viewForHeaderInSectionData(indexPath.section)["data"][indexPath.row]["mapSerialNo"].stringValue
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else {

            let vc = AppStoryBoard.main.viewController(viewControllerClass: OCReportDetailVC.self)
            vc.reportListType = .openCastReport
            vc.reportId = self.vwReportList.viewForHeaderInSectionData(indexPath.section)["data"][indexPath.row]["mappingSheetNo"].stringValue
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

//----------------------------------------------------------------------------
//MARK: - Class observers Methods
//----------------------------------------------------------------------------
extension HomeVC {
    func addClassObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reploadPageDate(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reploadPageDate(_:)), name: NSNotification.Name.reloadUGOCReportList, object: nil)
    }
    
    func removeClassObservers() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.reloadUGOCReportList, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    
    @objc func reploadPageDate(_ notification : NSNotification){
        
        self.apiCallReportList()
    }
}
