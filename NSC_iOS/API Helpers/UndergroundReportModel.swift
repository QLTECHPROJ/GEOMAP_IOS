//
//  UndergroundReportModel.swift


import Foundation
import UIKit


class UndergroundReport : NSObject, NSCoding{

    var attribute : [Attribute]!
    var comment : String!
    var faceImage : String!
    var leftImage : String!
    var location : String!
    var mapSerialNo : String!
    var mappedBy : String!
    var name : String!
    var rightImage : String!
    var roofImage : String!
    var scale : String!
    var shift : String!
    var ugDate : String!
    var userId : String!
    var venieLoad : String!
    var xCordinate : String!
    var yCordinate : String!
    var zCordinate : String!

    
    override init() {
        
    }

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        attribute = [Attribute]()
        let attributeArray = json["attribute"].arrayValue
        for attributeJson in attributeArray{
            let value = Attribute(fromJson: attributeJson)
            attribute.append(value)
        }
        comment = json["comment"].stringValue
        faceImage = json["faceImage"].stringValue
        leftImage = json["leftImage"].stringValue
        location = json["location"].stringValue
        mapSerialNo = json["mapSerialNo"].stringValue
        mappedBy = json["mappedBy"].stringValue
        name = json["name"].stringValue
        rightImage = json["rightImage"].stringValue
        roofImage = json["roofImage"].stringValue
        scale = json["scale"].stringValue
        shift = json["shift"].stringValue
        ugDate = json["ugDate"].stringValue
        userId = json["userId"].stringValue
        venieLoad = json["venieLoad"].stringValue
        xCordinate = json["xCordinate"].stringValue
        yCordinate = json["yCordinate"].stringValue
        zCordinate = json["zCordinate"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if attribute != nil{
            var dictionaryElements = [[String:Any]]()
            for attributeElement in attribute {
                dictionaryElements.append(attributeElement.toDictionary())
            }
            dictionary["attribute"] = dictionaryElements
        }
        if comment != nil{
            dictionary["comment"] = comment
        }
        if faceImage != nil{
            dictionary["faceImage"] = faceImage
        }
        if leftImage != nil{
            dictionary["leftImage"] = leftImage
        }
        if location != nil{
            dictionary["location"] = location
        }
        if mapSerialNo != nil{
            dictionary["mapSerialNo"] = mapSerialNo
        }
        if mappedBy != nil{
            dictionary["mappedBy"] = mappedBy
        }
        if name != nil{
            dictionary["name"] = name
        }
        if rightImage != nil{
            dictionary["rightImage"] = rightImage
        }
        if roofImage != nil{
            dictionary["roofImage"] = roofImage
        }
        if scale != nil{
            dictionary["scale"] = scale
        }
        if shift != nil{
            dictionary["shift"] = shift
        }
        if ugDate != nil{
            dictionary["ugDate"] = ugDate
        }
        if userId != nil{
            dictionary["userId"] = userId
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
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         attribute = aDecoder.decodeObject(forKey: "attribute") as? [Attribute]
         comment = aDecoder.decodeObject(forKey: "comment") as? String
         faceImage = aDecoder.decodeObject(forKey: "faceImage") as? String
         leftImage = aDecoder.decodeObject(forKey: "leftImage") as? String
         location = aDecoder.decodeObject(forKey: "location") as? String
         mapSerialNo = aDecoder.decodeObject(forKey: "mapSerialNo") as? String
         mappedBy = aDecoder.decodeObject(forKey: "mappedBy") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         rightImage = aDecoder.decodeObject(forKey: "rightImage") as? String
         roofImage = aDecoder.decodeObject(forKey: "roofImage") as? String
         scale = aDecoder.decodeObject(forKey: "scale") as? String
         shift = aDecoder.decodeObject(forKey: "shift") as? String
         ugDate = aDecoder.decodeObject(forKey: "ugDate") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? String
         venieLoad = aDecoder.decodeObject(forKey: "venieLoad") as? String
         xCordinate = aDecoder.decodeObject(forKey: "xCordinate") as? String
         yCordinate = aDecoder.decodeObject(forKey: "yCordinate") as? String
         zCordinate = aDecoder.decodeObject(forKey: "zCordinate") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if attribute != nil{
            aCoder.encode(attribute, forKey: "attribute")
        }
        if comment != nil{
            aCoder.encode(comment, forKey: "comment")
        }
        if faceImage != nil{
            aCoder.encode(faceImage, forKey: "faceImage")
        }
        if leftImage != nil{
            aCoder.encode(leftImage, forKey: "leftImage")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if mapSerialNo != nil{
            aCoder.encode(mapSerialNo, forKey: "mapSerialNo")
        }
        if mappedBy != nil{
            aCoder.encode(mappedBy, forKey: "mappedBy")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if rightImage != nil{
            aCoder.encode(rightImage, forKey: "rightImage")
        }
        if roofImage != nil{
            aCoder.encode(roofImage, forKey: "roofImage")
        }
        if scale != nil{
            aCoder.encode(scale, forKey: "scale")
        }
        if shift != nil{
            aCoder.encode(shift, forKey: "shift")
        }
        if ugDate != nil{
            aCoder.encode(ugDate, forKey: "ugDate")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        if venieLoad != nil{
            aCoder.encode(venieLoad, forKey: "venieLoad")
        }
        if xCordinate != nil{
            aCoder.encode(xCordinate, forKey: "xCordinate")
        }
        if yCordinate != nil{
            aCoder.encode(yCordinate, forKey: "yCordinate")
        }
        if zCordinate != nil{
            aCoder.encode(zCordinate, forKey: "zCordinate")
        }

    }

}
