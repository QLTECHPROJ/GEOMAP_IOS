//
//  EarningViewModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 18/05/22.
//

import Foundation

class EarningViewModel {
    
    var totalBalance = ""
    var transactions = [TransactionModel]()
    
    func callMyEarningAPI(completion: @escaping (Bool) -> Void) {
//        let parameters = ["coachId":LoginDataModel.currentUser?.ID ?? ""]
//        
//        APIManager.shared.callAPI(router: APIRouter.myearning(parameters)) { [weak self] (response : EarningModel?) in
//            if response?.ResponseCode == "200", let responseData = response?.ResponseData {
//                self?.totalBalance = responseData.TotalBalance
//                self?.transactions = responseData.transactions
//                
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
    }
    
}
