//
//  AppVersionModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 28/04/22.
//

import Foundation
import EVReflection

class AppVersionModel: EVObject {
    var ResponseData: AppVersionDetailModel?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

class AppVersionDetailModel: EVObject {
    var IsForce = ""
    var supportTitle = ""
    var supportText = ""
    var supportEmail = ""
    var countryID = ""
    var countryCode = ""
    var countryShortName = ""
    var mobileMinDigits = "10" // default value
    var mobileMaxDigits = "10" // default value
    var postCodeMinDigits = "6" // default value
    var postCodeMaxDigits = "6" // default value
    
    var currencySign = ""
}
