//
//  UserModel.swift
//
//
//  Created by  on 04/11/22.
//

import Foundation

class UserModelClass : NSObject, NSCoding{

    var attributeData : [AttributeData]!
    var deviceId : String!
    var deviceToken : String!
    var deviceType : String!
    var userId : String!
    var dob : String!
    var email : String!
    var mobile : String!
    var name : String!
    var profileImage : String!
    var rockStrength : [RockStrength]!
    var sampleCollected : [RockStrength]!
    var typeOfFaults : [RockStrength]!
    var typeOfGeologicalStructures : [RockStrength]!
    var waterCondition : [RockStrength]!
    var weatheringData : [RockStrength]!


    
    static var current : UserModelClass = UserModelClass()
    
    
    override init() {
        
    }
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        attributeData = [AttributeData]()
        let attributeDataArray = json["attributeData"].arrayValue
        for attributeDataJson in attributeDataArray{
            let value = AttributeData(fromJson: attributeDataJson)
            attributeData.append(value)
        }
        deviceId = json["deviceId"].stringValue
        deviceToken = json["deviceToken"].stringValue
        deviceType = json["deviceType"].stringValue
        userId = json["userId"].stringValue
        dob = json["dob"].stringValue
        email = json["email"].stringValue
        mobile = json["mobile"].stringValue
        name = json["name"].stringValue
        profileImage = json["profileImage"].stringValue
        rockStrength = [RockStrength]()
        let rockStrengthArray = json["rockStrength"].arrayValue
        for rockStrengthJson in rockStrengthArray{
            let value = RockStrength(fromJson: rockStrengthJson)
            rockStrength.append(value)
        }
        sampleCollected = [RockStrength]()
        let sampleCollectedArray = json["sampleCollected"].arrayValue
        for sampleCollectedJson in sampleCollectedArray{
            let value = RockStrength(fromJson: sampleCollectedJson)
            sampleCollected.append(value)
        }
        typeOfFaults = [RockStrength]()
        let typeOfFaultsArray = json["typeOfFaults"].arrayValue
        for typeOfFaultsJson in typeOfFaultsArray{
            let value = RockStrength(fromJson: typeOfFaultsJson)
            typeOfFaults.append(value)
        }
        typeOfGeologicalStructures = [RockStrength]()
        let typeOfGeologicalStructuresArray = json["typeOfGeologicalStructures"].arrayValue
        for typeOfGeologicalStructuresJson in typeOfGeologicalStructuresArray{
            let value = RockStrength(fromJson: typeOfGeologicalStructuresJson)
            typeOfGeologicalStructures.append(value)
        }
        waterCondition = [RockStrength]()
        let waterConditionArray = json["waterCondition"].arrayValue
        for waterConditionJson in waterConditionArray{
            let value = RockStrength(fromJson: waterConditionJson)
            waterCondition.append(value)
        }
        weatheringData = [RockStrength]()
        let weatheringDataArray = json["weatheringData"].arrayValue
        for weatheringDataJson in weatheringDataArray{
            let value = RockStrength(fromJson: weatheringDataJson)
            weatheringData.append(value)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if attributeData != nil{
            var dictionaryElements = [[String:Any]]()
            for attributeDataElement in attributeData {
                dictionaryElements.append(attributeDataElement.toDictionary())
            }
            dictionary["attributeData"] = dictionaryElements
        }
        if deviceId != nil{
            dictionary["deviceId"] = deviceId
        }
        if deviceToken != nil{
            dictionary["deviceToken"] = deviceToken
        }
        if deviceType != nil{
            dictionary["deviceType"] = deviceType
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        if dob != nil{
            dictionary["dob"] = dob
        }
        if email != nil{
            dictionary["email"] = email
        }
        if mobile != nil{
            dictionary["mobile"] = mobile
        }
        if name != nil{
            dictionary["name"] = name
        }
        if profileImage != nil{
            dictionary["profileImage"] = profileImage
        }
        if rockStrength != nil{
            var dictionaryElements = [[String:Any]]()
            for rockStrengthElement in rockStrength {
                dictionaryElements.append(rockStrengthElement.toDictionary())
            }
            dictionary["rockStrength"] = dictionaryElements
        }
        if sampleCollected != nil{
            var dictionaryElements = [[String:Any]]()
            for sampleCollectedElement in sampleCollected {
                dictionaryElements.append(sampleCollectedElement.toDictionary())
            }
            dictionary["sampleCollected"] = dictionaryElements
        }
        if typeOfFaults != nil{
            var dictionaryElements = [[String:Any]]()
            for typeOfFaultsElement in typeOfFaults {
                dictionaryElements.append(typeOfFaultsElement.toDictionary())
            }
            dictionary["typeOfFaults"] = dictionaryElements
        }
        if typeOfGeologicalStructures != nil{
            var dictionaryElements = [[String:Any]]()
            for typeOfGeologicalStructuresElement in typeOfGeologicalStructures {
                dictionaryElements.append(typeOfGeologicalStructuresElement.toDictionary())
            }
            dictionary["typeOfGeologicalStructures"] = dictionaryElements
        }
        if waterCondition != nil{
            var dictionaryElements = [[String:Any]]()
            for waterConditionElement in waterCondition {
                dictionaryElements.append(waterConditionElement.toDictionary())
            }
            dictionary["waterCondition"] = dictionaryElements
        }
        if weatheringData != nil{
            var dictionaryElements = [[String:Any]]()
            for weatheringDataElement in weatheringData {
                dictionaryElements.append(weatheringDataElement.toDictionary())
            }
            dictionary["weatheringData"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        attributeData = aDecoder.decodeObject(forKey: "attributeData") as? [AttributeData]
        deviceId = aDecoder.decodeObject(forKey: "deviceId") as? String
        deviceToken = aDecoder.decodeObject(forKey: "deviceToken") as? String
        deviceType = aDecoder.decodeObject(forKey: "deviceType") as? String
        userId = aDecoder.decodeObject(forKey: "userId") as? String
        dob = aDecoder.decodeObject(forKey: "dob") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        profileImage = aDecoder.decodeObject(forKey: "profileImage") as? String
        rockStrength = aDecoder.decodeObject(forKey: "rockStrength") as? [RockStrength]
        sampleCollected = aDecoder.decodeObject(forKey: "sampleCollected") as? [RockStrength]
        typeOfFaults = aDecoder.decodeObject(forKey: "typeOfFaults") as? [RockStrength]
        typeOfGeologicalStructures = aDecoder.decodeObject(forKey: "typeOfGeologicalStructures") as? [RockStrength]
        waterCondition = aDecoder.decodeObject(forKey: "waterCondition") as? [RockStrength]
        weatheringData = aDecoder.decodeObject(forKey: "weatheringData") as? [RockStrength]
        
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if attributeData != nil{
            aCoder.encode(attributeData, forKey: "attributeData")
        }
        if deviceId != nil{
            aCoder.encode(deviceId, forKey: "deviceId")
        }
        if deviceToken != nil{
            aCoder.encode(deviceToken, forKey: "deviceToken")
        }
        if deviceType != nil{
            aCoder.encode(deviceType, forKey: "deviceType")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        if dob != nil{
            aCoder.encode(dob, forKey: "dob")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if mobile != nil{
            aCoder.encode(mobile, forKey: "mobile")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if profileImage != nil{
            aCoder.encode(profileImage, forKey: "profileImage")
        }
        if rockStrength != nil{
            aCoder.encode(rockStrength, forKey: "rockStrength")
        }
        if sampleCollected != nil{
            aCoder.encode(sampleCollected, forKey: "sampleCollected")
        }
        if typeOfFaults != nil{
            aCoder.encode(typeOfFaults, forKey: "typeOfFaults")
        }
        if typeOfGeologicalStructures != nil{
            aCoder.encode(typeOfGeologicalStructures, forKey: "typeOfGeologicalStructures")
        }
        if waterCondition != nil{
            aCoder.encode(waterCondition, forKey: "waterCondition")
        }
        if weatheringData != nil{
            aCoder.encode(weatheringData, forKey: "weatheringData")
        }

    }

}

extension UserModelClass{
    func saveUserSessionInToDefaults() {
        //        USERDEFAULTS.set(self.token, forKey: UserDefaultsKeys.kUserSession.rawValue)
        //        USERDEFAULTS.synchronize()
    }
    
    func saveUserDetailInDefaults()  {
        
        let encodeData = NSKeyedArchiver.archivedData(withRootObject: self)
        USERDEFAULTS.set(encodeData, forKey: UserDefaultsKeys.kLoginUserData.rawValue)
        USERDEFAULTS.synchronize()
        
        UserModelClass.current.getUserDetailFromDefaults()
        
        /*If there would be any change in user defaults it would fire notification*/
    }
    
    func getUserDetailFromDefaults() {
        
        guard let decodeData = USERDEFAULTS.value(forKey: UserDefaultsKeys.kLoginUserData.rawValue) else {
            return
        }
        
        UserModelClass.current = NSKeyedUnarchiver.unarchiveObject(with: decodeData as! Data) as! UserModelClass
    }
      
}


class No : NSObject, NSCoding{

    var attributeId : Int!
    var createdAt : String!
    var id : Int!
    var name : String!
    var updatedAt : String!


    override init() {
        
    }
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        attributeId = json["attributeId"].intValue
        createdAt = json["created_at"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        updatedAt = json["updated_at"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if attributeId != nil{
            dictionary["attributeId"] = attributeId
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         attributeId = aDecoder.decodeObject(forKey: "attributeId") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if attributeId != nil{
            aCoder.encode(attributeId, forKey: "attributeId")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}


class RockStrength : NSObject, NSCoding{

    var createdAt : String!
    var id : Int!
    var name : String!
    var updatedAt : String!


    override init() {
        
    }
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        createdAt = json["created_at"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        updatedAt = json["updated_at"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}


class AttributeData : NSObject, NSCoding{

    var createdAt : String!
    var id : Int!
    var name : String!
    var nos : [No]!
    var updatedAt : String!

    override init() {
        
    }

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        createdAt = json["created_at"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        nos = [No]()
        let nosArray = json["nos"].arrayValue
        for nosJson in nosArray{
            let value = No(fromJson: nosJson)
            nos.append(value)
        }
        updatedAt = json["updated_at"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if nos != nil{
            var dictionaryElements = [[String:Any]]()
            for nosElement in nos {
                dictionaryElements.append(nosElement.toDictionary())
            }
            dictionary["nos"] = dictionaryElements
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         nos = aDecoder.decodeObject(forKey: "nos") as? [No]
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if nos != nil{
            aCoder.encode(nos, forKey: "nos")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
