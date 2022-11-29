//
//  LoginModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 04/05/22.
//

import Foundation
import EVReflection

class LoginModel: EVObject {
    var ResponseData: LoginDataModel?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

/*
class LoginDataModel: EVObject {
    var ID = ""
    var ZOHOID = ""
    var Name = ""
    var Fname = ""
    var Mname = ""
    var Lname = ""
    var DOB = ""
    var Email = ""
    var CountryCode = ""
    var CountryName = ""
    var Mobile = ""
    var Country = ""
    var State = ""
    var StateName = ""
    var City = ""
    var CityName = ""
    var Address = ""
    var PostCode = ""
    var RoleId = ""
    var Role = ""
    var Vaccinated = ""
    var Bank_Name = ""
    var Account_Name = ""
    var IFSC_Code = ""
    var Account_Number = ""
    var Status = ""
    var BankDetailFilled = ""
    var PersonalDetailFilled = ""
    var Profile_Image = ""
    var SportId = ""
    var SportName = ""
    var Refer_Code = ""
    var referLink = ""
}
*/

class LoginDataModel : EVObject{

    var deviceId = ""
    var deviceToken = ""
    var deviceType = ""
    var profileInformation : ProfileInformation?
    var token = ""
}

class ProfileInformation : EVObject{

    var createdAt = ""
    var dob = ""
    var email = ""
    var emailVerifiedAt = ""
    var id = ""
    var mobile = ""
    var name = ""
    var profileimage = ""
    var updatedAt = ""

}

