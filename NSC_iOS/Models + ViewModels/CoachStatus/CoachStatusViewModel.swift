//
//  CoachStatusViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 05/05/22.
//

import Foundation

class CoachStatusViewModel {
    
    var coachStatusData: CoachStatusDataModel?
    
    func callCoachStatusAPI(completion: @escaping (Bool) -> Void) {
        let parameters = ["coachId":LoginDataModel.currentUser?.ID ?? ""]
        
        APIManager.shared.callAPI(router: APIRouter.coachstatus(parameters)) { [weak self] (response : CoachStatusModel?) in
            if let responseData = response?.ResponseData {
                self?.coachStatusData = responseData
                
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
