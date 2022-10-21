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

class DescriptionPopupVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
  
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var btnUnderGroundReport: AppThemeBlueButton!
    @IBOutlet weak var btnOpencastReport: AppThemeBorderBlueButton!
    
    
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
        
        self.setUpUI()
    }
    
    // MARK: - FUNCTIONS
    
    func setUpUI(){
        self.btnUnderGroundReport.isSelect = true
        self.btnUnderGroundReport.setTitle(kAddUndergroundsMappingReport, for: .normal)
        self.btnOpencastReport.setTitle(kAddOpenCastMappingReport, for: .normal)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
    }
    
    // MARK: - ACTIONS
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: false)
    }
    @IBAction func btnUndergroundReportClicked(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.delegate?.handleAction(sender: sender, popUpTag:0)
        }
    }
    
    @IBAction func btnOpenCastMappingReportClicked(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.delegate?.handleAction(sender: sender, popUpTag: 1)
        }
    }
    
}
