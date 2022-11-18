//
//  UnderGroundMappingReportListDraftVM.swift


import Foundation

class UnderGroundMappingReportListDraftVM {

    private var arrUnderGroundDraftReportList : [UnderGroundMappingReportDataTable] = []
    
    
    func getUnderGroundMappingReportList(with completionBlock : (Bool)->Void){
        UnderGroundMappingReportDataModel.shared.getUndergroundMappingReportData { completion in
            if completion{
                self.arrUnderGroundDraftReportList = UnderGroundMappingReportDataModel.shared.arrUnderGroundMappingReportData
            }
        }
        completionBlock(true)
    }
    
    func deleteUnderGroundMappingReportDataFromTable(_ id : String, _ completionBlock : (Bool)->Void){
        UnderGroundMappingReportDataModel.shared.deleteUnderGroundMappingReportData(id){ completion in
            if completion{
                completionBlock(completion)
            }
        }
    }
}

//------------------------------------------------------------------------------------------------
//MARK: - UITableview Methods
//------------------------------------------------------------------------------------------------
extension UnderGroundMappingReportListDraftVM{
    
    func numberOfRowsInSectionInTableviewList(_ section : Int)-> Int{
        self.arrUnderGroundDraftReportList.count
    }
    
    func cellForRowAtInTableviewList(_ indexPath : IndexPath)->UnderGroundMappingReportDataTable{
        self.arrUnderGroundDraftReportList[indexPath.row]
    }
}

