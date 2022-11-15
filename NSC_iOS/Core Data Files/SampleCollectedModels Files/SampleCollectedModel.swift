//
//  SampleCollectedModel.swift


import Foundation

class SampleCollectedModel : NSObject{
    
    
    var arrSampleCollected : [SampleCollected] = []
    
    static let shared : SampleCollectedModel = SampleCollectedModel()
    
    override init() {
        
    }
    

    private func insertSampleCollectedData(_ iD : String,_ name : String, _ createDate : String, _ updateDate : String){
        // Add
        let sampleCollected = SampleCollected(context: CoreDataManager.shared.context)
        sampleCollected.createDate = createDate
        sampleCollected.iD = Int64(iD)!
        sampleCollected.name = name
        sampleCollected.updateDate =  updateDate
        CoreDataManager.shared.saveContext()
    }
    
//    func fetchRequestSampleCollectedData(_ iD : String,_ name : String, _ createDate : String, _ updateDate : String){
//
//        // Add
//        let fetchRequest: NSFetchRequest<SampleCollected> = SampleCollected.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "iD = %@", "\(iD)")
//
//        do {
//            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
//
//            fetchUserData.forEach({print($0.name)})
//
//            // Edit
//
//            fetchUserData[0].createDate = createDate
//            fetchUserData[0].iD = Int64(iD)!
//            fetchUserData[0].name = name
//            fetchUserData[0].updateDate =  updateDate
//            CoreDataManager.shared.saveContext()
//
//        } catch(let error) {
//            debugPrint("Error in fetch data : ", error.localizedDescription)
//        }
//    }
    
   private func getSampleCollectedData(_ completionBlock : (Bool)->Void?){
        
        let fetchRequest: NSFetchRequest<SampleCollected> = SampleCollected.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "iD", ascending: false)]
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.name)})
            
            self.arrSampleCollected = fetchUserData
            
            completionBlock(true)
                        
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    private func deleteSampleColledtedData(_ completionBlock : (Bool)->Void){
        
        self.getSampleCollectedData { completion in
            
            for data in self.arrSampleCollected{
                let fetchRequest: NSFetchRequest<SampleCollected> = SampleCollected.fetchRequest()
                
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
    
    func insertAllSampleCollectedData(_ sampleData : [JSON], _ completionBlock : (Bool)->Void){

        if !CoreDataManager.shared.isEmptyCollectedData{
            SampleCollectedModel.shared.deleteSampleColledtedData { completion in
                for insertData in sampleData{
                    SampleCollectedModel.shared.insertSampleCollectedData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
                }
            }
        }
        else{
            for insertData in sampleData{
                SampleCollectedModel.shared.insertSampleCollectedData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
            }
        }
        SampleCollectedModel.shared.getSampleCollectedData { completionBlock in
            if completionBlock{
               
            }
        }
        completionBlock(true)
    }
}



