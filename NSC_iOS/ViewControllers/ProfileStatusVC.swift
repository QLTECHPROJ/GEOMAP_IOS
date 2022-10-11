//
//  ProfileStatusVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 29/04/22.
//

import UIKit

class ProfileStatusVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var imgViewStatus: UIImageView!
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnRefer: UIButton!
    
    
    // MARK: - VARIABLES
    var coachStatusVM : CoachStatusViewModel?
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        fetchCoachSatusData()
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
        lblName.text = "Hello, \(LoginDataModel.currentUser?.Name ?? "")"
        
        let stringAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Theme.colors.theme_dark,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        
        let strTitle = "Refer a Coach"
        let titleRange = (strTitle as NSString).range(of: strTitle)
        
        let attributedString = NSMutableAttributedString.getAttributedString(fromString: strTitle)
        attributedString.addAttributes(stringAttributes, range: titleRange)
        btnRefer.setAttributedTitle(attributedString, for: .normal)
        
        lblStatus.text = ""
        lblSubTitle.text = ""
        imgViewStatus.isHidden = true
        
        DispatchQueue.main.async {
            self.btnContinue.isUserInteractionEnabled = false
            self.btnContinue.backgroundColor = Theme.colors.gray_7E7E7E
        }
    }
    
    override func setupData() {
        lblName.text = "Hello, \(LoginDataModel.currentUser?.Name ?? "")"
        
        guard let statusData = coachStatusVM?.coachStatusData else {
            return
        }
        
        lblStatus.text = statusData.Title
        lblSubTitle.attributedText = statusData.SubTitle.attributedString(alignment: .center, lineSpacing: 5)
        
        if statusData.Status == CoachStatus.Pending.rawValue || statusData.Status == CoachStatus.Rejected.rawValue {
            imgViewStatus.isHidden = true
            btnContinue.isUserInteractionEnabled = false
            btnContinue.backgroundColor = Theme.colors.gray_7E7E7E
        } else {
            imgViewStatus.isHidden = false
            btnContinue.isUserInteractionEnabled = true
            btnContinue.backgroundColor = Theme.colors.theme_dark
        }
    }
    
    func fetchCoachSatusData() {
        coachStatusVM = CoachStatusViewModel()
        coachStatusVM?.callCoachStatusAPI(completion: { success in
            self.setupData()
        })
    }
    
    
    // MARK: - ACTIONS
    @IBAction func continueCliked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass:CampListVC.self)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    @IBAction func refreshCliked(_ sender: UIButton) {
        fetchCoachSatusData()
    }
    
    @IBAction func referCliked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: ReferVC.self)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
}
