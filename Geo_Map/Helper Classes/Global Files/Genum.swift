//
//  Genum.swift
//  NSC_iOS
//
//  Created by vishal parmar on 19/10/22.
//

import Foundation


//-------------------------------------------------------------------
//MARK: - UserDefault's Store Keys
//-------------------------------------------------------------------
enum UserDefaultsKeys : String {
    
    case kDeviceToken                                = "kDeviceToken"
    case isUserLogin                                 = "isUserLogin"
    case kUserSession                                = "kUserSession"
    case kLoginUserData                              = "kLoginUserData"
}

enum openWindorTag : Int {
    
    case login = 0
    case home = 1
}


enum Validations {
    
    enum NameLength : Int{
        case Maximum = 32
        case Minimum = 4
    }
    
    enum UserNameLenght : Int{
        case Maximum = 32
        case MAXIMUM_PIN = 3
    }
    
    enum PhoneNo : Int {
        case Minimum = 8
        case Maximum = 11
    }
    
    enum Password : Int {
        case Minimum = 8
        case Maximum = 16
    }
    
    enum NameLenght : Int {
        case Minimum = 3
        case Maximum = 32
    }
    
    enum AccountNo : Int {
        case Minimum = 13
        case Maximum = 16
    }
    
    enum PhoneNumber : Int {
        case Minimum = 4//7
        case Maximum = 15//12
    }
    
    enum RegexType : String {
        case AlpabetsAndSpace                       = "^[A-Za-z ]*$"
        case OnlyNumber                             = "^[0-9]*$"
        case AlpabetsAndNoSpace                     = "^[A-Za-z]*$"
        case Username                               = "^[0-9A-Za-z._]*$"
//        case Name                                   = "^[a-zA-Z ]{3,32}*$"
    }
}

//-------------------------------------------------------------------
//MARK: - Date-Time Formats
//-------------------------------------------------------------------
enum DateTimeFormaterEnum : String
{
    case yyyymmdd           = "yyyy-MM-dd"
    
    case DDMMyyyy           = "dd-MM-yyyy"
    
    case MMM_d_Y            = "MMMM d, yyyy"
    
    case MMM_dd_YYYY            = "MMM dd, yyyy"
    
    case HHmmss             = "HH:mm:ss"
    
    case hhmma              = "hh:mma"
    
    case MM              = "MM"
    
    case E_MMM_dd  = "E, MMM dd yyyy"
    
    case E_dd_MMM_dd_yyyy  = "E, dd-MMM-yyyy"
    
    case yyyy              = "yyyy"
    
    case HHmm               = "HH:mm"
    
    case dmmyyyy            = "d/MM/yyyy"
    
    case hhmmA              = "hh:mm a"
    
    case UTCFormat          = "yyyy-MM-dd HH:mm:ss"
    
    case ddmm_yyyy          = "dd MMM, yyyy"
    
    case MMdotDDdotYY       = "MM.dd.yy"
    
    case WeekDayhhmma       = "EEE,hh:mma"
    
    case ddMMyyyy           = "dd/MM/yyyy"
    
    case MMyy               = "MM/yy"
    
    case ddMMMyyyy          = "dd-MMM-yyyy"
    
    case ddMMMYYYYhhmma     = "dd MMM, yyyy hh:mm a"
    
    case yyyyMMddTHHMMSSZ = "yyyy-MM-dd'T'HH:mm:ss.000'Z'"
    
    case yyyymmddhhmmssA = "yyyy-MM-dd hh:mm:ss a"
    
    case yyyymmddhhmmss = "yyyy-MM-dd hh:mm:ss"
    
    case ddMMMyyyy_hhmma = "dd MMM, yyyy - hh:mm a"
    
//    13 Jan, 2023 05:01:33 PM
    
    case postDisplayDateTimeFormat = "MM/dd/yy hh:mma" //10/20/20 2:48pm
    
    case joinedDateFormat = "dd.MM.yy" //10/20/20 2:48pm
    
    case birthdateCompareFormat = "ddMM"
    
    case EEEE = "EEEE"
    
    case ddMMyyHHmmAWithDOT = "dd.MM.yy hh:mma"
    
}

enum ScreenHeightResolution : CGFloat {

    // Height
    case height568    = 568
    case height667    = 667   // 6, 6s, 7,8
    case height736    = 736   // iPhone plus
    case height812    = 812   // Xr, Xs Max
    case height896    = 896   // Xr, Xs Max
    case height1024   = 1024   // 9.7-inch
    case height1112   = 1112   // 10.5-inch iPad Pro
    case height1194   = 1194   // 11.0-inch iPad Pro
    case height1366   = 1366   // 12.9 inch iPad
}


extension Notification.Name {
    
    static let reloadUGOCReportList = Notification.Name("reloadUGOCReportList")
    static let updateUGOfflineReport = Notification.Name("updateUGOfflineReport")
    static let updateOCOfflineReport = Notification.Name("updateOCOfflineReport")

}
