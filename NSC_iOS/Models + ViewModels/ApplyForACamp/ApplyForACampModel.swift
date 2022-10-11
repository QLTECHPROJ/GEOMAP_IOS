//
//  ApplyForACampModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 18/05/22.
//

import Foundation
import EVReflection

class ApplyForACampModel : EVObject {
    var ResponseData: ApplyForACampDataModel?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

class ApplyForACampDataModel : EVObject {
    var maxCount: String?
    var campList: [ApplyCampModel]?
}

class ApplyCampModel: EVObject {
    var ID = ""
    var Name = ""
    var CampDates = ""
    var Address = ""
    var Venue = ""
    var Selected = ""
}

