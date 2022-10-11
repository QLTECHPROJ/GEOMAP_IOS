//
//  DescriptionPopupVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 29/04/22.
//

import UIKit

class DescriptionPopupVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    
    
    // MARK: - VARIABLES
    var clickedOk : (() -> Void)?
    var clickedClose : (() -> Void)?
    
    var titleColor = Theme.colors.textColor
    
    var titleFont = Theme.fonts.appFont(ofSize: 18, weight: .bold)
    var descFont = Theme.fonts.appFont(ofSize: 15, weight: .regular)
    
    var strTitle = ""
    var strDesc = ""
    
    var isOkButtonHidden = true
    var isDisclaimerBtnHide = true
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.numberOfLines = 2
        //lblTitle.text = strTitle
        lblTitle.isHidden = ( strTitle.trim.count == 0 )
        lblTitle.attributedText = strTitle.attributedString(alignment: .center, lineSpacing: 2)
        lblDesc.attributedText = strDesc.attributedString(alignment: .left, lineSpacing: 2)
        
        btnOK.isHidden = isOkButtonHidden
        btnClose.isHidden = !isOkButtonHidden
        
        lblTitle.font = titleFont
        lblDesc.font = descFont
    }
    
    
    // MARK: - ACTIONS
    @IBAction func okClicked(_ sender: UIButton) {
        self.clickedOk?()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func closeClicked(_ sender: UIButton) {
        self.clickedClose?()
        self.dismiss(animated: false, completion: nil)
    }
    
}
