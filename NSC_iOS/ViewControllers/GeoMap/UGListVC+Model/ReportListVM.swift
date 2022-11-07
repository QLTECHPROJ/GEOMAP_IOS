//
//  ReportListVM.swift
//  NSC_iOS
//
//  Created by vishal parmar on 04/11/22.
//

import Foundation

class ReportListVM {
    
    
    private var arrReportHeader : [JSON] = []
   
    
    func callReportListAPI(parameters : [String:Any], completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        debugPrint(parameters)
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.ur_or_listing(parameters),showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
                
                self.arrReportHeader = [
                    [
                        "title" : kUndergroundsMappingReport,
                        "type" : ReportListType.underGroundReport,
                        "data" : receivdeData["ResponseData"]["underGround"].arrayValue
                    ],
                    [
                        "title" : kOpenCastMappingReport,
                        "type" : ReportListType.opneCastReport,
                        "data" : receivdeData["ResponseData"]["openCast"].arrayValue
                    ]
                ]
                
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,false)
            }
        }
    }
}


//---------------------------------------------------------------------------
//MARK: - UITableview data methods
//---------------------------------------------------------------------------
extension ReportListVM{
    
    func numberOfSectionsInTableview()-> Int{
        self.arrReportHeader.count
    }
    
    func viewForHeaderInSectionData(_ section : Int) -> JSON{
        self.arrReportHeader[section]
    }
    
    func numberOfRowsInSectionInTableview(_ section : Int) -> Int{
        self.arrReportHeader[section]["data"].count
    }
    
    func cellForRowAtInTableview(_ indexpath : IndexPath) -> JSON {
        self.arrReportHeader[indexpath.section]["data"][indexpath.row]
    }
}
