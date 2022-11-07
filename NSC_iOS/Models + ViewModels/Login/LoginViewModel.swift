//
//  LoginViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 04/05/22.
//

import Foundation

class LoginViewModel {
        
    func callLoginAPI(parameters : [String:Any], completionBlock: @escaping (Bool) -> Void) {
        
        debugPrint(parameters)
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.login(parameters),showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
                let userModel = UserModelClass(fromJson: receivdeData["ResponseData"])
                userModel.saveUserSessionInToDefaults()
                userModel.saveUserDetailInDefaults()

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showAlertToast(message: Theme.strings.welcome_message)
                }
                completionBlock(true)
            }
            else{
                completionBlock(false)
            }
        }
    }
}
