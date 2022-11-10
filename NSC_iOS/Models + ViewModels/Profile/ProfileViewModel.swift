//
//  ProfileViewModel.swift
//  
//
//  Created by on 11/05/22.
//

import Foundation

class ProfileViewModel {
    
    var profileData: LoginDataModel?
    
    func callProfileUpdateAPI(parameters : [String:Any], uploadParameters : [UploadDataModel], completion: @escaping (Bool) -> Void) {
       
        debugPrint(parameters)
        
        APIManager.shared.callUploadWebService(apiUrl: APIRouter.profileUpdate(parameters).urlRequest!.url!.absoluteString, includeHeader: true, parameters: parameters, uploadParameters: uploadParameters, httpMethod: .post) { [weak self] (response : LoginModel?) in
            if response?.ResponseCode == "200", let responseData = response?.ResponseData {
                self?.profileData = responseData
                LoginDataModel.currentUser = responseData
                showAlertToast(message: response?.ResponseMessage ?? "")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func callAPIGetUserProfile(isLoader : Bool = false, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        let parameters = APIParametersModel()
        parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
        debugPrint(parameters)
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.user_details((parameters.toDictionary())),isLoader : isLoader,showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
                let userModel = UserModelClass(fromJson: receivdeData["ResponseData"])
                userModel.saveUserSessionInToDefaults()
                userModel.saveUserDetailInDefaults()
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,false)
            }
        }
    }
    
}

