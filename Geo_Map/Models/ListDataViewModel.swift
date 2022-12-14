//
//  ListDataViewModel.swift


import Foundation

class ListDataViewModel {

    
    func callItemListAPI(parameters : [String:Any], listType : ListItemType,isLoader : Bool = false, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        var apiRequest : APIRouter?
        
       
        switch listType {
            
        case .geologistName:
            
            apiRequest = APIRouter.geologist_data
            
            break
            
        case .attributes:
            
            apiRequest = APIRouter.attribute_data_number
            
            break
        case .Nos:

            break
        case .sampleCollected:
            
            apiRequest = APIRouter.sample_collecteds
            
            break
        case .weathering:
            
            apiRequest = APIRouter.weathering_data
            
            break
        case .rockStrenght:
            
            apiRequest = APIRouter.rock_strength_data
            
            break
            
        case .waterCollection:
            
            apiRequest = APIRouter.water_condition_data
            
            break
            
        case .typeOfGeologicalStructure:
            
            apiRequest = APIRouter.type_of_geological_structures
            
            break
            
        case .typeOfFaults:
            
            apiRequest = APIRouter.types_of_fault
            
            break
        }
        
        guard let apiRequest = apiRequest else {
            
            GFunctions.shared.showSnackBar(message: kAlertSomethingWentWrong)
            return
        }

        APIManager.shared.callAPIWithJSON(router: apiRequest,isLoader : isLoader,showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,false)
            }
        }
    }
    
}
