//
//  EarningVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 17/05/22.
//

import UIKit

class EarningVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblNoData: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - VARIABLES
    var totalBalance = ""
    var transactions = [TransactionModel]()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblBalance.text = "₹ 0"
        
        lblNoData.isHidden = true
        lblNoData.text = Theme.strings.no_earnings
        
        tableView.register(nibWithCellClass: TransationsCell.self)
        
        refreshData()
    }
    
    
    // MARK: - FUNCTIONS
    override func setupData() {
        lblBalance.text = totalBalance
        tableView.reloadData()
        
        lblNoData.isHidden = transactions.count != 0
        tableView.isHidden = transactions.count == 0
    }
    
    override func refreshData() {
        let earningVM = EarningViewModel()
        earningVM.callMyEarningAPI { success in
            if success {
                self.totalBalance = earningVM.totalBalance
                self.transactions = earningVM.transactions
                self.setupData()
            }
        }
    }
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension EarningVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TransationsCell.self)
        cell.configureCell(data: transactions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
}
