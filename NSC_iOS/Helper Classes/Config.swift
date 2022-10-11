//
//  Config.swift
//  NSC_iOS
//
//  Created by Dhruvit on 12/08/20.
//  Copyright © 2020 Dhruvit. All rights reserved.
//

import Foundation
import UIKit

// Application Constants
let APP_VERSION = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "1"
let APP_TYPE = "0" // 0 = IOS , 1 = Android
let APP_NAME = "NSC Coach"
let DEVICE_UUID = UIDevice.current.identifierForVendor!.uuidString

let APP_APPSTORE_URL = ""
let TERMS_AND_CONDITION_URL = "https://shop.nationalsportscamps.in/terms-conditions/"
let PRIVACY_POLICY_URL = "https://shop.nationalsportscamps.in/nsc-privacy-policy/"
let HOW_REFER_WORKS_URL = ""

// In App Purchase
let MANAGE_SUBSCRIPTIONS_URL = "https://apps.apple.com/account/subscriptions"

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
let SCREEN_SIZE = UIScreen.main.bounds.size

// Screen Height / Width
let SCREEN_MAX_LENGTH = max(SCREEN_SIZE.width, SCREEN_SIZE.height)
let SCREEN_MIN_LENGTH = min(SCREEN_SIZE.width, SCREEN_SIZE.height)

// Check iPhone or iPad
let IS_IPAD = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
let IS_RETINA = UIScreen.main.scale >= 2.0

// Check iPhone Model
let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH < 568.0
let IS_IPHONE_5 = IS_IPHONE && SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_8 = IS_IPHONE && SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_8_Plus = IS_IPHONE && SCREEN_MAX_LENGTH == 736.0
let IS_IPHONE_11_Pro = IS_IPHONE && SCREEN_MAX_LENGTH == 812.0
let IS_IPHONE_11_Pro_MAX = IS_IPHONE && SCREEN_MAX_LENGTH == 896.0

// iPhone Model Height
let IPHONE_4_OR_LESS = 480.0
let IPHONE_5 = 568.0
let IPHONE_8 = 667.0
let IPHONE_8_Plus = 736.0
let IS_IPHONE_13_Mini = IS_IPHONE && SCREEN_MAX_LENGTH == 812.0
let IS_IPHONE_13_Pro = IS_IPHONE && SCREEN_MAX_LENGTH == 844.0
let IS_IPHONE_13_Pro_MAX = IS_IPHONE && SCREEN_MAX_LENGTH == 926.0

var hasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}

// Logged In User
var LOGIN_TOKEN = ""
var DEVICE_TOKEN = "1234567890"
var FCM_TOKEN = "1234567890"

// Complition blocks
typealias AlertComplitionBlock = (Int) -> ()
typealias ActionSheetComplitionBlock = (String) -> ()
typealias APIComplitionBlock = (Bool,Any) -> ()
typealias StatusComplitionBlock = (Bool) -> ()

// ThirdParty API IDs
enum ClientIds : String {
    case key = ""
}

// URLSchemes Redirects
enum URLSchemes : String {
    case google = ""
}

//var apiFlag : String {
//    #if DEBUG
//    if (LoginDataModel.currentUser?.UserID ?? "") == "297" {
//        return "1"
//    }
//    return "0"
//    #else
//    return "1"
//    #endif
//}

// For Pagination
let perPage = 20

// Zoho Chat Keys
var strAppKey = ""
var strAccessKey = ""

// MARK: - App StoryBoards

enum AppStoryBoard : String {
    case main = "Main"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func intialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
    
    func viewController<T : UIViewController>(viewControllerClass: T.Type) -> T {
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyBoardID
        return instance.instantiateViewController(withIdentifier: storyBoardID) as! T
    }
    
}
