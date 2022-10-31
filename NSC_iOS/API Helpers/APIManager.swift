//
//  APIManager.swift
//  NSC_iOS
//
//  Created by Dhruvit on 28/04/22.
//

import Foundation
import CryptoKit
import Alamofire
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
        // print("dateformat:-",utcTimeZoneStr)
        
        let format = DEVICE_UUID + "." + utcTimeZoneStr + "."  + key + "." + valuue
        print("idname:-",format)
        // tokenRandom = CryptoHelper.encrypt(input:format)!
        // let base64encoded = format.toBase64()
        // print("Encoded:", base64encoded as Any)
        
        let skey = "5785abf057d4eea9e59151f75a6fadb724768053df2acdfabb68f2b946b972c6"
        
        let cryptLib = CryptLib()
        let cipherText = cryptLib.encryptPlainTextRandomIV(withPlainText: format, key: skey)
        // print("cipherText \(cipherText! as String)")
        
        let decryptedString = cryptLib.decryptCipherTextRandomIV(withCipherText: cipherText, key: skey)
        // print("decryptedString \(decryptedString! as String)")
        
        // let base64decoded = base64encoded.fromBase64()
        // print("deEncoded:", base64decoded as Any)
        
        // let data = NSData(base64EncodedString: format, options: NSData.Base64DecodingOptions.fromRaw(0)!)
        
        // Convert back to a string
        // let base64Decoded = NSString(data: data, encoding: NSUTF8StringEncoding)
        
        // Base64 encode UTF 8 string
        // fromRaw(0) is equivalent to objc 'base64EncodedStringWithOptions:0'
        // Notice the unwrapping given the NSData! optional
        // NSString! returned (optional)
        // let base64Encoded = utf8str.base64EncodedStringWithOptions(NSData.Base64EncodingOptions.fromRaw(0)!)
        // tokenRandom = base64encoded
        let tokenRandom = cipherText
        
        // debugPrint("cipher:" + tokenRandom!)
        // let deceprt =  CryptoHelper.decrypt(input: tokenRandom!)
        // debugPrint("deceprt:" + deceprt!)
        return tokenRandom ?? ""
    }
    
}
