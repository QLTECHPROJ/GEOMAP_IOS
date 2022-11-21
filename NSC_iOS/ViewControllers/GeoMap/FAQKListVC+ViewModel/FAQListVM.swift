//
//  FAQListVM.swift
//
//
//  Created by  on 10/11/22.
//

import Foundation
 


class FAQListVM {

    private var arrFAQList : [JSON] = []
    
    
    func callAPIFAQList(isLoader : Bool = true, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        guard checkInternet(true) else {return completionBlock(nil,nil,kNoInternetConnection,false)}
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.faq_data,isLoader : isLoader, showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
                
                
                self.arrFAQList = receivdeData["ResponseData"].arrayValue.compactMap({ obj -> JSON in
                    var tempObj = obj
                    tempObj["isOpen"].boolValue = false
                    return tempObj
                })
                
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,false)
            }
        }
    }
}


/* Methods represent data for FAQ list*/

extension FAQListVM{
    
    func numberOfRowsInSectionInTableviewList(_ section : Int) -> Int{
        self.arrFAQList.count
    }
    
    func cellForRowAtInTableviewList(_ indexpath : IndexPath) -> JSON {
        self.arrFAQList[indexpath.row]
    }
}

/* Methods Help to expand FAQ*/
extension FAQListVM{
    
    func didExpandAnswer(_ indexPath : IndexPath, completionBlock : (Bool)->Void){
        self.arrFAQList[indexPath.row]["isOpen"].boolValue = !self.arrFAQList[indexPath.row]["isOpen"].boolValue
        completionBlock(self.arrFAQList[indexPath.row]["isOpen"].boolValue)
    }
}
