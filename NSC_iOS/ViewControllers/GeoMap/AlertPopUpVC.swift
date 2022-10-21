//
//  AlertPopUpVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 29/04/22.
//

import UIKit


protocol AlertPopUpVCDelegate {
    func handleAction(sender : UIButton, popUpTag : Int )
}


class AlertPopUpVC: ClearNaviagtionBarVC {
    
    
    // MARK: - OUTLETS
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDetail : UILabel!
    
    @IBOutlet weak var btnDelete : AppThemeBlueButton!
    @IBOutlet weak var btnClose : AppThemeBorderBlueButton!
    
    
    // MARK: - VARIABLES
    var titleText = Theme.strings.normal_update_title
    var detailText = Theme.strings.normal_update_subtitle
    
    var firstButtonTitle = Theme.strings.update
    var secondButtonTitle = Theme.strings.not_now
    
    var firstButtonBackgroundColor = Theme.colors.theme_dark
    var secondButtonBackgroundColor = UIColor.clear
    
    var firstButtonTitleColor = Theme.colors.white
    var secondButtonTitleColor = Theme.colors.theme_dark
    
    var hideFirstButton = false
    var hideSecondButton = false
    
    var isFirstButtonGradient = true
    var isSecondButtonGradient = false
    
    var popUpTag = 0
    
    // 0 : Delete, 1 : Close
    var delegate : AlertPopUpVCDelegate?
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupUI()
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI(){
      
        self.lblTitle.applyLabelStyle(text : titleText,fontSize :  16,fontName : .InterBold)
        self.lblDetail.applyLabelStyle(fontSize : 14,fontName : .InterMedium)
        
        lblDetail.attributedText = detailText.attributedString(alignment: .center, lineSpacing: 5)
        
        lblTitle.numberOfLines = 0
        
        btnDelete.isHidden = firstButtonTitle.count == 0
        btnClose.isHidden = secondButtonTitle.count == 0
        
        self.btnDelete.isSelect = true
        btnDelete.setTitle(firstButtonTitle, for: UIControl.State.normal)
        btnDelete.setTitleColor(firstButtonTitleColor, for: .normal)
        btnDelete.backgroundColor = firstButtonBackgroundColor
        
        btnClose.setTitle(secondButtonTitle, for: UIControl.State.normal)
        btnClose.setTitleColor(secondButtonTitleColor, for: .normal)
        btnClose.backgroundColor = secondButtonBackgroundColor
        
        btnDelete.isHidden = hideFirstButton
        btnClose.isHidden = hideSecondButton
        
        if isFirstButtonGradient {
            btnDelete.backgroundColor = Theme.colors.theme_dark
        }
        
        if isSecondButtonGradient {
            btnClose.backgroundColor = Theme.colors.theme_dark
        }
    }
    
    
    // MARK: - ACTIONS
    @IBAction func btnOkTapped(_ sender : UIButton) {
        self.dismiss(animated: false) {
            self.delegate?.handleAction(sender: sender, popUpTag: self.popUpTag)
            
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
                AppDelegate.shared.updateWindow()
            }
        }
    }
    
    @IBAction func btnCancelTapped(_ sender : UIButton) {
        self.dismiss(animated: false) {
           
        }
    }
    
}

