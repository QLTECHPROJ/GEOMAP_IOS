//
//  UIFont+Extension.swift
//  NSC_iOS
//
//  Created by vishal parmar on 19/10/22.
//

import Foundation
import UIKit


enum CustomFont : String {    
    
    //MARK: - Inter Font Family
    
    case InterMedium              = "Inter-Medium"
    case InterSemibol             = "Inter-SemiBold"
    case InterBold                = "Inter-Bold"
    case InterRegular             = "Inter-Regular"
    case InterThin                = "Inter-Thin"
    case InterExtraLight          = "Inter-ExtraLight"
    case InterLight               = "Inter-Light"
    case InterExtraBold           = "Inter-ExtraBold"
    case InterBlack               = "Inter-Black"
    case InterItalic              = "Inter-Italic"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}
extension UIFont {

    class func applyCustomFont(fontName : CustomFont,fontSize : CGFloat ,isAspectRasio : Bool = true)-> UIFont{
        if isAspectRasio{
            return UIFont.init(name: fontName.rawValue , size: fontSize * kFontAspectRatio)!
            
        }else{
            return UIFont.init(name: fontName.rawValue, size: fontSize)!
        }
    }
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return Theme.fonts.appFont(ofSize: size, weight: .regular)
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return Theme.fonts.appFont(ofSize: size, weight: .bold)
    }
    
    @objc class func lightSystemFont(ofSize size: CGFloat) -> UIFont {
        return Theme.fonts.appFont(ofSize: size, weight: .light)
    }
    
    @objc class func semiBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return Theme.fonts.appFont(ofSize: size, weight: .semibold)
    }
    
    @objc convenience init?(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = Theme.fonts.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = Theme.fonts.bold
        case "CTFontLightUsage":
            fontName = Theme.fonts.light
        case "CTFontSemiboldUsage":
            fontName = Theme.fonts.semiBold
        default:
            fontName = Theme.fonts.regular
        }
        
        self.init(name: fontName, size: fontDescriptor.pointSize)
    }
    
    class func overrideInitialize() {
        guard self == UIFont.self else { return }
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        if let lightSystemFontMethod = class_getClassMethod(self, #selector(lightSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(lightSystemFont(ofSize:))) {
            method_exchangeImplementations(lightSystemFontMethod, myItalicSystemFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
