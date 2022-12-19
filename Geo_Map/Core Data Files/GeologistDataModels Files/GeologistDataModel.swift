//
//  GeologistDataModel.swift


import Foundation


class GeologistDataModel : NSObject{
    
    
    var arrGeologistData : [GeologistDataTable] = []
    
    static let shared : GeologistDataModel = GeologistDataModel()
    
    override init() {
        
    }

    private func insertGeologistData(_ iD : String,_ name : String, _ companyType : String, _ email : String, _ position : String, _ password : String, _ phone : String){
        // Add
        let tableData = GeologistDataTable(context: CoreDataManager.shared.context)
        tableData.iD = Int64(iD)!
        tableData.company_type = companyType
        tableData.name = name
        tableData.email =  email
        tableData.position =  position
        tableData.password =  password
        tableData.phone = phone
        
        CoreDataManager.shared.saveContext()
    }

    
    func getGeologistData(_ completionBlock : (Bool)->Void?){
        
        let fetchRequest: NSFetchRequest<GeologistDataTable> = GeologistDataTable.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "iD", ascending: false)]
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.name)})
            
            self.arrGeologistData = fetchUserData
            
            completionBlock(true)
                        
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    private func deleteGeologistData(_ completionBlock : (Bool)->Void){
        
        self.getGeologistData{ completion in
            
            for data in self.arrGeologistData{
                let fetchRequest: NSFetchRequest<GeologistDataTable> = GeologistDataTable.fetchRequest()
                
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
    
    func insertAllGeologistData(_ data : [JSON], _ completionBlock : (Bool)->Void){

        if !CoreDataManager.shared.isEmptyGeologistData{
            GeologistDataModel.shared.deleteGeologistData { completion in
                for insertData in data{
                    GeologistDataModel.shared.insertGeologistData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["company_type"].stringValue, insertData["email"].stringValue, insertData["position"].stringValue, insertData["password"].stringValue, insertData["phone"].stringValue)
                }
            }
        }
        else{
            for insertData in data{
                GeologistDataModel.shared.insertGeologistData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["company_type"].stringValue, insertData["email"].stringValue, insertData["position"].stringValue, insertData["password"].stringValue, insertData["phone"].stringValue)
            }
        }
        GeologistDataModel.shared.getGeologistData{ completionBlock in
            if completionBlock{
               
            }
        }
        completionBlock(true)
    }
}
