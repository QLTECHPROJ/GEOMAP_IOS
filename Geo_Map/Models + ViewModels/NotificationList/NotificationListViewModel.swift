//
//  NotificationListViewModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 19/07/22.
//

import Foundation

class NotificationListViewModel {
    
    var arrayNotifications = [NotificationListDataModel]()
    
    func callNotificationListAPI(completion: @escaping (Bool) -> Void) {
        let parameters = ["coachId":"1"]
        
        APIManager.shared.callAPI(router: APIRouter.notification_listing(parameters)) { [weak self] (response : NotificationListModel?) in
            if response?.ResponseCode == "200", let responseData = response?.ResponseData {
                self?.arrayNotifications = responseData
                
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
