//
//  OpenCastMappingReportListDraftVM.swift
//  NSC_iOS
//
//  Created by vishal parmar on 18/11/22.
//

import Foundation
import UIKit

class OpenCastMappingReportListDraftVM {

    private var arrOpenCastMappingReportDraft : [OpenCastMappingReportDataTable] = []
    
    
    func getOpenCastMappingReportList(with completionBlock : (Bool)->Void){
        OpenCastMappingReportDataModel.shared.getOpenCastMappingReportData { completion in
            if completion{
                self.arrOpenCastMappingReportDraft = OpenCastMappingReportDataModel.shared.arrOpenCastMappingReportData
            }
        }
        completionBlock(true)
    }
    
    func deleteOpenCastMappingReportDataFromTable(_ id : String, _ completionBlock : (Bool)->Void){
        OpenCastMappingReportDataModel.shared.deleteOpenCastMappingReportData(id){ completion in
            
            completionBlock(completion)
        }
    }
}

//------------------------------------------------------------------------------------------------
//MARK: - UITableview Methods
//------------------------------------------------------------------------------------------------
extension OpenCastMappingReportListDraftVM{
    
    func numberOfRowsInSectionInTableviewList(_ section : Int)-> Int{
        self.arrOpenCastMappingReportDraft.count
    }
    
    func cellForRowAtInTableviewList(_ indexPath : IndexPath)->OpenCastMappingReportDataTable{
        self.arrOpenCastMappingReportDraft[indexPath.row]
    }
}

