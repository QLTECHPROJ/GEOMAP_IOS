//
//  SupportPopupVC.swift
//  BWS_iOS_2
//
//  Created by Dhruvit on 16/09/21.
//  Copyright © 2021 Dhruvit. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class SupportPopupVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDetail : TTTAttributedLabel!
    @IBOutlet weak var btnClose : UIButton!
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureSupportPopup()
    }
    
    
    // MARK: - Configure Support Popup
    func configureSupportPopup() {
        lblTitle.text = "Support"
        
        let strEmail = "a@gmail.com"
        let strChat = "Start Your Chat Now"
        let string = "support" + "\n\(strEmail)" + "\nOR" + "\n\(strChat)"
        let nsString = string as NSString
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        
        let fullAttributedString = NSAttributedString(string:string, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor: Theme.colors.textColor.cgColor,
           // NSAttributedString.Key.font: Theme.fonts.montserratFont(ofSize: 13, weight: .regular),
        ])
        
        lblDetail.textAlignment = .center
        lblDetail.attributedText = fullAttributedString
        
        let rangeEmail = nsString.range(of: strEmail)
        let rangeChat = nsString.range(of: strChat)
        
        let ppLinkAttributes: [String: Any] = [
            NSAttributedString.Key.foregroundColor.rawValue: Theme.colors.theme_dark,
            NSAttributedString.Key.underlineStyle.rawValue: false,
        ]
        
        lblDetail.activeLinkAttributes = [:]
        lblDetail.linkAttributes = ppLinkAttributes
        
        let urlEmail = URL(string: "action://SupportEmail")!
        let urlChat = URL(string: "action://SupportChat")!
        
        lblDetail.addLink(to: urlEmail, with: rangeEmail)
        lblDetail.addLink(to: urlChat, with: rangeChat)
        
        lblDetail.textColor = Theme.colors.textColor
        lblDetail.numberOfLines = 0
        lblDetail.delegate = self
        
        btnClose.setTitle(Theme.strings.close, for: .normal)
    }
    
    // MARK: - ACTIONS
    @IBAction func closeClicked(sender : UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}

