//
//  ReportListVM.swift


import Foundation

class ReportListVM {

    private var arrReportHeader : [JSON] = []
    private var arrReportURORList : [JSON] = []
    
    func callHomeReportListAPI(parameters : [String:Any],isLoader : Bool = true, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        
        guard checkInternet(true) else {return completionBlock(nil,nil,nil,false)}
        debugPrint(parameters)
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.ur_or_listing(parameters),isLoader : isLoader,showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
                self.arrReportHeader = []
                if !receivdeData["ResponseData"]["underGround"].arrayValue.isEmpty{
                    
                    var arrData : [JSON] = []
                    for (i, innerdata) in receivdeData["ResponseData"]["underGround"].arrayValue.enumerated(){
                        if i < 2{
                            arrData.append(innerdata)
                        }
                    }
                    self.arrReportHeader.append([
                        "title" : kUndergroundsMappingReport,
                        "type" : ReportListType.underGroundReport.rawValue,
                        "data" : arrData
                    ])
                }
                
                if !receivdeData["ResponseData"]["openCast"].arrayValue.isEmpty{
                    
                    
                    var arrData : [JSON] = []
                    for (i, innerdata) in receivdeData["ResponseData"]["openCast"].arrayValue.enumerated(){
                        if i < 2{
                            arrData.append(innerdata)
                        }
                    }
                    self.arrReportHeader.append([
                        "title" : kOpenCastMappingReport,
                        "type" : ReportListType.openCastReport.rawValue,
                        "data" : arrData
                    ])
                    
                }
                
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,false)
            }
        }
    }
    
    
    func callReportListAPI(router : URLRequestConvertible, isLoader : Bool = true, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        guard checkInternet(true) else {return completionBlock(nil,nil,kNoInternetConnection,false)}
        
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
//MARK: - Helping methods
//---------------------------------------------------------------------------



extension ReportListVM{
    
    var isDataEmpty : Bool {
        return self.arrReportHeader.isEmpty
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
