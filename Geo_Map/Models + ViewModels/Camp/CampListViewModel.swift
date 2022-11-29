//
//  CampListViewModel.swift
//  Geo_Map
//
//  Created by Mac Mini on 09/05/22.
//

import Foundation

class CampListViewModel {
    
    var BannerImage = ""
    var arrayCurrentCampList = [CampDetailModel]()
    var arrayUpcomingCampList = [CampDetailModel]()
    
    func callCampListAPI(completion: @escaping (Bool) -> Void) {
//        let parameters = ["coachId":LoginDataModel.currentUser?.ID ?? ""]
        
//        APIManager.shared.callAPI(router: APIRouter.camplisting(parameters)) { [weak self] (response : CampListModel?) in
//            if response?.ResponseCode == "200", let responseData = response?.ResponseData {
//                self?.BannerImage = responseData.BannerImage
//                self?.arrayCurrentCampList = responseData.current
//                self?.arrayUpcomingCampList = responseData.upcoming
//                
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
    }
    
}

