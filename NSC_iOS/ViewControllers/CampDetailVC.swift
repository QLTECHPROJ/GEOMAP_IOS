//
//  CampDetailVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 27/04/22.
//

import UIKit

class CampDetailVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgViewLocation: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnKids: UIButton!
    
    @IBOutlet weak var viewFees: UIView!
    @IBOutlet weak var viewFeesHeightConst: NSLayoutConstraint!
    @IBOutlet weak var lblFees: UILabel!
    @IBOutlet weak var lblDaysAvailable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - VARIABLES
    var strCampID = ""
    var campDetails: CampDetailModel?
    var arrayFees = [String]()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(nibWithCellClass: CampDayFeesCell.self)
        
        DispatchQueue.main.async {
            self.btnKids.isUserInteractionEnabled = false
            self.btnKids.backgroundColor = Theme.colors.gray_7E7E7E
        }
        
        setupData()
        refreshData()
    }
    
    
    // MARK: - FUNCTIONS
    override func setupData() {
        guard let campDetails = campDetails else {
            imgView.image = nil
            imgViewLocation.isHidden = true
            lblName.text = ""
            lblAddress.text = ""
            lblDescription.text = ""
            
            return
        }
        
        if let strUrl = campDetails.CampImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let imgUrl = URL(string: strUrl) {
            imgView.sd_setImage(with: imgUrl, completed: nil)
        }
        
        imgViewLocation.isHidden = false
        
        lblName.text = campDetails.CampName
        lblAddress.text = campDetails.CampAddress
        lblDescription.attributedText = campDetails.CampDetail.attributedString(alignment: .center, lineSpacing: 5)
        
        if campDetails.isWorkingDay == "1" && campDetails.dayshift.trim.count > 0 {
            btnKids.isUserInteractionEnabled = true
            btnKids.backgroundColor = Theme.colors.theme_dark
        } else {
            btnKids.isUserInteractionEnabled = false
            btnKids.backgroundColor = Theme.colors.gray_7E7E7E
        }
        
        if arrayFees.count > 0 {
            viewFeesHeightConst.constant = 60 + CGFloat(arrayFees.count * 30)
            self.view.layoutIfNeeded()
        } else {
            viewFeesHeightConst.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    override func refreshData() {
        let campDetailVM = CampDetailViewModel()
        campDetailVM.callCampDetailsAPI(campId: strCampID) { success in
            if success {
                self.campDetails = campDetailVM.campDetails
                self.setupData()
            }
        }
    }
    
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func kidsClicked(_ sender: UIButton) {
        guard let campDetails = campDetails else {
            return
        }
        
        let aVC = AppStoryBoard.main.viewController(viewControllerClass:KidsAttendanceVC.self)
        aVC.campID = campDetails.CampId
        aVC.campName = campDetails.CampName
        aVC.dayshift = campDetails.dayshift
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
}


extension CampDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFees.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: CampDayFeesCell.self)
        return cell
    }
    
}
