//
//  SyncDataVM.swift


import Foundation
import UIKit

class SyncDataVM {

    func callAPISyncData(parameters : [String:Any],isLoader : Bool = true, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        debugPrint(parameters)
        
        guard checkInternet(true) else { return completionBlock(nil,nil,kNoInternetConnection,false)}
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.sync_data(parameters),isLoader : isLoader,showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
               
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,false)
            }
        }
    }
    /*
userId: 1
name: test
shift: test shift
mappedBy: test map
scale: 2*3
location: test lo
venieLoad: test load,
xCordinate: 85
yCordinate: 88
zCordinate: 88
comment: test conten
mapSerialNo: 123
ugDate: 1-Nov-2022
leftImage
roofImage
rightImage
faceImage
attribute: [ {"name": "test","nose": "test nose",  "properties": "dssdv"},{"name": "test","nose": "test nose",  "properties": "dssdv"},{"name": "test","nose": "test nose",  "properties": "dssdv"}]
    */
    func callAPIUploadUnderGroungMappingReport(isLoader : Bool = true,parameters : [String:Any], uploadParameters : [UploadDataModel], completion: @escaping (Bool,String?) -> Void) {
       
        debugPrint(parameters)
        
        APIManager.shared.callUploadWebService(apiUrl: APIRouter.underground_insert(parameters).urlRequest!.url!.absoluteString, includeHeader: true, parameters: parameters, uploadParameters: uploadParameters, httpMethod: .post,displayHud: isLoader) { [weak self] (response : LoginModel?) in
            if JSON(response?.ResponseCode as Any).stringValue == ApiKeys.ApiStatusCode.success.rawValue {
               
                
                completion(true,response?.ResponseMessage ?? nil)
            } else {
                completion(false,response?.ResponseMessage ?? nil)
            }
        }
    }
    

    
    func callAPIUploadOpenCastMappingReport(isLoader : Bool = true,parameters : [String:Any], uploadParameters : [UploadDataModel], completion: @escaping (Bool,String?) -> Void) {
       
        debugPrint(parameters)
        guard checkInternet(true) else {return}
        APIManager.shared.callUploadWebService(apiUrl: APIRouter.open_cast_insert(parameters).urlRequest!.url!.absoluteString, includeHeader: true, parameters: parameters, uploadParameters: uploadParameters, httpMethod: .post,displayHud : isLoader)
        { [weak self] (response : LoginModel?) in
            
            if JSON(response?.ResponseCode as Any).stringValue == ApiKeys.ApiStatusCode.success.rawValue{
               
                completion(true,response?.ResponseMessage)
            } else {
                completion(false,response?.ResponseMessage)
            }
        }
    }
}
