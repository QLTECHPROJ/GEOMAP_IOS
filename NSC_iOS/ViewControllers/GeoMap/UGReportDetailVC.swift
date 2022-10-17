//
//  ContactVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 13/05/22.
//

import Foundation
import ContactsUI
import MessageUI
import EVReflection

class UGReportDetailVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    // MARK: - VARIABLES
   
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
        tableView.register(nibWithCellClass: ContactCell.self)
        
      
        lblNoData.isHidden = true
        
        lblNoData.isHidden = true
        lblNoData.text = Theme.strings.no_contacts_to_display
        lblNoData.textColor = Theme.colors.textColor
        
        tableView.reloadData()
    }
    
    override func setupData() {
        
        tableView.reloadData()
        
    }
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UGReportDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ContactCell.self)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}
