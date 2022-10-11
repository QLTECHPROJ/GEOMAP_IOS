//
//  SaveAppliedCampsViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 19/05/22.
//

import Foundation

class SaveAppliedCampsViewModel {
    
    func callSaveAppliedCampsAPI(campIds : String, completion: @escaping (Bool) -> Void) {
        let parameters = ["coachId":LoginDataModel.currentUser?.ID ?? "",
                          "campData":campIds]
        
        APIManager.shared.callAPI(router: APIRouter.applycampdatasave(parameters)) { (response : LogoutModel) in
            if response.ResponseCode == "200" {
                showAlertToast(message: response.ResponseMessage)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
