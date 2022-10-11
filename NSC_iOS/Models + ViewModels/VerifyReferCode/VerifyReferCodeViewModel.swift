//
//  VerifyReferCodeViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 17/05/22.
//

import Foundation

class VerifyReferCodeViewModel {
    
    func callVerifyReferCodeAPI(referCode: String, completion: @escaping (Bool) -> Void) {
        let parameters = ["referCode":referCode]
        
        APIManager.shared.callAPI(router: APIRouter.verify_refercode(parameters)) { (response : LogoutModel?) in
            if response?.ResponseCode == "200" {
                showAlertToast(message: response?.ResponseMessage ?? "")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
