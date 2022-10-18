//
//  DescriptionPopupVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 29/04/22.
//

import UIKit

protocol AddReportPopUpDelegate {
    func handleAction(sender : UIButton, popUpTag : Int )
}

class DescriptionPopupVC: BaseViewController {
    
    // MARK: - OUTLETS
  
    @IBOutlet weak var btnUG: UIButton!
    @IBOutlet weak var btnOC: UIButton!
    
    
    // MARK: - VARIABLES
    var clickedUG : (() -> Void)?
    var clickedOC : (() -> Void)?
    
    var isUGButtonHidden = true
    
    var popUpTag = 0
    
    // 0 : Delete, 1 : Close
    var delegate : AddReportPopUpDelegate?

    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
       // btnUG.isHidden = isUGButtonHidden
       // btnOC.isHidden = !isUGButtonHidden
        
       
    }
    
    
    // MARK: - ACTIONS
    @IBAction func ugClicked(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.delegate?.handleAction(sender: sender, popUpTag:0)
        }
    }
    
    @IBAction func ocClicked(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.delegate?.handleAction(sender: sender, popUpTag: 1)
        }
    }
    
}
