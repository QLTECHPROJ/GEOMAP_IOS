//
//  ReportListVM.swift
//  NSC_iOS
//
//  Created by vishal parmar on 04/11/22.
//

import Foundation

class ReportListVM {

    private var arrReportHeader : [JSON] = []
    private var arrReportURORList : [JSON] = []
    
    func callHomeReportListAPI(parameters : [String:Any],isLoader : Bool = true, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        debugPrint(parameters)
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.ur_or_listing(parameters),isLoader : isLoader,showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
                
                self.arrReportHeader = [
                    [
                        "title" : kUndergroundsMappingReport,
                        "type" : ReportListType.underGroundReport.rawValue,
                        "data" : receivdeData["ResponseData"]["underGround"].arrayValue
                    ],
                    [
                        "title" : kOpenCastMappingReport,
                        "type" : ReportListType.opneCastReport.rawValue,
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
    
    
    func callReportListAPI(router : URLRequestConvertible, isLoader : Bool = true, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        APIManager.shared.callAPIWithJSON(router: router,isLoader : isLoader, showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
                
                self.arrReportURORList = receivdeData["ResponseData"].arrayValue
                
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
/* Methods represent data for home*/

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

/* Methods represent data for Underground Or OpenCast list*/

extension ReportListVM{
    
    func numberOfRowsInSectionInTableviewList(_ section : Int) -> Int{
        self.arrReportURORList.count
    }
    
    func cellForRowAtInTableviewList(_ indexpath : IndexPath) -> JSON {
        self.arrReportURORList[indexpath.row]
    }
}
