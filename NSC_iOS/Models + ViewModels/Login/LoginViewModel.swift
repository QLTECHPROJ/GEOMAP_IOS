//
//  LoginViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 04/05/22.
//

import Foundation

class LoginViewModel {
    
    var userData: LoginDataModel?
    
    func callLoginAPI(parameters : [String:Any], completion: @escaping (Bool) -> Void) {
        
        debugPrint(parameters)
        
        APIManager.shared.callAPI(router: APIRouter.login(parameters)) { [weak self] (response : LoginModel?) in
            if response?.ResponseCode == "200", let responseData = response?.ResponseData {
                self?.userData = responseData

                LoginDataModel.currentUser = responseData

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showAlertToast(message: Theme.strings.welcome_message)
                }

                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
