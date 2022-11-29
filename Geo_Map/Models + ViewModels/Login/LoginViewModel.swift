//
//  LoginViewModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 04/05/22.
//

import Foundation

class LoginViewModel {
        
    func callLoginAPI(parameters : [String:Any], completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        debugPrint(parameters)
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.login(parameters),showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
                let userModel = UserModelClass(fromJson: receivdeData["ResponseData"])
                userModel.saveUserSessionInToDefaults()
                userModel.saveUserDetailInDefaults()

                CoreDataManager.shared.insertAllTableData(receivdeData["ResponseData"])
                
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,false)
            }
        }
    }
    
    func callAPIVersionUpdate(isLoader : Bool = false,completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        let parameters = APIParametersModel()
        parameters.deviceToken = GFunctions.shared.getDeviceToken()
        parameters.deviceId = DeviceDetail.shared.uuid
        parameters.deviceType = DeviceDetail.shared.deviceType
        parameters.version = Bundle.main.releaseVersionNumber
    
        debugPrint(parameters)
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.app_version(parameters.toDictionary()),isLoader : isLoader,showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
           
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,true)
            }
        }
    }
}
