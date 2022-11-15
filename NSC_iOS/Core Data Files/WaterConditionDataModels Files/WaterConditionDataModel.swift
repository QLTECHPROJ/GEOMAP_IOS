//
//  WaterConditionDataModel.swift


import Foundation

class WaterConditionDataModel : NSObject{
    
    
    var arrWaterCondition : [WaterConditionDataTable] = []
    
    static let shared : WaterConditionDataModel = WaterConditionDataModel()
    
    override init() {
        
    }
    
    private func insertWaterConditionData(_ iD : String,_ name : String, _ createDate : String, _ updateDate : String){
        // Add
        let sampleCollected = WaterConditionDataTable(context: CoreDataManager.shared.context)
        sampleCollected.createDate = createDate
        sampleCollected.iD = Int64(iD)!
        sampleCollected.name = name
        sampleCollected.updateDate =  updateDate
        CoreDataManager.shared.saveContext()
    }
    
    
    func getWaterConditionData(_ completionBlock : (Bool)->Void?){
        
        let fetchRequest: NSFetchRequest<WaterConditionDataTable> = WaterConditionDataTable.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "iD", ascending: false)]
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.name)})
            
            self.arrWaterCondition = fetchUserData
            
            completionBlock(true)
                        
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    func deleteWaterConditionTableData(_ completionBlock : (Bool)->Void){
        
        self.getWaterConditionData { completion in
            
            for data in self.arrWaterCondition{
                let fetchRequest: NSFetchRequest<WaterConditionDataTable> = WaterConditionDataTable.fetchRequest()
                
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
    
    func insertAllWaterConditionData(_ waterConditiondata : [JSON], _ completionBlock : (Bool)->Void){

        if !CoreDataManager.shared.isEmptyWaterConditionData{
            
            WaterConditionDataModel.shared.deleteWaterConditionTableData { completion in
                
                for insertData in waterConditiondata{
                    
                    WaterConditionDataModel.shared.insertWaterConditionData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
                }
            }
        }
        else{
            for insertData in waterConditiondata{
                
                WaterConditionDataModel.shared.insertWaterConditionData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
            }
        }
        
        WaterConditionDataModel.shared.getWaterConditionData { completionBlock in
            if completionBlock{
               
            }
        }
        completionBlock(true)
    }
}



