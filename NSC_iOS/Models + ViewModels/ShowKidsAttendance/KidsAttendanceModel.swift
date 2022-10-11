//
//  KidsAttendanceModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 19/05/22.
//

import Foundation
import EVReflection

enum AttendanceStatus : String {
    case none = "0" // To Be Checked In
    case present = "1" // "Check In"
    case absent = "2" // "Check Out"
}

enum CheckInStatus : String {
    case toBeCheckedIn = "0" // To Be Checked In
    case checkIn = "1" // "Check In"
    case checkOut = "2" // "Check Out"
}

class KidsAttendanceModel: EVObject {
    var ResponseData: KidsAttendanceDataModel?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

class KidsAttendanceDataModel: EVObject {
    var dayId = ""
    var dayshift = ""
    var kidsattendance = [KidsAttendanceDetailModel]()
}

class KidsAttendanceDetailModel: EVObject {
    var ID = ""
    var Name = ""
    var Group_Name = ""
    var Morning_Attendance = ""
    var Lunch_Attendance = ""
    var CheckIn = ""
    var isFirstTimer = ""
}
