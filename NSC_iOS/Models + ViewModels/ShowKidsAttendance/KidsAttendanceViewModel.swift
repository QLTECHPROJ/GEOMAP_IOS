//
//  KidsAttendanceViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 19/05/22.
//

import Foundation

class KidsAttendanceViewModel {
    
    var dayId = ""
    var dayshift = ""
    var arrayKids = [KidsAttendanceDetailModel]()
    
    func callShowKidsAttendanceAPI(campId: String, dayId: String, completion: @escaping (Bool) -> Void) {
//        let parameters = ["coachId":LoginDataModel.currentUser?.ID ?? "",
//                          "campId":campId]
//        
//        APIManager.shared.callAPI(router: APIRouter.kidsattendanceshow(parameters)) { [weak self] (response : KidsAttendanceModel?) in
//            if response?.ResponseCode == "200", let responseData = response?.ResponseData {
//                self?.dayId = responseData.dayId
//                self?.dayshift = responseData.dayshift
//                self?.arrayKids = responseData.kidsattendance
//                
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
    }
    
}
