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
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        self.view.alpha = 0
        
        self.btnUnderGroundReport.isSelect = true
        
        DispatchQueue.main.async {
            self.btnUnderGroundReport.setTitle(kAddUndergroundsMappingReport, for: .normal)
           // self.btnUnderGroundReport.titleLabel?.adjustsFontSizeToFitWidth = true
            
            self.btnOpencastReport.setTitle(kAddOpenCastMappingReport, for: .normal)
            //self.btnOpencastReport.titleLabel?.adjustsFontSizeToFitWidth = true
        }
       
    }
    
    
    func openPopUpVisiable(){
        UIView.animate(withDuration: 0.5, delay: 0.0) {
            self.view.alpha = 1
        }
    }
    
    func closePopUpVisiable(isCompletion : Bool = false,sender : UIButton,tagInt : Int?){
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            
            self.view.alpha = 0
            
        }, completion: { (finished: Bool) in
            self.dismiss(animated: false) {
                if isCompletion,let _ = tagInt{
                    
                    self.delegate?.handleAction(sender: sender, popUpTag:tagInt!)
                }
            }
        })
    }
    
    // MARK: - ACTIONS
    @IBAction func btnClosedTapped(_ sender: UIButton) {
//        self.dismiss(animated: false)
        self.closePopUpVisiable(sender: sender,tagInt: nil)
    }
    @IBAction func btnUndergroundReportClicked(_ sender: UIButton) {
//        self.dismiss(animated: false) {
//            self.delegate?.handleAction(sender: sender, popUpTag:0)
//        }
        self.closePopUpVisiable(isCompletion : true,sender : sender,tagInt : 0)
    }
    
    @IBAction func btnOpenCastMappingReportClicked(_ sender: UIButton) {
//        self.dismiss(animated: false) {
//            self.delegate?.handleAction(sender: sender, popUpTag: 1)
//        }
        self.closePopUpVisiable(isCompletion : true,sender : sender,tagInt : 1)
    }
    
}
