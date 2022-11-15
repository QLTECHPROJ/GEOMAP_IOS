//
//  GConstant.swift
//  NSC_iOS
//
//  Created by vishal parmar on 19/10/22.
//

import Foundation
import UIKit



//MARK: - Screen (Width - Height)
let kScreenWidth                                =  UIScreen.main.bounds.size.width
let kScreenHeight                               =  UIScreen.main.bounds.size.height

var kFontAspectRatio : CGFloat {
    if UIDevice().userInterfaceIdiom == .pad {
        return kScreenHeight / 568
    }
    return kScreenWidth / 320
}

let kNormalFontSize                             : CGFloat = 14.0
let kMediumFontSize                             : CGFloat = 13.0
let kNormalButtonFontSize                       : CGFloat = 11.0


let USERDEFAULTS                       = UserDefaults.standard

let AUTHENTICATION                              = UIStoryboard(name: "Main", bundle: nil)


