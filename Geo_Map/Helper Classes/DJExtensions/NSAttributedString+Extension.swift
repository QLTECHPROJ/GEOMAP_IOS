//
//  NSAttributedString+Extension.swift
//

import Foundation
import UIKit

extension NSAttributedString {
    
    class func HTMLString(_ HTMLString: String) throws -> NSAttributedString?{
        let data = HTMLString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        do {
            return try NSAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                 .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch  {
            NSException(name: NSExceptionName(rawValue: "Html"), reason: "Not convert", userInfo: nil).raise()
        }
        return nil
    }
    
    class func attributedString(_ string: String, withFont font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    
}

extension NSMutableAttributedString{
    
    func setAttributes(color: UIColor = .colorTextBlack, forText stringValue: String,font : CGFloat,fontname : CustomFont) {
        
        var textFontStyle  : UIFont!
        var textColor : UIColor!
        var textFont : CGFloat!
    
        textColor = color
        
        if font == 0.0{
            
            textFont = CGFloat(kMediumFontSize)
        }else{
            
            textFont = CGFloat(font)
        }
        
        textFontStyle = UIFont.applyCustomFont(fontName: fontname, fontSize: textFont)
        
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttributes([NSAttributedString.Key.foregroundColor : textColor ,NSAttributedString.Key.font : textFontStyle], range:range)
    }
}
