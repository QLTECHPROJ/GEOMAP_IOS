//
//  DeleteCoachViewModel.swift

import Foundation

class DeleteCoachViewModel {
    
    func callDeleteAccountAPI(completion: @escaping (Bool) -> Void) {
        let parameters = APIParametersModel()
        parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
                                          
        APIManager.shared.callAPI(router: APIRouter.delete_user(parameters.toDictionary())) { (response : LogoutModel?) in
            if response?.ResponseCode == "200" {
                completion(true)
                
            } else {
                completion(false)
            }
        }
    }
    
}
