//
//  ForgotPasswordVM.swift

import Foundation

class ForgotPasswordVM {
    
    func callAPIForgotPassword(parameters : APIParametersModel,isLoader : Bool = true, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.forgot_password(parameters.toDictionary()),isLoader : isLoader, showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
                            
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,false)
            }
        }
    }
}
