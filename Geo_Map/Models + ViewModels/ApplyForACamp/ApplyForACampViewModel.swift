//
//  ApplyForACampViewModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 18/05/22.
//

import Foundation

class ApplyForACampViewModel {
    
    var maxCount = 3
    var arrayCamps: [ApplyCampModel]?
    
    func callItemListAPI(completion: @escaping (Bool) -> Void) {
//        let parameters = ["coachId":LoginDataModel.currentUser?.ID ?? ""]
//
//        APIManager.shared.callAPI(router: APIRouter.applyForACampListing(parameters)) { (response : ApplyForACampModel) in
//            if response.ResponseCode == "200", let responseData = response.ResponseData {
//                self.maxCount = Int(responseData.maxCount ?? "") ?? 3
//                self.arrayCamps = responseData.campList
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
    }
    
}
