//
//  ListDataViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 28/04/22.
//

import Foundation

class ListDataViewModel {
    
    var listItemData: [ListItem]?
    
    func callItemListAPI(strID : String, listType : ListItemType, completion: @escaping (Bool) -> Void) {
        var parameters = [String:String]()
        var apiRequest : APIRouter?
        
        switch listType {
        case .country:
            apiRequest = APIRouter.countrylist
        case .state:
            parameters = ["countryId":strID]
            apiRequest = APIRouter.statelist(parameters)
        case .city:
            parameters = ["stateId":strID]
            apiRequest = APIRouter.citylist(parameters)
        case .sport:
            apiRequest = APIRouter.categorylist
            break
        case .role:
            apiRequest = APIRouter.coachrole
        }
        
        guard let apiRequest = apiRequest else {
            showAlertToast(message: Theme.strings.alert_something_went_wrong)
            return
        }
        
        APIManager.shared.callAPI(router: apiRequest) { (response : ListDataModel) in
            if response.ResponseCode == "200" {
                self.listItemData = response.ResponseData
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
