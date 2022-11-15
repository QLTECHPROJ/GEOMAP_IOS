//
//  WeatheringDataModel.swift


import Foundation

class WeatheringDataModel : NSObject{
    
    
    var arrWeathering : [WeatheringData] = []
    
    static let shared : WeatheringDataModel = WeatheringDataModel()
    
    override init() {
        
    }
    
    
    
    private func insertWeatheringData(_ iD : String,_ name : String, _ createDate : String, _ updateDate : String){
        // Add
        let sampleCollected = WeatheringData(context: CoreDataManager.shared.context)
        sampleCollected.createDate = createDate
        sampleCollected.iD = Int64(iD)!
        sampleCollected.name = name
        sampleCollected.updateDate =  updateDate
        CoreDataManager.shared.saveContext()
    }
    
    func getWeatheringData(_ completionBlock : (Bool)->Void?){
        
        let fetchRequest: NSFetchRequest<WeatheringData> = WeatheringData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "iD", ascending: false)]
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.name)})
            
            self.arrWeathering = fetchUserData
            
            completionBlock(true)
                        
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    func deleteWeatheringData(_ completionBlock : (Bool)->Void){
        
        self.getWeatheringData { completion in
            
            for data in self.arrWeathering{
                let fetchRequest: NSFetchRequest<WeatheringData> = WeatheringData.fetchRequest()
                
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
    
    func insertAllWeatheringData(_ weatheringData : [JSON], _ completionBlock : (Bool)->Void){

        if !CoreDataManager.shared.isEmptyWeatheringData{
            
            WeatheringDataModel.shared.deleteWeatheringData { completion in
                
                for insertData in weatheringData{
                    
                    WeatheringDataModel.shared.insertWeatheringData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
                }
            }
        }
        else{
            for insertData in weatheringData{
                
                WeatheringDataModel.shared.insertWeatheringData(insertData["id"].stringValue, insertData["name"].stringValue, insertData["created_at"].stringValue, insertData["updated_at"].stringValue)
            }
        }
        WeatheringDataModel.shared.getWeatheringData { completionBlock in
            if completionBlock{
               
            }
        }
        completionBlock(true)
    }
}



