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

class UGReportDetailVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnViewPDF: AppThemeBlueButton!
    
    // MARK: - VARIABLES
   
    
    var titleHeader : String = ""
    
    var arrReportDetails : [[String:Any]] = [
        [
            "title" : kMapSerialNo,
            "subtitle" : "1253DFSDF15235"
        ],
        [
            "title" : kDateColn,
            "subtitle" : "14 July 2022"
        ],
        [
            "title" : kShiftColn,
            "subtitle" : "Day Shift"
        ],
        [
            "title" : kMappedByColn,
            "subtitle" : "John Doe"
        ],
        [
            "title" : kScale,
            "subtitle" : "14:52 * 5223"
        ],
        [
            "title" : kLocationColn,
            "subtitle" : "Lauram ipsum, address here"
        ],
        [
            "title" : kVeinloadColn,
            "subtitle" : "John Doe"
        ],
        [
            "title" : kXCoordinateColn,
            "subtitle" : "12.7868,45.78787"
        ],
        [
            "title" : kYCoordinateColn,
            "subtitle" : "12.7868,45.78787"
        ],
        [
            "title" : kZCoordinateColn,
            "subtitle" : "12.7868,45.78787"
        ],
        [
            "title" : kAttributesColn,
            "subtitle" : "WKRWERK"
        ],
        [
            "title" : kNosColn,
            "subtitle" : "67"
        ],
        [
            "title" : kPropertiesColn,
            "subtitle" : "WKRWERK"
        ]
    ]
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.tableView.register(nibWithCellClass: ContactCell.self)
        
      
        self.tableView.reloadData()
        self.lblTitle.applyLabelStyle(text: self.titleHeader,fontSize :  20,fontName : .InterBold)
        self.lblTitle.adjustsFontSizeToFitWidth = true
        self.view.backgroundColor = .colorBGSkyBlueLight
        
        self.btnViewPDF.isSelect = true
        self.btnViewPDF.setTitle(kViewPDF, for: .normal)
    }
    
  
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnViewPDF(_ sender : UIButton) {
        let vc = AppStoryBoard.main.viewController(viewControllerClass: ViewPDFVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UGReportDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrReportDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withClass: ContactCell.self)
        cell.configureDataInCell(self.arrReportDetails[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
