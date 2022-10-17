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
        
    }

    
    //MARK:- ACTION
    @IBAction func userMenuClicked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass:UserListPopUpVC.self)
        navigationController?.pushViewController(aVC, animated: true)
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
       
    }
    
}
