//
//  NotificationVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 19/07/22.
//

import UIKit

class NotificationVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - VARIABLES
    var arrayNotifications = [NotificationListDataModel]()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNoData.isHidden = true
        lblNoData.text = Theme.strings.no_data_found
        
        tableView.register(nibWithCellClass: NotificationListCell.self)
        tableView.refreshControl = self.refreshControl
        
        refreshData()
    }
    
    
    // MARK: - FUNCTIONS
    override func setupData() {
        lblNoData.isHidden = arrayNotifications.count != 0
        tableView.isHidden = arrayNotifications.count == 0
        tableView.reloadData()
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.refreshData()
        refreshControl.endRefreshing()
    }
    
    override func refreshData() {
        let notificationListVM = NotificationListViewModel()
        notificationListVM.callNotificationListAPI { success in
            if success {
                self.arrayNotifications = notificationListVM.arrayNotifications
            }
            self.setupData()
        }
    }
    
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: NotificationListCell.self)
        cell.configureCell(data: arrayNotifications[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

