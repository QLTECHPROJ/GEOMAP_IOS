//
//  ListDataViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 28/04/22.
//

import Foundation

class ListDataViewModel {
    
    var listItemData: [ListItem]?
    
    func callItemListAPI(parameters : [String:Any], listType : ListItemType, completion: @escaping (Bool) -> Void) {
        
        var apiRequest : APIRouter?
        
        switch listType {
        case .attributes:
            
            apiRequest = APIRouter.attribute_data_number
            
            break
        case .Nos:
//            apiRequest = APIRouter.statelist(parameters)
            break
        case .sampleCollected:
            
            break
        case .weathering:
            
            break
        case .rockStrenght:
            
            break
            
        case .waterCollection:
            
            break
            
        case .typeOfGeologicalStructure:
            
            break
            
        case .typeOfFaults:
            
            break
        }
        
        guard let apiRequest = apiRequest else {
            showAlertToast(message: Theme.strings.alert_something_went_wrong)
            return
        }
        
//        APIManager.shared.callAPIJSON(router: apiRequest) { <#Result<DataResult, Error>#> in
//            <#code#>
//        }
        
//        APIManager.shared.callAPI(router: apiRequest) { (response : ListDataModel) in
//            debugPrint(response)
//            if response.ResponseCode == "200" {
////                self.listItemData = response.ResponseData
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
    }
    
}
