//
//  CampDaysVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 27/04/22.
//

import UIKit

class CampDaysVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var lblNoData: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - VARIABLES
    var campID = ""
    var campName = ""
    var totalDays = ""
    var arrayDays = [CampDaysDetailModel]()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNoData.isHidden = true
        lblNoData.text = Theme.strings.alert_something_went_wrong
        
        tableView.register(nibWithCellClass: TitleLabelCell.self)
        tableView.register(nibWithCellClass: DayListCell.self)
        tableView.refreshControl = self.refreshControl
        
        self.refreshData()
    }
    
    
    // MARK: - FUNCTIONS
    override func setupData() {
        lblNoData.isHidden = arrayDays.count > 0
        tableView.isHidden = arrayDays.count == 0
        
        tableView.reloadData()
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.refreshData()
        refreshControl.endRefreshing()
    }
    
    override func refreshData() {
        let campDaysViewModel = CampDaysViewModel()
        campDaysViewModel.callDayListingAPI(campId: campID) { success in
            if success {
                self.totalDays = campDaysViewModel.totalDays
                self.arrayDays = campDaysViewModel.days
                self.setupData()
            }
        }
    }
    
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CampDaysVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: DayListCell.self)
        cell.configureCell(data: arrayDays[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withClass: TitleLabelCell.self)
        cell.lblTitle.text = campName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrayDays[indexPath.row].currentDay == "1" {
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:KidsAttendanceVC.self)
            aVC.campID = self.campID
            aVC.campName = self.campName
            aVC.dayID = arrayDays[indexPath.row].dayId
            aVC.dayshift = arrayDays[indexPath.row].dayshift
            self.navigationController?.pushViewController(aVC, animated: true)
        }
    }
    
}
