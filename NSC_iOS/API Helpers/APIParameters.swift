//
//  APIParameters.swift
//  NSC_iOS
//
//  Created by vishal parmar on 31/10/22.
//

import Foundation
import UIKit


class APIParametersModel : NSObject {
    
    var deviceToken : String!
    var deviceId : String!
    var deviceType : String!
   
    var userName : String!
    var password : String!
    var iD : String!
    var name : String!
    var profileimage : String!
    var email : String!
    var dob : String!
    var mobile : String!
    var userId : String!
    
    override init() {
        
    }
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        
        if json.isEmpty{
            return
        }
        deviceType = json["deviceType"].stringValue
        deviceId = json["deviceId"].stringValue
        deviceToken = json["deviceToken"].stringValue
        
        userName = json["userName"].stringValue
        password = json["password"].stringValue
        iD = json["id"].stringValue
        name = json["name"].stringValue
        profileimage = json["profileimage"].stringValue
        email = json["email"].stringValue
        dob = json["dob"].stringValue
        mobile = json["mobile"].stringValue
        userId = json["userId"].stringValue
        
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        if deviceType != nil{
            dictionary["deviceType"] = deviceType
        }
        if deviceId != nil{
            dictionary["deviceId"] = deviceId
        }
        if deviceToken != nil{
            dictionary["deviceToken"] = deviceToken
        }
        
        if userName != nil{
            dictionary["userName"] = userName
        }
        if password != nil{
            dictionary["password"] = password
        }
        if iD != nil{
            dictionary["id"] = iD
        }
        if name != nil{
            dictionary["name"] = name
        }
        if profileimage != nil{
            dictionary["profileimage"] = profileimage
        }
        if email != nil{
            dictionary["email"] = email
        }
        if dob != nil{
            dictionary["dob"] = dob
        }
        if mobile != nil{
            dictionary["mobile"] = mobile
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        
        return dictionary
    }
}

