//
//  LoginCheckViewModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 04/05/22.
//

import Foundation

class LoginCheckViewModel {
    
    var loginFlag: String?
    
    func callLoginCheckAPI(parameters : [String:String], completion: @escaping (Bool) -> Void) {
        debugPrint(parameters)
        APIManager.shared.callAPI(router: APIRouter.login(parameters)) { [weak self] (response : LoginCheckModel?) in
            if let responseData = response?.ResponseData {
                self?.loginFlag = responseData.loginFlag
                
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
