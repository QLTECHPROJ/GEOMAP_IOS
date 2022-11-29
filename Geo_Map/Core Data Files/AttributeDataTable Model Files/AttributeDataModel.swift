//
//  AttributeDataModel.swift



import Foundation

extension NSSet {
    func toArray<T>() -> [T] {
        let array = self.map({ $0 as! T})
        return array
    }
}

extension Optional where Wrapped == NSSet {
    func array<T: Hashable>(of: T.Type) -> [T] {
        if let set = self as? Set<T> {
            return Array(set)
        }
        return [T]()
    }
}
class AttributeDataModel : NSObject{
    
    
    var arrAttributeData : [AttributeDataTable] = []
    
    static let shared : AttributeDataModel = AttributeDataModel()
    
    override init() {
        
    }
    
    
    
    private func insertAttributeData(_ attributedData : JSON){
        // Add
        let attributesData = AttributeDataTable(context: CoreDataManager.shared.context)
        attributesData.iD = Int64(attributedData["id"].stringValue)!
        attributesData.name = attributedData["name"].stringValue
        attributesData.updateDate =  attributedData["updated_at"].stringValue
        attributesData.createDate = attributedData["created_at"].stringValue
        
        for nosData in attributedData["nos"].arrayValue{
            let nosAttribute = Nos(context: CoreDataManager.shared.context)
            nosAttribute.iD = Int64(nosData["id"].stringValue)!
            nosAttribute.name = nosData["name"].stringValue
            nosAttribute.attributeId = Int64(nosData["attributeId"].stringValue)!
            nosAttribute.createDate = nosData["created_at"].stringValue
            nosAttribute.updateDate = nosData["updated_at"].stringValue
            attributesData.addToNos(nosAttribute)
        }
        CoreDataManager.shared.saveContext()
    }
    
    func getAttributeTabledData(_ completionBlock : (Bool)->Void?){
        
        let fetchRequest: NSFetchRequest<AttributeDataTable> = AttributeDataTable.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "iD", ascending: false)]
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.name)})
            
            self.arrAttributeData = fetchUserData
            
            completionBlock(true)
                        
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    private func deleteAttributeTableData(_ completionBlock : (Bool)->Void){
        
        self.getAttributeTabledData { completion in
            
            for data in self.arrAttributeData{
                let fetchRequest: NSFetchRequest<AttributeDataTable> = AttributeDataTable.fetchRequest()
                
                fetchRequest.predicate = NSPredicate(format: "iD = %@", "\(data.iD)")
                
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
                
                do {
                
                    try CoreDataManager.shared.context.execute(deleteRequest)
                    CoreDataManager.shared.saveContext()
                    
                } catch(let error) {
                    debugPrint("Error in fetch data : ", error.localizedDescription)
                    
                }
            }
            
            completionBlock(true)
        }
    }
    
    func insertAllAttributedDataInTable(_ sampleData : [JSON], _ completionBlock : (Bool)->Void){

        if !CoreDataManager.shared.isEmptyAttributeDataTable{
            
            AttributeDataModel.shared.deleteAttributeTableData { completion in
                
                for insertData in sampleData{
                    
                    AttributeDataModel.shared.insertAttributeData(insertData)
                }
            }
        }
        else{
            for insertData in sampleData{
                
                AttributeDataModel.shared.insertAttributeData(insertData)
            }
        }
        AttributeDataModel.shared.getAttributeTabledData { completionBlock in
            if completionBlock{
               
            }
        }
        completionBlock(true)
    }
}



