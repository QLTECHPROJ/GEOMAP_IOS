//
//  AppVersionViewModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 28/04/22.
//

import Foundation

class AppVersionViewModel {
    
    var appVersionData: AppVersionDetailModel?
    
    func callAppVersionAPI(completion: @escaping (Bool) -> Void) {
//        let parameters = ["version":APP_VERSION,
//                          "timeZone":TimeZone.current.identifier,
//                          "deviceType":APP_TYPE,
//                          "deviceId":DEVICE_UUID,
//                          "deviceToken":FCM_TOKEN,
//                          "coachId":LoginDataModel.currentUser?.ID ?? ""]
//        
//        APIManager.shared.callAPI(router: APIRouter.appversion(parameters), isLoader: false, showToast: true) { [weak self] (response : AppVersionModel?) in
//            if let responseData = response?.ResponseData {
//                self?.appVersionData = responseData
//                
//                AppVersionDetails.current = responseData
//                
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
    }
    
}
