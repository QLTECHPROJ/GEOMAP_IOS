//
//  CampDaysModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 17/05/22.
//

import Foundation
import EVReflection

enum DayShiftStatus : String {
    case none = ""
    case morning = "0"
    case lunch = "1"
    case checkout = "2"
}

class CampDaysModel: EVObject {
    var ResponseData: CampDaysDataModel?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

class CampDaysDataModel: EVObject {
    var totalDays = ""
    var days = [CampDaysDetailModel]()
}

class CampDaysDetailModel: EVObject {
    var dayId = ""
    var currentDay = ""
    var dayshift = ""
}
