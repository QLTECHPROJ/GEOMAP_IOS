//
//  ReferVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 13/05/22.
//

import UIKit

class ReferVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblReferralCode: UILabel!
    
    @IBOutlet weak var btnRefer: UIButton!
    @IBOutlet weak var viewRefer: UIView!
    
    
    // MARK: - VARIABLES
    var referDataVM : ReferDataViewModel?
    var referCode = ""
    var referLink = ""
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        referCode = LoginDataModel.currentUser?.Refer_Code ?? ""
        referLink = LoginDataModel.currentUser?.referLink ?? ""
        
        setupUI()
        fetchReferData()
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
        if let referDetail = referDataVM?.referDetail {
            referCode = referDetail.ReferCode
            referLink = referDetail.ReferLink
            
            lblTitle.text = referDetail.Title
            lblSubTitle.attributedText = referDetail.Subtitle.attributedString(alignment: .center, lineSpacing: 5)
        }
        
        lblReferralCode.text = referCode
        
        if referCode.trim.count > 0 && referLink.trim.count > 0 {
            btnRefer.isUserInteractionEnabled = true
            btnRefer.backgroundColor = Theme.colors.theme_dark
        } else {
            btnRefer.isUserInteractionEnabled = false
            btnRefer.backgroundColor = Theme.colors.gray_7E7E7E
        }
        
        viewRefer.addDashedBorder()
    }
    
    func fetchReferData() {
        referDataVM = ReferDataViewModel()
        referDataVM?.callReferDataAPI(completion: { success in
            self.setupUI()
        })
    }
    
    
    // MARK: - ACTION
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func copyCodeClicked(_ sender: UIButton) {
        if referCode.trim.count == 0 {
            showAlertToast(message: "Not available at the moment. Please contact support.")
            return
        }
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = referCode
        showAlertToast(message: Theme.strings.alert_promo_code_copied)
    }
    
    @IBAction func referClicked(_ sender: UIButton) {
        if referCode.trim.count == 0 || referLink.trim.count == 0 {
            showAlertToast(message: "Not available at the moment. Please contact support.")
            return
        }
        
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: ContactVC.self)
        aVC.referCode = self.referCode
        aVC.referLink = self.referLink
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
}
