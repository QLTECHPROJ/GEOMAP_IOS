//
//  UnderGroundMappingReportDataModel.swift



import Foundation


class UnderGroundMappingReportDataModel : NSObject{
    
    
    var arrUnderGroundMappingReportData : [UnderGroundMappingReportDataTable] = []
    
    static let shared : UnderGroundMappingReportDataModel = UnderGroundMappingReportDataModel()
    
    override init() {
        
    }
    
    func insertUnderGroundMappingReportData(_ iD : String,
                                            _ mapSerialNo : String,
                                            _ name : String,
                                            _ ugDate : String,
                                            _ shift : String,
                                            _ mappedBy : String,
                                            _ scale : String,
                                            _ locations : String,
                                            _ veinOrLoad : String,
                                            _ xCoordinate : String,
                                            _ yCoordinate : String,
                                            _ zCoordinate : String,
                                            _ attributes : [JSON],
                                            _ rootImage : UIImage,
                                            _ leftImage : UIImage,
                                            _ rightImage : UIImage,
                                            _ faceImage : UIImage,
                                            _ comment : String,
                                            _ completionBlock : (Bool)->Void?){
        // Add
        let tableViewAttributes = UnderGroundMappingReportDataTable(context: CoreDataManager.shared.context)
        
        tableViewAttributes.iD = Int64(UnderGroundMappingReportDataTable.nextAvailble())
        
        tableViewAttributes.mapSerialNo = mapSerialNo
        tableViewAttributes.name = name
        tableViewAttributes.comment = comment
        tableViewAttributes.ugDate = ugDate
        tableViewAttributes.shift = shift
        tableViewAttributes.mappedBy = mappedBy
        tableViewAttributes.scale = scale
        tableViewAttributes.locations = locations
        tableViewAttributes.veinOrLoad = veinOrLoad
        tableViewAttributes.xCoordinate = xCoordinate
        tableViewAttributes.yCoordinate = yCoordinate
        tableViewAttributes.zCoordinate = zCoordinate
        tableViewAttributes.roofImage = rootImage.jpegData(compressionQuality: 0.5)
        tableViewAttributes.leftImage = leftImage.jpegData(compressionQuality: 0.5)
        tableViewAttributes.rightImage = rightImage.jpegData(compressionQuality: 0.5)
        tableViewAttributes.faceImage = faceImage.jpegData(compressionQuality: 0.5)
   
        
        for attributesdata in attributes{
            let attributeObj = AttributeUndergroundMappingTable(context: CoreDataManager.shared.context)
            attributeObj.name = attributesdata["name"].stringValue
            attributeObj.nose = attributesdata["nose"].stringValue
            attributeObj.properties = attributesdata["properties"].stringValue
            tableViewAttributes.addToAttributeUndergroundMapping(attributeObj)
        }
        CoreDataManager.shared.saveContext()
        completionBlock(true)
        debugPrint("zdfsdf")
    }
    

    func getUndergroundMappingReportData(_ completionBlock : (Bool)->Void?){
        
        let fetchRequest: NSFetchRequest<UnderGroundMappingReportDataTable> = UnderGroundMappingReportDataTable.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "iD", ascending: false)]
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.mapSerialNo)})
            
            self.arrUnderGroundMappingReportData = fetchUserData
            
            completionBlock(true)
                        
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    
    
    func deleteUnderGroundMappingReportData(_ iD : String, _ completionBlock : (Bool)->Void){
        let fetchRequest: NSFetchRequest<UnderGroundMappingReportDataTable> = UnderGroundMappingReportDataTable.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "iD = %@", "\(iD)")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
        
            try CoreDataManager.shared.context.execute(deleteRequest)
            CoreDataManager.shared.saveContext()
            
            if let data = self.arrUnderGroundMappingReportData.filter({$0.iD == Int64(iD)}).first, let indexOfReportData = self.arrUnderGroundMappingReportData.firstIndex(of: data){
                self.arrUnderGroundMappingReportData.remove(at: indexOfReportData)
            }
            completionBlock(true)
            
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
}



