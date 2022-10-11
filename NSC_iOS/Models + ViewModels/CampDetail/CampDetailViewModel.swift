//
//  CampDetailViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 11/05/22.
//

import Foundation

class CampDetailViewModel {
    
    var campDetails: CampDetailModel?
    
    func callCampDetailsAPI(campId : String, completion: @escaping (Bool) -> Void) {
        let parameters = ["coachId":LoginDataModel.currentUser?.ID ?? "",
                          "campId":campId]
        
        APIManager.shared.callAPI(router: APIRouter.campdetails(parameters)) { [weak self] (response : CampDetailDataModel?) in
            if let responseData = response?.ResponseData {
                self?.campDetails = responseData
                
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
