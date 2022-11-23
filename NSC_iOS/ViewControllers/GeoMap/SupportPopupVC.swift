//
//  SupportPopupVC.swift
//  BWS_iOS_2
//
//  Created by Dhruvit on 16/09/21.
//  Copyright © 2021 Dhruvit. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class SupportPopupVC: ClearNaviagtionBarVC, TTTAttributedLabelDelegate {
    
    // MARK: - OUTLETS
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    @IBOutlet weak var btnClose : AppThemeBlueButton!
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureSupportPopup()
    }
    
    
    // MARK: - Configure Support Popup
    func configureSupportPopup() {
        self.view.alpha = 0
       
        self.imgView.image = UIImage(named: "supportimage")!
        
        self.lblTitle.applyLabelStyle(text : AppDelegate.shared.appVersionDetails["supportTitle"].stringValue,fontSize :  15,fontName : .InterSemibol)
       
        self.btnClose.isSelect = true
        self.btnClose.setTitle(kClose, for: .normal)
        
        let defaultFontAttribute = [NSAttributedString.Key.foregroundColor: UIColor.colorTextPlaceHolderGray ,NSAttributedString.Key.font: UIFont.applyCustomFont(fontName: .InterMedium, fontSize: 12.0)]
        let blueFontAttribute = [NSAttributedString.Key.foregroundColor: UIColor.colorTextBlack,NSAttributedString.Key.font: UIFont.applyCustomFont(fontName: .InterMedium, fontSize: 12.0)/*,NSAttributedString.Key.underlineColor: UIColor.colorSkyBlue, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue*/] as [NSAttributedString.Key : Any]
                
        self.lblDescription.text = "\(AppDelegate.shared.appVersionDetails["supportText"].stringValue)\n\(AppDelegate.shared.appVersionDetails["supportEmail"].stringValue)"
        self.lblDescription.attributedText = (self.lblDescription.text)?.getAttributedText(defaultDic: defaultFontAttribute, attributeDic: blueFontAttribute, attributedStrings: [AppDelegate.shared.appVersionDetails["supportEmail"].stringValue])
        
        self.lblDescription.lineSpacing(lineSpacing: 10.0, alignment: self.lblDescription.textAlignment)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.lblDescriptionTapped(_:)))
        self.lblDescription.isUserInteractionEnabled = true
        self.lblDescription.addGestureRecognizer(tap)
        
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
    }
    
    
    func openPopUpVisiable(){
        UIView.animate(withDuration: 0.5, delay: 0.0) {
            self.view.alpha = 1
        }
    }
    
    func closePopUpVisiable(){
       
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
           
            self.view.alpha = 0
            
        }, completion: { (finished: Bool) in
            
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    // MARK: - ACTIONS
    
    
    @objc func lblDescriptionTapped(_ tapGesture : UITapGestureRecognizer) {
        
        if tapGesture.didTapAttributedTextInLabel(label: self.lblDescription, inRange: (self.lblDescription.attributedText!.string as NSString).range(of: AppDelegate.shared.appVersionDetails["supportEmail"].stringValue)) {
            
            debugPrint(AppDelegate.shared.appVersionDetails["supportEmail"].stringValue)
           
            if let url = URL(string: "mailto:\(AppDelegate.shared.appVersionDetails["supportEmail"].stringValue)") {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    @IBAction func closeClicked(sender : UIButton) {
        self.closePopUpVisiable()
    }
    
}

