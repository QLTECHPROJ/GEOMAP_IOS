//
//  ReferDataModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 27/05/22.
//

import Foundation
import EVReflection

class ReferDataModel: EVObject {
    var ResponseData: ReferDetailModel?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

class ReferDetailModel: EVObject {
    var ReferCode = ""
    var ReferLink = ""
    var Title = ""
    var Subtitle = ""
}
