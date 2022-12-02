//
//  UILabel+Extension.swift
//  NSC_iOS
//
//  Created by vishal parmar on 19/10/22.
//

import Foundation
import UIKit


extension UILabel{
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 10.0, *) {
            self.adjustsFontForContentSizeCategory = true
        }
    
        if let textValue = self.text {
            
            if textValue != "Label" {
                debugPrint("NSLocalizedString UILabel ::::::::::::::::\(textValue)")
//                self.text = textValue.localized
            }
        }
    }
    
    func applyLabelShadow(cgSize : CGSize = CGSize(width: 0, height: 0),shadowOpacity : Float = 0.0,shadowRadius : CGFloat = 0.0,shadowColor : UIColor = .clear){
        self.layer.shadowOffset = cgSize
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = shadowColor.cgColor
    }
    
    func applyLabelStyle(isAdjustFontWidth : Bool = false,isApsectRadio : Bool = true, text : String = "",fontSize : CGFloat = kMediumFontSize,fontName : CustomFont,textColor : UIColor = .colorTextBlack){
        
        if text != ""{
            self.text = text
        }
        self.adjustsFontSizeToFitWidth = isAdjustFontWidth
        self.textColor = textColor
        
        self.font = UIFont.applyCustomFont(fontName: fontName, fontSize: fontSize, isAspectRasio: isApsectRadio)

    }
    
    func lineSpacing(lineSpacing : CGFloat? = 5, alignment : NSTextAlignment? = nil) -> UILabel {
        if let text = self.text {
            
            var attributedString = NSMutableAttributedString(string: text)
            
            var alignMentForText = self.textAlignment
            
            if let txtAlignMent = alignment {
                alignMentForText = txtAlignMent
            }
            
            if let attributedText = self.attributedText {
                attributedString = NSMutableAttributedString(attributedString: attributedText)
            }
            
            // *** Create instance of <code>NSMutableParagraphStyle</code>
            let paragraphStyle = NSMutableParagraphStyle()
            // *** set LineSpacing property in points ***
            paragraphStyle.lineSpacing = lineSpacing! // Whatever line spacing you want in points
            paragraphStyle.alignment = alignMentForText
            // *** Apply attribute to string ***
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            // *** Set Attributed String to your label ***
            self.attributedText = attributedString
            
        }
        
        return self
    }

    
}

