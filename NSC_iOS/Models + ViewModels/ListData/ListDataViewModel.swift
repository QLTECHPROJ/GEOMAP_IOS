//
//  ListDataViewModel.swift
//  NSC_iOS
//
//  Created by Dhruvit on 28/04/22.
//

import Foundation

class ListDataViewModel {

    
    func callItemListAPI(parameters : [String:Any], listType : ListItemType, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
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

        APIManager.shared.callAPIWithJSON(router: apiRequest,showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,false)
            }
        }
    }
    
}
