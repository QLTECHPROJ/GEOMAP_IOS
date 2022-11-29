//
//  CoachDetailViewModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 05/05/22.
//

import Foundation

class CoachDetailViewModel {
    
    var userData: LoginDataModel?
    
    func callCoachDetailsAPI(completion: @escaping (Bool) -> Void) {
//        let parameters = ["coachId":LoginDataModel.currentUser?.ID ?? ""]
//        
//        APIManager.shared.callAPI(router: APIRouter.coachdetails(parameters)) { [weak self] (response : LoginModel?) in
//            if response?.ResponseCode == "200", let responseData = response?.ResponseData {
//                self?.userData = responseData
//                
//                LoginDataModel.currentUser = responseData
//                
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
    }
    
}
