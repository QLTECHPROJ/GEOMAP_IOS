//
//  RockStrengthDataModel.swift


import Foundation

class RockStrengthDataModel : NSObject{
    
    
    var arrRockStrenght : [RockStrengthDataTable] = []
    
    static let shared : RockStrengthDataModel = RockStrengthDataModel()
    
    override init() {
        
    }
    
    
    
    private func insertRockStrengthData(_ iD : String,_ name : String, _ createDate : String, _ updateDate : String){
        // Add
        let sampleCollected = RockStrengthDataTable(context: CoreDataManager.shared.context)
        sampleCollected.createDate = createDate
        sampleCollected.iD = Int64(iD)!
        sampleCollected.name = name
        sampleCollected.updateDate =  updateDate
        CoreDataManager.shared.saveContext()
    }
    
    
    func getRockStrengthData(_ completionBlock : (Bool)->Void?){
        
        let fetchRequest: NSFetchRequest<RockStrengthDataTable> = RockStrengthDataTable.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "iD", ascending: false)]
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.name)})
            
            self.arrRockStrenght = fetchUserData
            
            completionBlock(true)
                        
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    func deleteRockStrengthRockStrengthTableData(_ completionBlock : (Bool)->Void){
        
        self.getRockStrengthData { completion in
            
            for data in self.arrRockStrenght{
                let fetchRequest: NSFetchRequest<RockStrengthDataTable> = RockStrengthDataTable.fetchRequest()
                
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
    
    func insertAllRockStrengthData(_ rockStrengthData : [JSON], _ completionBlock : (Bool)->Void){

        if !CoreDataManager.shared.isEmptyRockStrengthData{
            
            RockStrengthDataModel.shared.deleteRockStrengthRockStrengthTableData { completion in
                
                for insertData in rockStrengthData{
                    
                    RockStrengthDataModel.shared.insertRockStrengthData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
                }
            }
        }
        else{
            for insertData in rockStrengthData{
                
                RockStrengthDataModel.shared.insertRockStrengthData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
            }
        }
        RockStrengthDataModel.shared.getRockStrengthData { completionBlock in
            if completionBlock{
               
            }
        }
        completionBlock(true)
    }
}



