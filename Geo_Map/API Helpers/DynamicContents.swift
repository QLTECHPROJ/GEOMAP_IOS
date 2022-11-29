//
//  DynamicContents.swift
//  Geo_Map
//
//  Created by Dhruvit on 03/05/22.
//

import Foundation
import UIKit

// MARK: - Dynamic Contents

enum CoachStatus : String {
    case Pending
    case Approved
    case Rejected
    case Hired
}

extension LoginDataModel {
    
    static var profileImage : UIImage?
    
    class var currentUser : LoginDataModel? {
        get {
            if let userData = UserDefaults.standard.data(forKey: "LoginData") {
                return LoginDataModel(data: userData)
            }
            return nil
        }
        set {
            LoginDataModel.profileImage = nil
            if let newData = newValue {
                UserDefaults.standard.setValue(newData.toJsonData(), forKey: "LoginData")
            }
            else {
                UserDefaults.standard.setValue(nil, forKey: "LoginData")
            }
            UserDefaults.standard.synchronize()
        }
    }
    
}


class AppVersionDetails {
    
    static var IsForce = AppVersionDetails.current.IsForce
    static var countryID = AppVersionDetails.current.countryID
    static var countryCode = AppVersionDetails.current.countryCode
    static var countryShortName = AppVersionDetails.current.countryShortName
    static var supportTitle = AppVersionDetails.current.supportTitle
    static var supportText = AppVersionDetails.current.supportText
    static var supportEmail = AppVersionDetails.current.supportEmail
    
    static var mobileMinDigits = Int(AppVersionDetails.current.mobileMinDigits) ?? 10
    static var mobileMaxDigits = Int(AppVersionDetails.current.mobileMaxDigits) ?? 10
    static var postCodeMinDigits = Int(AppVersionDetails.current.postCodeMinDigits) ?? 6
    static var postCodeMaxDigits = Int(AppVersionDetails.current.postCodeMaxDigits) ?? 6
    
    static var currencySign = AppVersionDetails.current.currencySign
    
    class func defaultDetails() -> AppVersionDetailModel {
        let details = AppVersionDetailModel()
        details.IsForce = ""
        details.countryID = "101"
        details.countryCode = "91"
        details.countryShortName = "IN"
        details.supportTitle = "Support"
        details.supportText = "Please contact support at "
        details.supportEmail = "support@nsc.com.in"
        details.mobileMinDigits = "10"
        details.mobileMaxDigits = "10"
        details.postCodeMinDigits = "6"
        details.postCodeMaxDigits = "6"
        
        details.currencySign = "₹"
        
        return details
    }
    
    class var current : AppVersionDetailModel {
        get {
            if let userData = UserDefaults.standard.data(forKey: "AppVerionDetail") {
                return AppVersionDetailModel(data: userData)
            }
            return self.defaultDetails()
        }
        set {
            UserDefaults.standard.setValue(newValue.toJsonData(), forKey: "AppVerionDetail")
            UserDefaults.standard.synchronize()
        }
    }
    
}


var authVerificationID : String {
    get {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        return verificationID
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "authVerificationID")
    }
}
