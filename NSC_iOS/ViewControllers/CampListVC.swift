//
//  CampListVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 27/04/22.
//

import UIKit

class CampListVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var imgBanner: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var btnApplyNow: UIButton!
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    
    // MARK: - VARIABLES
    var campListVM : CampListViewModel?
    
    var BannerImage = ""
    var arrayCurrentCampList = [CampDetailModel]()
    var arrayUpcomingCampList = [CampDetailModel]()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btnApplyNow.isHidden = true
        lblNoData.isHidden = true
        lblNoData.text = Theme.strings.no_camps_to_display
        
        tableView.register(nibWithCellClass: TitleLabelCell.self)
        tableView.register(nibWithCellClass: NotificationListCell.self)
        tableView.tableHeaderView = UIView()
        tableView.refreshControl = self.refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        self.refreshData()
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
        //imgUser.loadUserProfileImage(fontSize: 20)
       // let strName = (LoginDataModel.currentUser?.Fname ?? "") + " " + (LoginDataModel.currentUser?.Lname ?? "")
       // lblName.text = strName.trim.count > 0 ? strName : "Guest"
        
        let stringAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Theme.colors.theme_dark,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        
        let strTitle = "Apply Now"
        let titleRange = (strTitle as NSString).range(of: strTitle)
        
        let attributedString = NSMutableAttributedString.getAttributedString(fromString: strTitle)
        attributedString.addAttributes(stringAttributes, range: titleRange)
        btnApplyNow.setAttributedTitle(attributedString, for: .normal)
    }
    
    override func setupData() {
        
        if BannerImage.trim.count > 0, let strUrl = BannerImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let imgUrl = URL(string: strUrl) {
            imgBanner.sd_setImage(with: imgUrl, completed: nil)
            tableView.tableHeaderView = tableHeaderView
            tableView.reloadData()
        } else {
            tableView.tableHeaderView = UIView()
        }
        
        if arrayCurrentCampList.count > 0 || arrayUpcomingCampList.count > 0 {
            btnApplyNow.isHidden = true
            lblNoData.isHidden = true
            tableView.isHidden = false
        } else {
            btnApplyNow.isHidden = false
            lblNoData.isHidden = false
            tableView.isHidden = true
        }
        
        tableView.reloadData()
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.refreshData()
        refreshControl.endRefreshing()
    }
    
    override func refreshData() {
        let campListViewModel = CampListViewModel()
        campListViewModel.callCampListAPI(completion: { success in
            if success {
                self.BannerImage = campListViewModel.BannerImage
                self.arrayCurrentCampList = campListViewModel.arrayCurrentCampList
                self.arrayUpcomingCampList = campListViewModel.arrayUpcomingCampList
            }
            self.setupData()
        })
    }
    
    //MARK:- ACTION
    @IBAction func userMenuClicked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass:UserListPopUpVC.self)
        navigationController?.pushViewController(aVC, animated: true)
    }
    
    @IBAction func notificationClicked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass:NotificationVC.self)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    @IBAction func applyNowClicked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: ApplyForCampVC.self)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    @IBAction func bannerClicked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: ReferVC.self)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension CampListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withClass: NotificationListCell.self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withClass: NotificationListCell.self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withClass: TitleLabelCell.self)
        
        if section == 0 {
            cell.lblTitle.text = "Undergrounds Mapping Report "
            //cell.lblTitle.textColor = Theme.colors.theme_dark
        } else {
            //cell.lblTitle.textColor = Theme.colors.theme_dark
            cell.lblTitle.text = "OpenCast Mapping Report"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:CampDetailVC.self)
            aVC.strCampID = arrayCurrentCampList[indexPath.row].CampId
            aVC.campDetails = arrayCurrentCampList[indexPath.row]
            self.navigationController?.pushViewController(aVC, animated: true)
        } else {
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:CampDetailVC.self)
            aVC.strCampID = arrayUpcomingCampList[indexPath.row].CampId
            aVC.campDetails = arrayUpcomingCampList[indexPath.row]
            self.navigationController?.pushViewController(aVC, animated: true)
        }
    }
    
}
