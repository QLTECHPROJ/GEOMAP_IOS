//
//  LoginViewModel.swift

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
    
    
    func callAPISignUp(parameter : APIParametersModel,isLoader : Bool = true,completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        var reqParameters = APIParametersModel()
        reqParameters = parameter
        reqParameters.deviceToken = GFunctions.shared.getDeviceToken()
        reqParameters.deviceId = DeviceDetail.shared.uuid
        reqParameters.deviceType = DeviceDetail.shared.deviceType
        reqParameters.version = Bundle.main.releaseVersionNumber
    
        debugPrint(reqParameters.toDictionary())
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.register(reqParameters.toDictionary()),isLoader : isLoader,showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
                
                let userModel = UserModelClass(fromJson: receivdeData["ResponseData"])
                userModel.saveUserSessionInToDefaults()
                userModel.saveUserDetailInDefaults()

                CoreDataManager.shared.insertAllTableData(receivdeData["ResponseData"])
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,true)
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
