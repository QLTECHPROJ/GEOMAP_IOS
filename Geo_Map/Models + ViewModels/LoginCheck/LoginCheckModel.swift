//
//  LoginCheckModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 04/05/22.
//

import Foundation
import EVReflection

class LoginCheckModel: EVObject {
    var ResponseData: LoginCheckDataModel?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

class LoginCheckDataModel: EVObject {
    var loginFlag: String?
}
