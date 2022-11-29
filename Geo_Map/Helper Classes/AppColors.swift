//
//  AppColors.swift
//  Geo_Map
//
//  Created by Dhruvit on 12/05/22.
//

import Foundation
import UIKit

struct AppColors {
    
//    var themeColors: ColorPalette {
//        get {
//            if isSystemDarkMode {
//                return darkPalette
//            }
//            return brightPalette
//        }
//    }
    
    let white = UIColor.white
    let black = UIColor.black
    let blue = UIColor.blue
    let red = UIColor.red
    
    let black_40_opacity = UIColor.black.withAlphaComponent(0.4)
    let white_40_opacity = UIColor.black.withAlphaComponent(0.4)
    
    let off_white_F9F9F9 = UIColor(hex: "F9F9F9")
    
    let green_008D36 = UIColor(hex: "008D36")
    let yellow_F3DE29 = UIColor(hex: "F3DE29")
    
    let gray_7E7E7E = UIColor(hex: "7E7E7E")
    let gray_666666 = UIColor(hex: "666666")
    let gray_707070 = UIColor(hex: "707070")
    let gray_999999 = UIColor(hex: "999999")
    let gray_CDD4D9 = UIColor(hex: "CDD4D9")
    let gray_DDDDDD = UIColor(hex: "DDDDDD")
    let gray_EEEEEE = UIColor(hex: "EEEEEE")
    
    let black_404040 = UIColor(hex: "404040")
    
    // NSC Coach App Colors
    let textColor = UIColor(hex: "363147")
    let theme_dark = UIColor(hex: "27AEE0")
    let theme_light = UIColor(hex: "F5F5F5")
    
    
}


// MARK: - Application Theme Color Palette
class ColorPalette: NSObject {

    let isDark: Bool
    let name: String
    let statusBarStyle: UIStatusBarStyle
    let navigationbarColor: UIColor
    let navigationbarTextColor: UIColor
    let background: UIColor
    let oppBackground: UIColor
    let primaryTextColor: UIColor
    let secondnaryTextColor: UIColor
    let cellBackgroundA: UIColor
    let cellBackgroundB: UIColor
    let cellDetailTextColor: UIColor
    let cellTextColor: UIColor
    let lightTextColor: UIColor
    let sectionHeaderTextColor: UIColor
    let separatorColor: UIColor
    let borderColor: UIColor
    let mediaCategorySeparatorColor: UIColor
    let tabBarColor: UIColor
    let themeUI: UIColor
    let gradientBlueDark = UIColor(0x1E88E5)
    let gradientBlueLight = UIColor(0x26C6DA)
    let toolBarStyle: UIBarStyle

    init(isDark: Bool,
                name: String,
                statusBarStyle: UIStatusBarStyle,
                navigationbarColor: UIColor,
                navigationbarTextColor: UIColor,
                background: UIColor,
                oppBackground: UIColor,
                primaryTextColor: UIColor,
                secondnaryTextColor: UIColor,
                cellBackgroundA: UIColor,
                cellBackgroundB: UIColor,
                cellDetailTextColor: UIColor,
                cellTextColor: UIColor,
                lightTextColor: UIColor,
                sectionHeaderTextColor: UIColor,
                separatorColor: UIColor,
                borderColor: UIColor,
                mediaCategorySeparatorColor: UIColor,
                tabBarColor: UIColor,
                themeUI: UIColor,
                toolBarStyle: UIBarStyle) {
        self.isDark = isDark
        self.name = name
        self.statusBarStyle = statusBarStyle
        self.navigationbarColor = navigationbarColor
        self.navigationbarTextColor = navigationbarTextColor
        self.background = background
        self.oppBackground = oppBackground
        self.primaryTextColor = primaryTextColor
        self.secondnaryTextColor = secondnaryTextColor
        self.cellBackgroundA = cellBackgroundA
        self.cellBackgroundB = cellBackgroundB
        self.cellDetailTextColor = cellDetailTextColor
        self.cellTextColor = cellTextColor
        self.lightTextColor = lightTextColor
        self.sectionHeaderTextColor = sectionHeaderTextColor
        self.separatorColor = separatorColor
        self.borderColor = borderColor
        self.mediaCategorySeparatorColor = mediaCategorySeparatorColor
        self.tabBarColor = tabBarColor
        self.themeUI = themeUI
        self.toolBarStyle = toolBarStyle
    }
}

// MARK: - Light Theme Color Palette
let lightPalette = ColorPalette(isDark: false,
                                 name: "Default",
                                 statusBarStyle: .autoDarkContent,
                                 navigationbarColor: UIColor(0xFFFFFF),
                                 navigationbarTextColor: UIColor(0x000000),
                                 background: UIColor(0xFFFFFF),
                                 oppBackground: UIColor(0x1C1C1C),
                                 primaryTextColor: UIColor(0x000000),
                                 secondnaryTextColor: UIColor(0x84929C),
                                 cellBackgroundA: UIColor(0xFFFFFF),
                                 cellBackgroundB: UIColor(0xE5E5E3),
                                 cellDetailTextColor: UIColor(0x84929C),
                                 cellTextColor: UIColor(0x000000),
                                 lightTextColor: UIColor(0x888888),
                                 sectionHeaderTextColor: UIColor(0x25292C),
                                 separatorColor: UIColor(0xDADADA),
                                 borderColor: UIColor(0x707070),
                                 mediaCategorySeparatorColor: UIColor(0xECF2F6),
                                 tabBarColor: UIColor(0xFFFFFF),
                                 themeUI: UIColor(0x2BBDDE),
                                 toolBarStyle: UIBarStyle.default)

// MARK: - Dark Theme Color Palette
let darkPalette = ColorPalette(isDark: true,
                               name: "Dark",
                               statusBarStyle: .lightContent,
                               navigationbarColor: UIColor(0x1B1E21),
                               navigationbarTextColor: UIColor(0xFFFFFF),
                               background: UIColor(0x1C1C1C),
                               oppBackground: UIColor(0xFFFFFF),
                               primaryTextColor: UIColor(0xFFFFFF),
                               secondnaryTextColor: UIColor(0x84929C),
                               cellBackgroundA: UIColor(0x1B1E21),
                               cellBackgroundB: UIColor(0x494B4D),
                               cellDetailTextColor: UIColor(0x84929C),
                               cellTextColor: UIColor(0xFFFFFF),
                               lightTextColor: UIColor(0xB8B8B8),
                               sectionHeaderTextColor: UIColor(0x828282),
                               separatorColor: UIColor(0xDADADA),
                               borderColor: UIColor(0x707070),
                               mediaCategorySeparatorColor: UIColor(0x25292C),
                               tabBarColor: UIColor(0x25292C),
                               themeUI: UIColor(0x2BBDDE),
                               toolBarStyle: UIBarStyle.black)


// code by v

extension UIColor {
    class func colorFromHex(hex: Int) -> UIColor { return UIColor(red: (CGFloat((hex & 0xFF0000) >> 16)) / 255.0, green: (CGFloat((hex & 0xFF00) >> 8)) / 255.0, blue: (CGFloat(hex & 0xFF)) / 255.0, alpha: 1.0)
    }
    
//    static var ColorAppGold                 : UIColor { return UIColor(named: "ThemeGoldColor")!}
    static var colorBGSkyBlueLight          : UIColor {return UIColor(hex: "F8FCFF")}
    static var colorTextBlack               : UIColor {return UIColor(hex: "2B2B2B")}
    static var colorTextPlaceHolderGray     : UIColor {return UIColor(hex: "8D8B97")}
    static var colorSkyBlue                 : UIColor {return UIColor(hex: "27AEE0")}
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.black
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
