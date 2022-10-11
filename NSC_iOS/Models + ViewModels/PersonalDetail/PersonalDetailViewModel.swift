//
//  PersonalDetailViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 10/05/22.
//

import Foundation

class PersonalDetailViewModel {
    
    func callUpdatePersonalDetailsAPI(parameters: [String:String], completion: @escaping (Bool) -> Void) {
        APIManager.shared.callAPI(router: APIRouter.coachupdatepersonaldetails(parameters)) { (response : PersonalDetailModel?) in
            if response?.ResponseCode == "200" {
                showAlertToast(message: response?.ResponseMessage ?? "")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
