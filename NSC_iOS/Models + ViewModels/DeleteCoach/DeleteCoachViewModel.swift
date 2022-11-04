//
//  DeleteCoachViewModel.swift
//  NSC_iOS
//
//  Created by Mac Mini on 09/05/22.
//

import Foundation

class DeleteCoachViewModel {
    
    func callDeleteAccountAPI(completion: @escaping (Bool) -> Void) {
        let parameters = APIParametersModel()
        parameters.iD = JSON(LoginDataModel.currentUser?.profileInformation?.id as Any).stringValue
                                          
        APIManager.shared.callAPI(router: APIRouter.deleteAccount(parameters.toDictionary())) { (response : LogoutModel?) in
            if response?.ResponseCode == "200" {
                completion(true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showAlertToast(message: response?.ResponseMessage ?? "")
                }
            } else {
                completion(false)
            }
        }
    }
    
}
