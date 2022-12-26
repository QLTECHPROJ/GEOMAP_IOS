//
//  UnderGroundMappingReportDataModel.swift



import Foundation


class UnderGroundMappingReportDataModel : NSObject{
    
    
    var arrUnderGroundMappingReportData : [UnderGroundMappingReportDataTable] = []
    
    static let shared : UnderGroundMappingReportDataModel = UnderGroundMappingReportDataModel()
    
    override init() {
        
    }
    
    func insertUnderGroundMappingReportData(_ userId : String,
//                                            _ iD : String,
//                                            _ mapSerialNo : String,
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
        
        tableViewAttributes.userId = userId
//        tableViewAttributes.iD = Int64(UnderGroundMappingReportDataTable.nextAvailble())
        tableViewAttributes.mapSerialNo = JSON(UnderGroundMappingReportDataTable.nextAvailble() as Any).stringValue
        tableViewAttributes.name = name
        tableViewAttributes.comment = comment
        tableViewAttributes.ugDate = ugDate
        tableViewAttributes.shift = shift
        tableViewAttributes.mappedBy = mappedBy
        tableViewAttributes.scale = scale
        tableViewAttributes.location = locations
        tableViewAttributes.veinOrLoad = veinOrLoad
        tableViewAttributes.xCoordinate = xCoordinate
        tableViewAttributes.yCoordinate = yCoordinate
        tableViewAttributes.zCoordinate = zCoordinate
        tableViewAttributes.roofImage = rootImage.jpegData(compressionQuality: 1)
        tableViewAttributes.leftImage = leftImage.jpegData(compressionQuality: 1)
        tableViewAttributes.rightImage = rightImage.jpegData(compressionQuality: 1)
        tableViewAttributes.faceImage = faceImage.jpegData(compressionQuality: 1)
        
        
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
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "mapSerialNo", ascending: false)]
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.mapSerialNo)})
            
            self.arrUnderGroundMappingReportData = fetchUserData.filter{$0.userId == JSON(UserModelClass.current.userId as Any).stringValue}
            
            completionBlock(true)
            
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    func deleteUnderGroundMappingReportData(_ iD : String, _ completionBlock : (Bool)->Void){
        let fetchRequest: NSFetchRequest<UnderGroundMappingReportDataTable> = UnderGroundMappingReportDataTable.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "mapSerialNo = %@", "\(iD)")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            
            
            try CoreDataManager.shared.context.execute(deleteRequest)
            CoreDataManager.shared.saveContext()
            
            if let data = self.arrUnderGroundMappingReportData.filter({$0.mapSerialNo == iD}).first, let indexOfReportData = self.arrUnderGroundMappingReportData.firstIndex(of: data){
                self.arrUnderGroundMappingReportData.remove(at: indexOfReportData)
            }
            completionBlock(true)
            
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    
    func editUnderGroundMappingReportData(_ userId : String,
//                                          _ iD : String,
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
        // Edit
        
        
        let fetchRequest: NSFetchRequest<UnderGroundMappingReportDataTable> = UnderGroundMappingReportDataTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mapSerialNo = %@", "\(mapSerialNo)")
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.name)})
            
            // Edit
            
            fetchUserData[0].userId = userId
//            fetchUserData[0].iD = Int64(iD)!
            fetchUserData[0].mapSerialNo = mapSerialNo
            fetchUserData[0].name = name
            fetchUserData[0].comment = comment
            fetchUserData[0].ugDate = ugDate
            fetchUserData[0].shift = shift
            fetchUserData[0].mappedBy = mappedBy
            fetchUserData[0].scale = scale
            fetchUserData[0].location = locations
            fetchUserData[0].veinOrLoad = veinOrLoad
            fetchUserData[0].xCoordinate = xCoordinate
            fetchUserData[0].yCoordinate = yCoordinate
            fetchUserData[0].zCoordinate = zCoordinate
            fetchUserData[0].roofImage = rootImage.jpegData(compressionQuality: 1)
            fetchUserData[0].leftImage = leftImage.jpegData(compressionQuality: 1)
            fetchUserData[0].rightImage = rightImage.jpegData(compressionQuality: 1)
            fetchUserData[0].faceImage = faceImage.jpegData(compressionQuality: 1)
//            fetchUserData[0].removeFromAttributeUndergroundMapping(fetchUserData[0].attributeUndergroundMapping!)
            
            
            if let array = fetchUserData[0].attributeUndergroundMapping,let nosArray = array.allObjects as? [AttributeUndergroundMappingTable]{
                for nosData in nosArray{
                    debugPrint(nosData)
                    //                            self.arrAttribute.append([
                    //                                "name" : JSON(nosData.name as Any).stringValue,
                    //                                "nose" : JSON(nosData.nose as Any).stringValue,
                    //                                "properties" : JSON(nosData.properties as Any).stringValue])
                    fetchUserData[0].removeFromAttributeUndergroundMapping(nosData)
                }
            }
            for attributesdata in attributes{
                let attributeObj = AttributeUndergroundMappingTable(context: CoreDataManager.shared.context)
                attributeObj.name = attributesdata["name"].stringValue
                attributeObj.nose = attributesdata["nose"].stringValue
                attributeObj.properties = attributesdata["properties"].stringValue
                fetchUserData[0].addToAttributeUndergroundMapping(attributeObj)
            }
            CoreDataManager.shared.saveContext()
            fetchUserData.forEach({print($0.name)})
            completionBlock(true)
            
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
        }
    }
}



