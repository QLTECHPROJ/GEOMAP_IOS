//
//  UnderGroundMappingReportDataModel.swift



import Foundation


class UnderGroundMappingReportDataModel : NSObject{
    
    
    var arrUnderGroundMappingReportData : [UnderGroundMappingReportDataTable] = []
    
    static let shared : UnderGroundMappingReportDataModel = UnderGroundMappingReportDataModel()
    
    override init() {
        
    }
    
    private func insertUnderGroundMappingReportData(_ iD : String,
                                                    _ mapSerialNo : String,
                                                    _ ugDate : String,
                                                    _ shift : String,
                                                    _ mappedBy : String,
                                                    _ scale : String,
                                                    _ locations : String,
                                                    _ veinOrLoad : String,
                                                    _ xCoordinate : String,
                                                    _ yCoordinate : String,
                                                    _ zCoordinate : String,
                                                    _ waterCondition : String,
                                                    _ comment : String,
                                                    _ attributes : String,
                                                    _ createDate : String,
                                                    _ updateDate : String){
        // Add
        let tableViewAttributes = UnderGroundMappingReportDataTable(context: CoreDataManager.shared.context)
        
        tableViewAttributes.iD = Int64(UnderGroundMappingReportDataTable.nextAvailble())
        tableViewAttributes.mapSerialNo = mapSerialNo
        tableViewAttributes.ugDate = ugDate
        tableViewAttributes.shift = shift
        tableViewAttributes.mappedBy = mappedBy
        tableViewAttributes.scale = scale
        tableViewAttributes.locations = locations
        tableViewAttributes.veinOrLoad = veinOrLoad
        tableViewAttributes.xCoordinate = xCoordinate
        tableViewAttributes.yCoordinate = yCoordinate
        tableViewAttributes.zCoordinate = zCoordinate
        tableViewAttributes.waterCondition = waterCondition
        tableViewAttributes.comment = comment
        tableViewAttributes.attributes = attributes
        tableViewAttributes.createDate = createDate
        tableViewAttributes.updateDate = updateDate
        
        CoreDataManager.shared.saveContext()
    }
    
    
    func deleteUnderGroundMappingReportData(_ iD : String){
        let fetchRequest: NSFetchRequest<UnderGroundMappingReportDataTable> = UnderGroundMappingReportDataTable.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "iD = %@", "\(iD)")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
        
            try CoreDataManager.shared.context.execute(deleteRequest)
            CoreDataManager.shared.saveContext()
            
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            
        }
    }
}



