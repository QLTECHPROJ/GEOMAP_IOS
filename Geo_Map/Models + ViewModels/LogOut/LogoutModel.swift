//
//  LogoutModel.swift
//  Geo_Map
//
//  Created by Mac Mini on 09/05/22.
//

import Foundation
import EVReflection

class LogoutModel : EVObject {
    var ResponseCode = ""
    var ResponseMessage = ""
    var ResponseStatus = ""
    var ResponseData : LogoutDataModel?
}

class LogoutDataModel : EVObject {
    
}
