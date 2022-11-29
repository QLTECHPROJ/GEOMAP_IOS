//
//  UIFont+Extension.swift
//  Geo_Map
//
//  Created by vishal parmar on 19/10/22.
//

import Foundation
import UIKit


enum CustomFont : String {
    
    //MARK: - Montserrat font Family
    
    case MFONTREGULAR            = "Montserrat-Regular"
    case MFONTBOLD               = "Montserrat-Bold"
    case MFONTSEMIBOLD           = "Montserrat-SemiBold"
    case MFONTLIGHT              = "Montserrat-Light"
    case MFONTMEDIUM             = "Montserrat-Medium"
    case MFONTEXTRABOLD          = "Montserrat-ExtraBold"
    
    case GeorgiaRegular          = "Georgia"
    case GeorgiaBold             = "Georgia-Bold"
    case GeorgiaBoldItalic       = "Georgia-BoldItalic"
    case GeorgiaRegularItalic    = "Georgia-Italic"
    
    //MARK: - Inter Font Family
    
    case InterMedium    = "Inter-Medium"
    case InterSemibol   = "Inter-SemiBold"
    case InterBold      = "Inter-Bold"
    
}

extension UIFont {

    class func applyCustomFont(fontName : CustomFont,fontSize : CGFloat ,isAspectRasio : Bool = true)-> UIFont{
        if isAspectRasio{
            return UIFont.init(name: fontName.rawValue , size: fontSize * kFontAspectRatio)!
            
        }else{
            return UIFont.init(name: fontName.rawValue, size: fontSize)!
        }
    }
}
