//
//  ReferDataViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 27/05/22.
//

import Foundation

class ReferDataViewModel {
    
    var referDetail: ReferDetailModel?
    
    func callReferDataAPI(completion: @escaping (Bool) -> Void) {
//        let parameters = ["coachId":LoginDataModel.currentUser?.ID ?? ""]
//        
//        APIManager.shared.callAPI(router: APIRouter.referdata(parameters)) { [weak self] (response : ReferDataModel?) in
//            if let responseData = response?.ResponseData {
//                self?.referDetail = responseData
//                
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
    }
    
}
