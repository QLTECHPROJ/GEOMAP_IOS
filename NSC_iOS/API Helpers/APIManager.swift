//
//  APIManager.swift
//  NSC_iOS
//
//  Created by Dhruvit on 28/04/22.
//

import Foundation
import CryptoKit
@_exported import Alamofire
import EVReflection


class APIManager {
    
    static let shared = APIManager()
    
    var apiRequest : DataRequest?
    
    func callAPI<M : EVObject>(router : URLRequestConvertible, isLoader : Bool = true, showToast : Bool = true, response : @escaping (M) -> Void) {
        
        if checkInternet() == false {
            showAlertToast(message: Theme.strings.alert_check_internet)
            response(M())
            return
        }
        
        if isLoader {
            showHud()
        }
        
        self.apiRequest = Alamofire.request(router).responseObject { (responseObj : DataResponse<M>) in
            
            hideHud()
            
            if let error = responseObj.result.error {
                if checkErrorTypeNetworkLost(error: error) {
                    self.callAPI(router: router, response: response)
                }
            }
            
            self.handleError(data: responseObj, showToast: showToast, response: { (success) in
                if success {
                    
                    if let value = responseObj.result.value {
                        response(value)
                        let dict = value.toDictionary()
                        if (dict["ResponseCode"] as? String) != "200" {
                            if (dict["ResponseCode"] as? String) == "403" {
//                                APPDELEGATE.logout()
                                AppDelegate.shared.updateWindow()
                            } else if let message = dict["ResponseMessage"] as? String, message.trim.count > 0 , message != "Reminder not Available for any playlist!" {
                                if showToast { showAlertToast(message: message) }
                            }
                        }
                    }
                }
            })
        }
        .responseString { (resp) in
            print(resp)
        }
        //        .responseJSON { (resp) in
        //            print("responseJSON :- ", resp)
        //        }
    }
    
    func callUploadWebService<M : EVObject>(apiUrl : String, includeHeader : Bool, parameters : [String:Any]?, uploadParameters : [UploadDataModel], httpMethod : Alamofire.HTTPMethod, displayHud : Bool = true, showToast : Bool = true, responseModel : @escaping (M) -> Void) {
        
        if checkInternet() == false {
            showAlertToast(message: Theme.strings.alert_check_internet)
            responseModel(M())
            return
        }
        
        if displayHud {
            showHud()
        }
        
        var headers : HTTPHeaders?
        if includeHeader {
            headers = ["Accept":"application/json",
                       "Oauth":APIManager.shared.generateToken(),
                       "Yaccess":DEVICE_UUID]
        }
        
        if parameters != nil {
            print("parameters :- ",parameters!)
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if parameters != nil {
                for (key, value) in parameters! {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
            if uploadParameters.count > 0 {
                for uploadDict in uploadParameters {
                    if let fileData = uploadDict.data {
                        multipartFormData.append(fileData, withName: uploadDict.key, fileName: uploadDict.name, mimeType: uploadDict.mimeType)
                    }
                }
            }
            
        }, usingThreshold: UInt64.init(), to: apiUrl, method: httpMethod, headers: headers) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                upload.responseObject { (response : DataResponse<M>) in
                    
                    hideHud()
                    
                    if let error = response.result.error {
                        if checkErrorTypeNetworkLost(error: error) {
                            self.callUploadWebService(apiUrl: apiUrl, includeHeader: includeHeader, parameters: parameters, uploadParameters: uploadParameters, httpMethod: httpMethod, displayHud: displayHud, showToast: showToast, responseModel: responseModel)
                        }
                    }
                    
                    self.handleError(data: response, showToast: showToast, response: { (success) in
                        if success {
                            if let value = response.result.value {
                                responseModel(value)
                                let dict = value.toDictionary()
                                if (dict["ResponseCode"] as? String) != "200" {
                                    if (dict["ResponseCode"] as? String) == "403" {
//                                        APPDELEGATE.logout()
                                        AppDelegate.shared.updateWindow()
                                    } else if let message = dict["ResponseMessage"] as? String, message.trim.count > 0 {
                                        if showToast { showAlertToast(message: message) }
                                    }
                                }
                            }
                        }
                    })
                }
                .responseString { (resp) in
                    print(resp)
                }
            case .failure(let error):
                hideHud()
                print("Error in upload: \(error.localizedDescription)")
                showAlertToast(message: error.localizedDescription)
            }
        }
        
    }
    
    func handleError<D : EVObject>(data : DataResponse<D>, showToast : Bool = true, response : @escaping (Bool) -> Void) {
        //        print(data)
        
        guard let dict = data.result.value?.toDictionary() else {
            // showAlertToast(message: Theme.strings.alert_something_went_wrong)
            return
        }
        
        guard let message = dict.value(forKey: "ResponseMessage") as? String else {
            // showAlertToast(message: Theme.strings.alert_something_went_wrong)
            return
        }
        
        switch data.response?.statusCode ?? 0 {
        case 200...299:
            response(true)
        case 401:
            // UnAuthenticated request
            response(false)
            if showToast && message.trim.count > 0 { showAlertToast(message: message) }
        default:
            response(false)
            if showToast && message.trim.count > 0 { showAlertToast(message: message) }
        }
    }
    
}


extension APIManager {
    
    func generateToken()-> String {
        let arrToken = ["AES:OsEUHhecSs4gRGcy2vMQs1s/XajBrLGADR71cKMRNtA=","RSA:KlWxBHfKPGkkeTjkT7IEo32bZW8GlVCPq/nvVFuYfIY=","TDES:1dpra0SZhVPpiUQvikMvkDxEp7qLLJL9pe9G6Apg01g=","SHA1:Ey8rBCHsqITEbh7KQKRmYObCGBXqFnvtL5GjMFQWHQo=","MD5:/qc2rO3RB8Z/XA+CmHY0tCaJch9a5BdlQW1xb7db+bg="]
        let randomElement = arrToken.randomElement()
        // print(randomElement as Any)
        
        let fullNameArr = randomElement!.split{$0 == ":"}.map(String.init)
        let key = fullNameArr[0]
        let valuue = fullNameArr[1]
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        let utcTimeZoneStr = formatter.string(from: date as Date)
        
        let format = DEVICE_UUID + "." + utcTimeZoneStr + "."  + key + "." + valuue
        print("idname:-",format)
        
        let skey = "5785abf057d4eea9e59151f75a6fadb724768053df2acdfabb68f2b946b972c6"
        
        let cryptLib = CryptLib()
        let cipherText = cryptLib.encryptPlainTextRandomIV(withPlainText: format, key: skey)
        
        let decryptedString = cryptLib.decryptCipherTextRandomIV(withCipherText: cipherText, key: skey)
        
        let tokenRandom = cipherText
       
        return tokenRandom ?? ""
    }
    
}


extension APIManager{
    
    func callAPIWithJSON(router : URLRequestConvertible,
                         isLoader : Bool = true,
                         showToast : Bool = true,
                         withBlock completion :((DataResponse<Any>,_ data : JSON?,_ statusCode : String?,_ message : String,_ completion : Bool) -> Void)?){
        if checkInternet() == false {
            showAlertToast(message: Theme.strings.alert_check_internet)
//            response(nil,false)
            return
        }

        if isLoader {
            showHud()
        }

        Alamofire.request(router).responseJSON(completionHandler: { responseData in
            hideHud()
            debugPrint(responseData)
            switch responseData.result {
            case .success(let response) :

                debugPrint(responseData)
                
                if let value = responseData.result.value as? NSDictionary{
                    let jsonValue = JSON(value)
                    if JSON(value)["ResponseCode"].stringValue == ApiKeys.ApiStatusCode.success.rawValue{
                      
                        completion?(responseData,JSON(value),JSON(value)["ResponseCode"].stringValue,JSON(value)["ResponseMessage"].stringValue,true)
                    }
                    else if JSON(value)["ResponseCode"].stringValue == ApiKeys.ApiStatusCode.userSessionExpire.rawValue{
                        AppDelegate.shared.updateWindow()
                        completion?(responseData,nil,JSON(value)["ResponseCode"].stringValue,JSON(value)["ResponseMessage"].stringValue,false)
                    }
                    else if JSON(value)["ResponseCode"].stringValue == ApiKeys.ApiStatusCode.invalidOrFail.rawValue{
                        completion?(responseData,nil,JSON(value)["ResponseCode"].stringValue,JSON(value)["ResponseMessage"].stringValue,false)
                    }
                }
                break

            case .failure(let error):

                if (error as NSError).code == NSURLErrorCancelled {
                    // Manage cancellation here

                    debugPrint("apiName\(router),======== error = \(error)")
                    completion?(JSON(responseData).rawValue as! DataResponse<Any>,nil,nil,error.localizedDescription,false)
                    return
                }
            }
        })
    }
    
    
    func calerwerlAPI<M : EVObject>(router : URLRequestConvertible, isLoader : Bool = true, showToast : Bool = true, response : @escaping (M) -> Void) {
        
        if checkInternet() == false {
            showAlertToast(message: Theme.strings.alert_check_internet)
            response(M())
            return
        }
        
        if isLoader {
            showHud()
        }
        
        self.apiRequest = Alamofire.request(router).responseObject { (responseObj : DataResponse<M>) in
            
            hideHud()
            
            if let error = responseObj.result.error {
                if checkErrorTypeNetworkLost(error: error) {
                    self.callAPI(router: router, response: response)
                }
            }
            
            self.handleError(data: responseObj, showToast: showToast, response: { (success) in
                if success {
                    
                    if let value = responseObj.result.value {
                        response(value)
                        let dict = value.toDictionary()
                        if (dict["ResponseCode"] as? String) != "200" {
                            if (dict["ResponseCode"] as? String) == "403" {
//                                APPDELEGATE.logout()
                                AppDelegate.shared.updateWindow()
                            } else if let message = dict["ResponseMessage"] as? String, message.trim.count > 0 , message != "Reminder not Available for any playlist!" {
                                if showToast { showAlertToast(message: message) }
                            }
                        }
                    }
                }
            })
        }
        .responseString { (resp) in
            print(resp)
        }
        //        .responseJSON { (resp) in
        //            print("responseJSON :- ", resp)
        //        }
    }
}

struct DataResult {
    var data : JSON = JSON.null
    var httpCode : Int = NSNotFound
    var apiCode : ApiKeys.ApiStatusCode = .invalidOrFail
    var message : String = ""
    var response : JSON = JSON.null
}



enum ApiKeys {
//    case header(ApiHeaderKeys)
//    case encrypt(EncryptionKeys)
//    case respsone(ApiResponseKey)
    case statusCode(ApiStatusCode)
    
    var value: String {
        switch self {
//        case .header(let key):
//            return key.rawValue
//        case .encrypt(let key):
//            return key.rawValue
//        case .respsone(let key):
//            return key.rawValue
        case .statusCode(let key):
            return key.rawValue
      }
    }
}

/// Set All keys here
extension ApiKeys {
    
//    200 sucess
//    401 fail
//    403 un auth acess
    //MARK:- APIStatusCodeEnum
    internal enum ApiStatusCode: String {
        
        case invalidOrFail                  = "401"
        case success                        = "200"
        case userSessionExpire              = "403"
    }
}

/*
 SUCCESS: {
     ResponseCode = 200;
     ResponseData =     (
                 {
             "created_at" = "2022-10-31T17:36:25.000000Z";
             id = 1;
             name = "test attribute";
             nos =             (
                                 {
                     attributeId = 1;
                     "created_at" = "2022-10-31T17:36:48.000000Z";
                     id = 1;
                     name = "test child attribute";
                     "updated_at" = "2022-10-31T17:36:48.000000Z";
                 }
             );
             "updated_at" = "2022-10-31T17:36:25.000000Z";
         }
     );
     ResponseMessage = "Attributes and Num Cobine Data";
     ResponseStatus = Success;
 }
 */
