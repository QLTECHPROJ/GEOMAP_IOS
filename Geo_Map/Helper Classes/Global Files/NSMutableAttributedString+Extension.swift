//
//  NSMutableAttributedString+Extension.swift


import Foundation
import UIKit

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


extension NSMutableAttributedString {
    
    class func getAttributedString(fromString string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string)
    }
    
    func apply(attribute: [NSAttributedString.Key: Any], subString: String)  {
        if let range = self.string.range(of: subString) {
            self.apply(attribute: attribute, onRange: NSRange(range, in: self.string))
        }
    }
    
    func apply(attribute: [NSAttributedString.Key: Any], onRange range: NSRange) {
        if range.location != NSNotFound {
            self.setAttributes(attribute, range: range)
        }
    }
    
    // Apply color on substring
      func apply(color: UIColor, subString: String) {
        
        if let range = self.string.range(of: subString) {
          self.apply(color: color, onRange: NSRange(range, in:self.string))
        }
      }
    // Apply color on given range
      func apply(color: UIColor, onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.foregroundColor: color],
                           range: onRange)
      }
    
    func apply(font: UIFont, subString: String)  {
        
        if let range = self.string.range(of: subString) {
          self.apply(font: font, onRange: NSRange(range, in: self.string))
        }
      }
      
      // Apply font on given range
      //2
      func apply(font: UIFont, onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.font: font], range: onRange)
      }
}
