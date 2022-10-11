//
//  DJValidation.swift
//

import Foundation
import UIKit

func jsonStringConvert(_ obj : AnyObject) -> String {
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: obj, options: JSONSerialization.WritingOptions.prettyPrinted)
        return  String(data: jsonData, encoding: String.Encoding.utf8)! as String
        
    } catch {
        return ""
    }
}

func facebookProfileURL(_ id : String) -> String {
    
    return "https://graph.facebook.com/\(id)/picture?type=large"
}

func convertStringToDictionary(_ text: String) -> [String:AnyObject]? {
    
    if let data = text.data(using: String.Encoding.utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
        }
        catch let error as NSError {
            print(error)
        }
    }
    return nil
}

func convertIntoJSONString(arrayObject: [Any]) -> String? {
    
    do {
        let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
        if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
            return jsonString as String
        }
        
    } catch let error as NSError {
        print("Array convertIntoJSON - \(error.description)")
    }
    return nil
}

func convertIntoJSON(arrayObject: [String:AnyObject]) -> String? {
       
       do {
           let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
           if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
               return jsonString as String
           }
           
       } catch let error as NSError {
           print("Array convertIntoJSON - \(error.description)")
       }
       return nil
   }
