//
//  NotificationListModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 19/07/22.
//

import Foundation
import EVReflection

class NotificationListModel: EVObject {
    var ResponseData: [NotificationListDataModel]?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

class NotificationListDataModel: EVObject {
    var ID = ""
    var Title = ""
    var Desc = ""
    var FlagID = ""
    var Flag = ""
    var Date = ""
}

