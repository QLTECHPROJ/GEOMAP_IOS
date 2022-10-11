//
//  AppFonts.swift
//  NSC_iOS
//
//  Created by Dhruvit on 12/05/22.
//

import Foundation

struct AppFonts {
    
    // Font Family
    let fontFamily = "Poppins"
    
    // Fonts
    let extraLight = "Poppins-ExtraLight"
    let light = "Poppins-Light"
    let medium = "Poppins-Medium"
    let semiBold = "Poppins-SemiBold"
    let bold = "Poppins-Bold"
    let regular = "Poppins-Regular"
    
    func appFont(ofSize size : CGFloat, weight : UIFont.Weight) -> UIFont {
        switch weight {
        case .ultraLight:
            return UIFont(name: extraLight, size: size) ?? UIFont.systemFont(ofSize: size, weight: .ultraLight)
        case .light:
            return UIFont(name: light, size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
        case .medium:
            return UIFont(name: medium, size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
        case .semibold:
            return UIFont(name: semiBold, size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
        case .bold:
            return UIFont(name: bold, size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
        default:
            return UIFont(name: regular, size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
    
}
