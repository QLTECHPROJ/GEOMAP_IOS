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
    var mapSerialNo : String!
    var ugDate : String!
    var leftImage : String!
    var roofImage : String!
    var rightImage : String!
    var faceImage : String!
    var attribute : [Attribute]!
    
    var underGroundReport : [UndergroundReport]!
    var openCastReport : [OpenCastReport]!
    
    var minesSiteName : String!
    var mappingSheetNo : String!
    var pitName : String!
    var pitLoaction : String!
    
    var shiftInchargeName : String!
    var geologistName : String!
    var faceLocation : String!
    var faceLength : String!
    var faceArea : String!
    var faceRockType : String!
    var benchRl : String!
    var benchHeightWidth : String!
    var benchAngle : String!
    var thicknessOfOre : String!
    var thicknessOfOverburdan : String!
    var thicknessOfInterburden : String!
    var observedGradeOfOre : String!
    var sampleColledted : String!
    var actualGradeOfOre : String!
    var weathring : String!
    var rockStregth : String!
    var waterCondition : String!
    var typeOfGeologist : String!
    var typeOfFaults : String!
    var ocDate : String!
    var dipDirectionAndAngle : String!
    var notes : String!
    var imageDraaw : String!
    var clientsGeologistSign : String!
    var geologistSign : String!
    var comment : String!
    var reportType : String!

    
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
        
        shift = json["shift"].stringValue
        mappedBy = json["mappedBy"].stringValue
        scale = json["scale"].stringValue
        location = json["location"].stringValue
        venieLoad = json["venieLoad"].stringValue
        xCordinate = json["xCordinate"].stringValue
        yCordinate = json["yCordinate"].stringValue
        zCordinate = json["zCordinate"].stringValue
        mapSerialNo = json["mapSerialNo"].stringValue
        ugDate = json["ugDate"].stringValue
        leftImage = json["leftImage"].stringValue
        roofImage = json["roofImage"].stringValue
        rightImage = json["rightImage"].stringValue
        faceImage = json["faceImage"].stringValue
        
        underGroundReport = [UndergroundReport]()
        let underGroundReportArray = json["UndergroundReport"].arrayValue
        for content in underGroundReportArray{
            let value = UndergroundReport(fromJson: content)
            underGroundReport.append(value)
        }
        
        openCastReport = [OpenCastReport]()
        let openCastReportArray = json["OpenCastReport"].arrayValue
        for content in openCastReportArray{
            let value = OpenCastReport(fromJson: content)
            openCastReport.append(value)
        }
        
        attribute = [Attribute]()
        let attributeArray = json["attribute"].arrayValue
        for attributeJson in attributeArray{
            let value = Attribute(fromJson: attributeJson)
            attribute.append(value)
        }
        
        minesSiteName = json["minesSiteName"].stringValue
        mappingSheetNo = json["mappingSheetNo"].stringValue
        pitName = json["pitName"].stringValue
        pitLoaction = json["pitLoaction"].stringValue
        
        shiftInchargeName = json["shiftInchargeName"].stringValue
        geologistName = json["geologistName"].stringValue
        faceLocation = json["faceLocation"].stringValue
        faceLength = json["faceLength"].stringValue
        faceArea = json["faceArea"].stringValue
        faceRockType = json["faceRockType"].stringValue
        benchRl = json["benchRl"].stringValue
        benchHeightWidth = json["benchHeightWidth"].stringValue
        benchAngle = json["benchAngle"].stringValue
        thicknessOfOre = json["thicknessOfOre"].stringValue
        thicknessOfOverburdan = json["thicknessOfOverburdan"].stringValue
        thicknessOfInterburden = json["thicknessOfInterburden"].stringValue
        observedGradeOfOre = json["observedGradeOfOre"].stringValue
        sampleColledted = json["sampleColledted"].stringValue
        actualGradeOfOre = json["actualGradeOfOre"].stringValue
        weathring = json["weathring"].stringValue
        rockStregth = json["rockStregth"].stringValue
        waterCondition = json["waterCondition"].stringValue
        typeOfGeologist = json["typeOfGeologist"].stringValue
        typeOfFaults = json["typeOfFaults"].stringValue
        ocDate = json["ocDate"].stringValue
        dipDirectionAndAngle = json["dipDirectionAndAngle"].stringValue
        notes = json["notes"].stringValue
        imageDraaw = json["image"].stringValue
        clientsGeologistSign = json["clientsGeologistSign"].stringValue
        geologistSign = json["geologistSign"].stringValue
        comment = json["comment"].stringValue
        reportType = json["reportType"].stringValue
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
        
        if underGroundReport != nil{
            var dictionaryElements = [[String:Any]]()
            for contentDict in underGroundReport {
                dictionaryElements.append(contentDict.toDictionary())
            }
            dictionary["UndergroundReport"] = dictionaryElements
        }
        
        if openCastReport != nil{
            var dictionaryElements = [[String:Any]]()
            for contentDict in openCastReport {
                dictionaryElements.append(contentDict.toDictionary())
            }
            dictionary["OpenCastReport"] = dictionaryElements
        }
        
        if attribute != nil{
            var dictionaryElements = [[String:Any]]()
            for attributeElement in attribute {
                dictionaryElements.append(attributeElement.toDictionary())
            }
            dictionary["attribute"] = dictionaryElements
        }
        
        if minesSiteName != nil{
            dictionary["minesSiteName"] = minesSiteName
        }
        if mappingSheetNo != nil{
            dictionary["mappingSheetNo"] = mappingSheetNo
        }
        if pitName != nil{
            dictionary["pitName"] = pitName
        }
        if pitLoaction != nil{
            dictionary["pitLoaction"] = pitLoaction
        }
        if shift != nil{
            dictionary["shift"] = shift
        }
        if mappedBy != nil{
            dictionary["mappedBy"] = mappedBy
        }
        if scale != nil{
            dictionary["scale"] = scale
        }
        if location != nil{
            dictionary["location"] = location
        }
        if venieLoad != nil{
            dictionary["venieLoad"] = venieLoad
        }
        if xCordinate != nil{
            dictionary["xCordinate"] = xCordinate
        }
        if yCordinate != nil{
            dictionary["yCordinate"] = yCordinate
        }
        if zCordinate != nil{
            dictionary["zCordinate"] = zCordinate
        }
        if ugDate != nil{
            dictionary["ugDate"] = ugDate
        }
        if leftImage != nil{
            dictionary["leftImage"] = leftImage
        }
        if roofImage != nil{
            dictionary["roofImage"] = roofImage
        }
        if rightImage != nil{
            dictionary["rightImage"] = rightImage
        }
        if faceImage != nil{
            dictionary["faceImage"] = faceImage
        }
        if mapSerialNo != nil{
            dictionary["mapSerialNo"] = mapSerialNo
        }
        if rockStregth != nil{
            dictionary["rockStregth"] = rockStregth
        }
        
        
        if shiftInchargeName != nil{
            dictionary["shiftInchargeName"] = shiftInchargeName
        }
        if geologistName != nil{
            dictionary["geologistName"] = geologistName
        }
        if faceLocation != nil{
            dictionary["faceLocation"] = faceLocation
        }
        if faceLength != nil{
            dictionary["faceLength"] = faceLength
        }
        if faceArea != nil{
            dictionary["faceArea"] = faceArea
        }
        if faceRockType != nil{
            dictionary["faceRockType"] = faceRockType
        }
        if benchRl != nil{
            dictionary["benchRl"] = benchRl
        }
        if benchHeightWidth != nil{
            dictionary["benchHeightWidth"] = benchHeightWidth
        }
        if benchAngle != nil{
            dictionary["benchAngle"] = benchAngle
        }
        if thicknessOfOre != nil{
            dictionary["thicknessOfOre"] = thicknessOfOre
        }
        if thicknessOfOverburdan != nil{
            dictionary["thicknessOfOverburdan"] = thicknessOfOverburdan
        }
        if thicknessOfInterburden != nil{
            dictionary["thicknessOfInterburden"] = thicknessOfInterburden
        }
        if observedGradeOfOre != nil{
            dictionary["observedGradeOfOre"] = observedGradeOfOre
        }
        if sampleColledted != nil{
            dictionary["sampleColledted"] = sampleColledted
        }
        if actualGradeOfOre != nil{
            dictionary["actualGradeOfOre"] = actualGradeOfOre
        }
        if weathring != nil{
            dictionary["weathring"] = weathring
        }
        if waterCondition != nil{
            dictionary["waterCondition"] = waterCondition
        }
        if typeOfGeologist != nil{
            dictionary["typeOfGeologist"] = typeOfGeologist
        }
        if typeOfFaults != nil{
            dictionary["typeOfFaults"] = typeOfFaults
        }
        if ocDate != nil{
            dictionary["ocDate"] = ocDate
        }
        if dipDirectionAndAngle != nil{
            dictionary["dipDirectionAndAngle"] = dipDirectionAndAngle
        }
        if notes != nil{
            dictionary["notes"] = notes
        }
        if imageDraaw != nil{
            dictionary["image"] = imageDraaw
        }
        if clientsGeologistSign != nil{
            dictionary["clientsGeologistSign"] = clientsGeologistSign
        }
        if geologistSign != nil{
            dictionary["geologistSign"] = geologistSign
        }
        if comment != nil{
            dictionary["comment"] = comment
        }
        if reportType != nil{
            dictionary["reportType"] = reportType
        }
        return dictionary
    }
}


class Attribute : NSObject , NSCoding{
    
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


