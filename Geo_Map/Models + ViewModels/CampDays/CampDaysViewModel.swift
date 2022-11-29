//
//  CampDaysViewModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 17/05/22.
//

import Foundation

class CampDaysViewModel {
    
    var totalDays = ""
    var days = [CampDaysDetailModel]()
    
    func callDayListingAPI(campId: String, completion: @escaping (Bool) -> Void) {
        let parameters = ["campId":campId]
        
        APIManager.shared.callAPI(router: APIRouter.daylisting(parameters)) { [weak self] (response : CampDaysModel?) in
            if response?.ResponseCode == "200", let responseData = response?.ResponseData {
                self?.totalDays = responseData.totalDays
                self?.days = responseData.days
                
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
