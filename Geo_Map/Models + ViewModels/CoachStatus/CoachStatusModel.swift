//
//  CoachStatusModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 05/05/22.
//

import Foundation
import EVReflection

class CoachStatusModel: EVObject {
    var ResponseData: CoachStatusDataModel?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

class CoachStatusDataModel: EVObject {
    var Title = ""
    var SubTitle = ""
    var Status = ""
}
