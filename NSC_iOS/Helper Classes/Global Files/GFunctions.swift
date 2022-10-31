//
//  GFunctions.swift
//  NSC_iOS
//
//  Created by vishal parmar on 28/10/22.
//

import Foundation
import AVKit

class GFunctions: NSObject {
    
    static let shared   : GFunctions        = GFunctions()
    
    let snackbar: TTGSnackbar = TTGSnackbar()
    
    func showSnackBar(textAlignment : NSTextAlignment = .left,message : String, backGroundColor : UIColor = UIColor.colorSkyBlue, duration : TTGSnackbarDuration = .middle , animation : TTGSnackbarAnimationType = .slideFromTopBackToTop, textColor : UIColor = UIColor.white) {
        //        let snackbar: TTGSnackbar = TTGSnackbar.init(message: message, duration: duration)
        snackbar.message = message
        snackbar.duration = duration
        // Change the content padding inset
        snackbar.contentInset = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
        
        // Change margin
        snackbar.leftMargin = 0
        snackbar.rightMargin = 0
        snackbar.topMargin = 0
        
        // Change message text font and color
        snackbar.messageTextColor = textColor
        snackbar.messageTextAlign = textAlignment
        snackbar.messageTextFont = UIFont.applyCustomFont(fontName: .InterMedium, fontSize: 12.0)
        
        // Change snackbar background color
        snackbar.backgroundColor = backGroundColor
        
        snackbar.onTapBlock = { snackbar in
            snackbar.dismiss()
        }
        
        snackbar.onSwipeBlock = { (snackbar, direction) in
            
            // Change the animation type to simulate being dismissed in that direction
            if direction == .right {
                snackbar.animationType = .slideFromLeftToRight
            } else if direction == .left {
                snackbar.animationType = .slideFromRightToLeft
            } else if direction == .up {
                snackbar.animationType = .slideFromTopBackToTop
            } else if direction == .down {
                snackbar.animationType = .slideFromTopBackToTop
            }
            
            snackbar.dismiss()
        }
        
//        snackbar.cornerRadius = 10.0
        // Change animation duration
        snackbar.animationDuration = 0.5
        
        // Animation type
        snackbar.animationType = animation
        snackbar.show()
    }
}

extension GFunctions{
    
    func saveDeviceTokenIntoUserDefault (object : AnyObject, key : String) {
        USERDEFAULTS.set(object, forKey:key)
        USERDEFAULTS.synchronize()
    }
    
    func getDeviceToken () -> String {
        
        if (UserDefaults.standard.value(forKey: UserDefaultsKeys.kDeviceToken.rawValue) != nil) {
            let deviceToken : String? = UserDefaults.standard.value(forKey: UserDefaultsKeys.kDeviceToken.rawValue) as? String
            guard let
                letValue = deviceToken, !letValue.isEmpty else {
                    print(":::::::::-Value Not Found-:::::::::::")
                    return "0"
            }
            return deviceToken!
        }
        return "0"
    }
}
