//
//  TypeOfGeologicalStructures Model.swift


import Foundation


class TypeOfGeologicalStructuresModel : NSObject{
    
    
    var arrTypeOfGeologicalStructures : [TypeOfGeologicalStructuresDataTable] = []
    
    static let shared : TypeOfGeologicalStructuresModel = TypeOfGeologicalStructuresModel()
    
    override init() {
        
    }
    
    private func insertTypeOfGeologicalStructuresData(_ iD : String,_ name : String, _ createDate : String, _ updateDate : String){
        // Add
        let sampleCollected = TypeOfGeologicalStructuresDataTable(context: CoreDataManager.shared.context)
        sampleCollected.createDate = createDate
        sampleCollected.iD = Int64(iD)!
        sampleCollected.name = name
        sampleCollected.updateDate =  updateDate
        CoreDataManager.shared.saveContext()
    }
    
    
    func getTypeOfGeologicalStructuresData(_ completionBlock : (Bool)->Void?){
        
        let fetchRequest: NSFetchRequest<TypeOfGeologicalStructuresDataTable> = TypeOfGeologicalStructuresDataTable.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "iD", ascending: false)]
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.name)})
            
            self.arrTypeOfGeologicalStructures = fetchUserData
            
            completionBlock(true)
                        
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    func deleteTypeOfGeologicalStructuresData(_ completionBlock : (Bool)->Void){
        
        self.getTypeOfGeologicalStructuresData { completion in
            
            for data in self.arrTypeOfGeologicalStructures{
                let fetchRequest: NSFetchRequest<TypeOfGeologicalStructuresDataTable> = TypeOfGeologicalStructuresDataTable.fetchRequest()
                
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
    
    func insertAllTypeOfGeologicalStructuresData(_ typeOfFault : [JSON], _ completionBlock : (Bool)->Void){

        if !CoreDataManager.shared.isEmptyTypeOfGeologicalStructuresData{
            
            TypeOfGeologicalStructuresModel.shared.deleteTypeOfGeologicalStructuresData { completion in
                
                for insertData in typeOfFault{
                    
                    TypeOfGeologicalStructuresModel.shared.insertTypeOfGeologicalStructuresData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
                }
            }
        }
        else{
            for insertData in typeOfFault{
                
                TypeOfGeologicalStructuresModel.shared.insertTypeOfGeologicalStructuresData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
            }
        }
        TypeOfGeologicalStructuresModel.shared.getTypeOfGeologicalStructuresData { completionBlock in
            if completionBlock{
               
            }
        }
        completionBlock(true)
    }
}



