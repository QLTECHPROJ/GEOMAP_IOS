//
//  TypeOfFaultsDataModel.swift


import Foundation

class TypeOfFaultsDataModel : NSObject{
    
    
    var arrTypeOfFault : [TypeOfFaultsDataTable] = []
    
    static let shared : TypeOfFaultsDataModel = TypeOfFaultsDataModel()
    
    override init() {
        
    }
    
    private func insertTypeOfFaultData(_ iD : String,_ name : String, _ createDate : String, _ updateDate : String){
        // Add
        let sampleCollected = TypeOfFaultsDataTable(context: CoreDataManager.shared.context)
        sampleCollected.createDate = createDate
        sampleCollected.iD = Int64(iD)!
        sampleCollected.name = name
        sampleCollected.updateDate =  updateDate
        CoreDataManager.shared.saveContext()
    }
    
    
    func getTypeOfFaultData(_ completionBlock : (Bool)->Void?){
        
        let fetchRequest: NSFetchRequest<TypeOfFaultsDataTable> = TypeOfFaultsDataTable.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "iD", ascending: false)]
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.name)})
            
            self.arrTypeOfFault = fetchUserData
            
            completionBlock(true)
                        
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    func deleteTypeOfFaultsTableData(_ completionBlock : (Bool)->Void){
        
        self.getTypeOfFaultData { completion in
            
            for data in self.arrTypeOfFault{
                let fetchRequest: NSFetchRequest<TypeOfFaultsDataTable> = TypeOfFaultsDataTable.fetchRequest()
                
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
    
    func insertAllTypeOfFaultsData(_ typeOfFault : [JSON], _ completionBlock : (Bool)->Void){

        if !CoreDataManager.shared.isEmptyTypeOfFaultsData{
            
            TypeOfFaultsDataModel.shared.deleteTypeOfFaultsTableData { completion in
                
                for insertData in typeOfFault{
                    
                    TypeOfFaultsDataModel.shared.insertTypeOfFaultData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
                }
            }
        }
        else{
            for insertData in typeOfFault{
                
                TypeOfFaultsDataModel.shared.insertTypeOfFaultData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
            }
        }
        TypeOfFaultsDataModel.shared.getTypeOfFaultData { completionBlock in
            if completionBlock{
               
            }
        }
        completionBlock(true)
    }
}



