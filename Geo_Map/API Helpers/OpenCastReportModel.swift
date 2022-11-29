//
//  OpenCastReportModel.swift


import Foundation
import UIKit


class OpenCastReport : NSObject, NSCoding{

    var actualGradeOfOre : String!
    var benchAngle : String!
    var benchHeightWidth : String!
    var benchRl : String!
    var clientsGeologistSign : String!
    var dipDirectionAndAngle : String!
    var faceArea : String!
    var faceLength : String!
    var faceLocation : String!
    var faceRockType : String!
    var geologistName : String!
    var geologistSign : String!
    var mappingParameter : String!
    var mappingSheetNo : String!
    var minesSiteName : String!
    var observedGradeOfOre : String!
    var ocDate : String!
    var pitLoaction : String!
    var pitName : String!
    var rockStregth : String!
    var sampleColledted : String!
    var shift : String!
    var shiftInchargeName : String!
    var thicknessOfInterburden : String!
    var thicknessOfOre : String!
    var thicknessOfOverburdan : String!
    var typeOfFaults : String!
    var typeOfGeologist : String!
    var userId : String!
    var waterCondition : String!
    var weathring : String!
    var image : String!
    var notes : String!
    
    
    

    override init() {
        
    }

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        actualGradeOfOre = json["actualGradeOfOre"].stringValue
        benchAngle = json["benchAngle"].stringValue
        benchHeightWidth = json["benchHeightWidth"].stringValue
        benchRl = json["benchRl"].stringValue
        clientsGeologistSign = json["clientsGeologistSign"].stringValue
        dipDirectionAndAngle = json["dipDirectionAndAngle"].stringValue
        faceArea = json["faceArea"].stringValue
        faceLength = json["faceLength"].stringValue
        faceLocation = json["faceLocation"].stringValue
        faceRockType = json["faceRockType"].stringValue
        geologistName = json["geologistName"].stringValue
        geologistSign = json["geologistSign"].stringValue
        mappingParameter = json["mappingParameter"].stringValue
        mappingSheetNo = json["mappingSheetNo"].stringValue
        minesSiteName = json["minesSiteName"].stringValue
        observedGradeOfOre = json["observedGradeOfOre"].stringValue
        ocDate = json["ocDate"].stringValue
        pitLoaction = json["pitLoaction"].stringValue
        pitName = json["pitName"].stringValue
        rockStregth = json["rockStregth"].stringValue
        sampleColledted = json["sampleColledted"].stringValue
        shift = json["shift"].stringValue
        shiftInchargeName = json["shiftInchargeName"].stringValue
        thicknessOfInterburden = json["thicknessOfInterburden"].stringValue
        thicknessOfOre = json["thicknessOfOre"].stringValue
        thicknessOfOverburdan = json["thicknessOfOverburdan"].stringValue
        typeOfFaults = json["typeOfFaults"].stringValue
        typeOfGeologist = json["typeOfGeologist"].stringValue
        userId = json["userId"].stringValue
        waterCondition = json["waterCondition"].stringValue
        weathring = json["weathring"].stringValue
        image = json["image"].stringValue
        notes = json["notes"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if actualGradeOfOre != nil{
            dictionary["actualGradeOfOre"] = actualGradeOfOre
        }
        if benchAngle != nil{
            dictionary["benchAngle"] = benchAngle
        }
        if benchHeightWidth != nil{
            dictionary["benchHeightWidth"] = benchHeightWidth
        }
        if benchRl != nil{
            dictionary["benchRl"] = benchRl
        }
        if clientsGeologistSign != nil{
            dictionary["clientsGeologistSign"] = clientsGeologistSign
        }
        if dipDirectionAndAngle != nil{
            dictionary["dipDirectionAndAngle"] = dipDirectionAndAngle
        }
        if faceArea != nil{
            dictionary["faceArea"] = faceArea
        }
        if faceLength != nil{
            dictionary["faceLength"] = faceLength
        }
        if faceLocation != nil{
            dictionary["faceLocation"] = faceLocation
        }
        if faceRockType != nil{
            dictionary["faceRockType"] = faceRockType
        }
        if geologistName != nil{
            dictionary["geologistName"] = geologistName
        }
        if geologistSign != nil{
            dictionary["geologistSign"] = geologistSign
        }
        if mappingParameter != nil{
            dictionary["mappingParameter"] = mappingParameter
        }
        if mappingSheetNo != nil{
            dictionary["mappingSheetNo"] = mappingSheetNo
        }
        if minesSiteName != nil{
            dictionary["minesSiteName"] = minesSiteName
        }
        if observedGradeOfOre != nil{
            dictionary["observedGradeOfOre"] = observedGradeOfOre
        }
        if ocDate != nil{
            dictionary["ocDate"] = ocDate
        }
        if pitLoaction != nil{
            dictionary["pitLoaction"] = pitLoaction
        }
        if pitName != nil{
            dictionary["pitName"] = pitName
        }
        if rockStregth != nil{
            dictionary["rockStregth"] = rockStregth
        }
        if sampleColledted != nil{
            dictionary["sampleColledted"] = sampleColledted
        }
        if shift != nil{
            dictionary["shift"] = shift
        }
        if shiftInchargeName != nil{
            dictionary["shiftInchargeName"] = shiftInchargeName
        }
        if thicknessOfInterburden != nil{
            dictionary["thicknessOfInterburden"] = thicknessOfInterburden
        }
        if thicknessOfOre != nil{
            dictionary["thicknessOfOre"] = thicknessOfOre
        }
        if thicknessOfOverburdan != nil{
            dictionary["thicknessOfOverburdan"] = thicknessOfOverburdan
        }
        if typeOfFaults != nil{
            dictionary["typeOfFaults"] = typeOfFaults
        }
        if typeOfGeologist != nil{
            dictionary["typeOfGeologist"] = typeOfGeologist
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        if waterCondition != nil{
            dictionary["waterCondition"] = waterCondition
        }
        if weathring != nil{
            dictionary["weathring"] = weathring
        }
        if image != nil{
            dictionary["image"] = image
        }
        if notes != nil{
            dictionary["notes"] = notes
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         actualGradeOfOre = aDecoder.decodeObject(forKey: "actualGradeOfOre") as? String
         benchAngle = aDecoder.decodeObject(forKey: "benchAngle") as? String
         benchHeightWidth = aDecoder.decodeObject(forKey: "benchHeightWidth") as? String
         benchRl = aDecoder.decodeObject(forKey: "benchRl") as? String
         clientsGeologistSign = aDecoder.decodeObject(forKey: "clientsGeologistSign") as? String
         dipDirectionAndAngle = aDecoder.decodeObject(forKey: "dipDirectionAndAngle") as? String
         faceArea = aDecoder.decodeObject(forKey: "faceArea") as? String
         faceLength = aDecoder.decodeObject(forKey: "faceLength") as? String
         faceLocation = aDecoder.decodeObject(forKey: "faceLocation") as? String
         faceRockType = aDecoder.decodeObject(forKey: "faceRockType") as? String
         geologistName = aDecoder.decodeObject(forKey: "geologistName") as? String
         geologistSign = aDecoder.decodeObject(forKey: "geologistSign") as? String
         mappingParameter = aDecoder.decodeObject(forKey: "mappingParameter") as? String
         mappingSheetNo = aDecoder.decodeObject(forKey: "mappingSheetNo") as? String
         minesSiteName = aDecoder.decodeObject(forKey: "minesSiteName") as? String
         observedGradeOfOre = aDecoder.decodeObject(forKey: "observedGradeOfOre") as? String
         ocDate = aDecoder.decodeObject(forKey: "ocDate") as? String
         pitLoaction = aDecoder.decodeObject(forKey: "pitLoaction") as? String
         pitName = aDecoder.decodeObject(forKey: "pitName") as? String
         rockStregth = aDecoder.decodeObject(forKey: "rockStregth") as? String
         sampleColledted = aDecoder.decodeObject(forKey: "sampleColledted") as? String
         shift = aDecoder.decodeObject(forKey: "shift") as? String
         shiftInchargeName = aDecoder.decodeObject(forKey: "shiftInchargeName") as? String
         thicknessOfInterburden = aDecoder.decodeObject(forKey: "thicknessOfInterburden") as? String
         thicknessOfOre = aDecoder.decodeObject(forKey: "thicknessOfOre") as? String
         thicknessOfOverburdan = aDecoder.decodeObject(forKey: "thicknessOfOverburdan") as? String
         typeOfFaults = aDecoder.decodeObject(forKey: "typeOfFaults") as? String
         typeOfGeologist = aDecoder.decodeObject(forKey: "typeOfGeologist") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? String
         waterCondition = aDecoder.decodeObject(forKey: "waterCondition") as? String
         weathring = aDecoder.decodeObject(forKey: "weathring") as? String
        image = aDecoder.decodeObject(forKey: "image") as? String
        notes = aDecoder.decodeObject(forKey: "notes") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if actualGradeOfOre != nil{
            aCoder.encode(actualGradeOfOre, forKey: "actualGradeOfOre")
        }
        if benchAngle != nil{
            aCoder.encode(benchAngle, forKey: "benchAngle")
        }
        if benchHeightWidth != nil{
            aCoder.encode(benchHeightWidth, forKey: "benchHeightWidth")
        }
        if benchRl != nil{
            aCoder.encode(benchRl, forKey: "benchRl")
        }
        if clientsGeologistSign != nil{
            aCoder.encode(clientsGeologistSign, forKey: "clientsGeologistSign")
        }
        if dipDirectionAndAngle != nil{
            aCoder.encode(dipDirectionAndAngle, forKey: "dipDirectionAndAngle")
        }
        if faceArea != nil{
            aCoder.encode(faceArea, forKey: "faceArea")
        }
        if faceLength != nil{
            aCoder.encode(faceLength, forKey: "faceLength")
        }
        if faceLocation != nil{
            aCoder.encode(faceLocation, forKey: "faceLocation")
        }
        if faceRockType != nil{
            aCoder.encode(faceRockType, forKey: "faceRockType")
        }
        if geologistName != nil{
            aCoder.encode(geologistName, forKey: "geologistName")
        }
        if geologistSign != nil{
            aCoder.encode(geologistSign, forKey: "geologistSign")
        }
        if mappingParameter != nil{
            aCoder.encode(mappingParameter, forKey: "mappingParameter")
        }
        if mappingSheetNo != nil{
            aCoder.encode(mappingSheetNo, forKey: "mappingSheetNo")
        }
        if minesSiteName != nil{
            aCoder.encode(minesSiteName, forKey: "minesSiteName")
        }
        if observedGradeOfOre != nil{
            aCoder.encode(observedGradeOfOre, forKey: "observedGradeOfOre")
        }
        if ocDate != nil{
            aCoder.encode(ocDate, forKey: "ocDate")
        }
        if pitLoaction != nil{
            aCoder.encode(pitLoaction, forKey: "pitLoaction")
        }
        if pitName != nil{
            aCoder.encode(pitName, forKey: "pitName")
        }
        if rockStregth != nil{
            aCoder.encode(rockStregth, forKey: "rockStregth")
        }
        if sampleColledted != nil{
            aCoder.encode(sampleColledted, forKey: "sampleColledted")
        }
        if shift != nil{
            aCoder.encode(shift, forKey: "shift")
        }
        if shiftInchargeName != nil{
            aCoder.encode(shiftInchargeName, forKey: "shiftInchargeName")
        }
        if thicknessOfInterburden != nil{
            aCoder.encode(thicknessOfInterburden, forKey: "thicknessOfInterburden")
        }
        if thicknessOfOre != nil{
            aCoder.encode(thicknessOfOre, forKey: "thicknessOfOre")
        }
        if thicknessOfOverburdan != nil{
            aCoder.encode(thicknessOfOverburdan, forKey: "thicknessOfOverburdan")
        }
        if typeOfFaults != nil{
            aCoder.encode(typeOfFaults, forKey: "typeOfFaults")
        }
        if typeOfGeologist != nil{
            aCoder.encode(typeOfGeologist, forKey: "typeOfGeologist")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        if waterCondition != nil{
            aCoder.encode(waterCondition, forKey: "waterCondition")
        }
        if weathring != nil{
            aCoder.encode(weathring, forKey: "weathring")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if notes != nil{
            aCoder.encode(notes, forKey: "notes")
        }
    }

}
