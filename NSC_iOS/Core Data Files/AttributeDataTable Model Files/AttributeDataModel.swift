//
//  AttributeDataModel.swift



import Foundation

class AttributeDataModel : NSObject{
    
    
    var arrAttributeData : [AttributeDataTable] = []
    
    static let shared : AttributeDataModel = AttributeDataModel()
    
    override init() {
        
    }
    
    
    
    private func insertAttributeData(_ iD : String,_ name : String, _ createDate : String, _ updateDate : String){
        // Add
        let attributesData = AttributeDataTable(context: CoreDataManager.shared.context)
        attributesData.createDate = createDate
        attributesData.iD = Int64(iD)!
        attributesData.name = name
        attributesData.updateDate =  updateDate
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
    
    func deleteAttributeTableData(_ completionBlock : (Bool)->Void){
        
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
                    
                    AttributeDataModel.shared.insertAttributeData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
                }
            }
        }
        else{
            for insertData in sampleData{
                
                AttributeDataModel.shared.insertAttributeData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
            }
        }
        AttributeDataModel.shared.getAttributeTabledData { completionBlock in
            if completionBlock{
               
            }
        }
        completionBlock(true)
    }
}



