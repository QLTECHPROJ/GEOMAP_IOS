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
    var version : String!
   
    var userName : String!
    var password : String!
    var iD : String!
    var name : String!
    var profileimage : String!
    var email : String!
    var dob : String!
    var mobile : String!
    var userId : String!
    var subject : String!
    var message : String!
    
    var shift :String!
    var mappedBy : String!
    var scale : String!
    var location : String!
    var venieLoad : String!
    var xCordinate : String!
    var yCordinate : String!
    var zCordinate : String!
    var comment : String!
    var mapSerialNo : String!
    var ugDate : String!
    var leftImage : String!
    var roofImage : String!
    var rightImage : String!
    var faceImage : String!
    var attributeUnderGroundMapping : [AttributeUndergroundMappingModel]!
    

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
        version = json["version"].stringValue
        
        userName = json["userName"].stringValue
        password = json["password"].stringValue
        iD = json["id"].stringValue
        name = json["name"].stringValue
        profileimage = json["profileimage"].stringValue
        email = json["email"].stringValue
        dob = json["dob"].stringValue
        mobile = json["mobile"].stringValue
        userId = json["userId"].stringValue
        subject = json["subject"].stringValue
        message = json["message"].stringValue
        
        shift = json["message"].stringValue
        mappedBy = json["message"].stringValue
        scale = json[scale].stringValue
        location = json["location"].stringValue
        venieLoad = json["venieLoad"].stringValue
        xCordinate = json["xCordinate"].stringValue
        yCordinate = json["yCordinate"].stringValue
        zCordinate = json["zCordinate"].stringValue
        comment = json["comment"].stringValue
        mapSerialNo = json["mapSerialNo"].stringValue
        ugDate = json["ugDate"].stringValue
        leftImage = json["leftImage"].stringValue
        roofImage = json["roofImage"].stringValue
        rightImage = json["rightImage"].stringValue
        faceImage = json["faceImage"].stringValue
        
        attributeUnderGroundMapping = [AttributeUndergroundMappingModel]()
        let attributesArray = json["attribute"].arrayValue
        for content in attributesArray{
            let value = AttributeUndergroundMappingModel(fromJson: content)
            attributeUnderGroundMapping.append(value)
        }
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
        if version != nil{
            dictionary["version"] = version
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
        if message != nil{
            dictionary["message"] = message
        }
        if subject != nil{
            dictionary["subject"] = subject
        }
        
        if attributeUnderGroundMapping != nil{
            var dictionaryElements = [[String:Any]]()
            for contentDict in attributeUnderGroundMapping {
                dictionaryElements.append(contentDict.toDictionary())
            }
            dictionary["attribute"] = dictionaryElements
        }
        return dictionary
    }
}


class AttributeUndergroundMappingModel : NSObject, NSCoding{
    
    var undergroundId : String!
    var name : String!
    var nose : String!
    var properties : String!
    

    override init() {
        
    }
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        undergroundId = json["undergroundId"].stringValue
        name = json["name"].stringValue
        nose = json["nose"].stringValue
        properties = json["properties"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if undergroundId != nil{
            dictionary["undergroundId"] = undergroundId
        }
        if name != nil{
            dictionary["name"] = name
        }
        if nose != nil{
            dictionary["nose"] = nose
        }
        if properties != nil{
            dictionary["properties"] = properties
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        undergroundId = aDecoder.decodeObject(forKey: "undergroundId") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        nose = aDecoder.decodeObject(forKey: "nose") as? String
        properties = aDecoder.decodeObject(forKey: "properties") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if undergroundId != nil{
            aCoder.encode(undergroundId, forKey: "undergroundId")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if nose != nil{
            aCoder.encode(nose, forKey: "nose")
        }
        if properties != nil{
            aCoder.encode(properties, forKey: "properties")
        }
    }
}
