//
//  UITextView+Extension.swift
//  NSC_iOS
//
//  Created by vishal parmar on 21/10/22.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

extension IQTextView{
    
    open override func awakeFromNib() {
        super.awakeFromNib()

        self.keyboardAppearance = .dark
        if #available(iOS 10.0, *) {
            self.adjustsFontForContentSizeCategory = true
        }
    }
    
    func applyTextViewStyle(placeholderText : String = "",fontSize : CGFloat = kMediumFontSize,fontName : CustomFont,textColor : UIColor = .colorTextBlack, placeholerColor : UIColor = .colorTextBlack){
        
        self.placeholder = placeholderText
        self.placeholderTextColor = placeholerColor
        self.textColor = textColor
        self.font = UIFont.applyCustomFont(fontName: fontName, fontSize: fontSize)
    }
}

extension UITextView{
    
    open override func awakeFromNib() {
        super.awakeFromNib()

        self.keyboardAppearance = .dark
        if #available(iOS 10.0, *) {
            self.adjustsFontForContentSizeCategory = true
        }
    }
    
    func applyTextViewStyle(fontSize : CGFloat? = kMediumFontSize,fontName : CustomFont,textColor : UIColor = .colorTextBlack){
        self.textColor = textColor
        self.font = UIFont.applyCustomFont(fontName: fontName, fontSize: fontSize!)
    }
}
