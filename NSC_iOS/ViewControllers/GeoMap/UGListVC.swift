//
//  NotificationVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 19/07/22.
//

import UIKit

class UGListVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    // MARK: - VARIABLES
    
    var titleHeader : String = ""
    
    var arrayNotifications = [NotificationListDataModel]()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        self.tableView.register(nibWithCellClass: NotificationListCell.self)
        
        self.refreshData()
    }
    
    
    // MARK: - FUNCTIONS
    
    func setUpUI(){
     
        self.lblTitle.applyLabelStyle(text: self.titleHeader,fontSize :  20,fontName : .InterBold)
        self.lblTitle.adjustsFontSizeToFitWidth = true
        self.view.backgroundColor = .colorBGSkyBlueLight
    }
    
    func setupData() {
        
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.refreshData()
        refreshControl.endRefreshing()
    }
    
    func refreshData() {
        /*
        let notificationListVM = NotificationListViewModel()
        notificationListVM.callNotificationListAPI { success in
            if success {
                self.arrayNotifications = notificationListVM.arrayNotifications
                self.tableView.reloadData()
            }
            self.setupData()
        }*/
        self.tableView.reloadData()
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
    
}

