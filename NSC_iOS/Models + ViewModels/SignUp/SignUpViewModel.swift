//
//  SignUpViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 05/05/22.
//

import Foundation

class SignUpViewModel {
    
    var userData: LoginDataModel?
    
    func callCoachRegisterAPI(parameters : [String:String], completion: @escaping (Bool) -> Void) {
        APIManager.shared.callAPI(router: APIRouter.coachregister(parameters)) { [weak self] (response : LoginModel?) in
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
