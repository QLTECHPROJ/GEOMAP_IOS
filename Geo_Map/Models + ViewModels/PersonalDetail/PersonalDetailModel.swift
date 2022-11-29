//
//  PersonalDetailModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 10/05/22.
//

import Foundation
import EVReflection

class PersonalDetailModel: EVObject {
    var ResponseData: [PersonalDetailDataModel]?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

class PersonalDetailDataModel: EVObject {
    
}
