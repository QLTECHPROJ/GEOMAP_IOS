//
//  ContactUSVM.swift
//
//
//  Created by  on 09/11/22.
//

import Foundation
import UIKit

class ContactUSVM {    
    
    func callAPIContactUS(parameters : APIParametersModel,isLoader : Bool = false, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        debugPrint(parameters)
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.contact_insert((parameters.toDictionary())),isLoader : isLoader,showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
               
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,false)
            }
        }
    }
    
}

