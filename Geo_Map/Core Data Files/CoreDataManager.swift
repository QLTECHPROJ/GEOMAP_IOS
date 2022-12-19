//
//  CoreDataManager.swift


import Foundation
@_exported import CoreData


class CoreDataManager : NSObject{
    
    var context : NSManagedObjectContext{
        
        persistentContainer.viewContext
    }
    
    
    static let shared : CoreDataManager = CoreDataManager()
    
    override init() {
        
    }
    
   
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Geo_Map")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//MARK: - In Local Databse, variable for checking either data are exist or not
extension CoreDataManager {
    
    // Check SampleCollected data is empty or not
    
    var isEmptyGeologistData: Bool {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GeologistDataTable")
            let count  = try  CoreDataManager.shared.context.count(for: request)
            return count == 0
        } catch {
            return true
        }
    }
    
    // Check SampleCollected data is empty or not
    
    var isEmptyCollectedData: Bool {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SampleCollected")
            let count  = try  CoreDataManager.shared.context.count(for: request)
            return count == 0
        } catch {
            return true
        }
    }
    
    // Check WeatheringData is empty or not
    
    var isEmptyWeatheringData: Bool {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatheringData")
            let count  = try  CoreDataManager.shared.context.count(for: request)
            return count == 0
        } catch {
            return true
        }
    }
    
    // Check RockStrengthDataTable data is empty or not
    
    var isEmptyRockStrengthData: Bool {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RockStrengthDataTable")
            let count  = try  CoreDataManager.shared.context.count(for: request)
            return count == 0
        } catch {
            return true
        }
    }
    
    // Check WaterConditionDataTable data is empty or not
    
    var isEmptyWaterConditionData: Bool {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WaterConditionDataTable")
            let count  = try  CoreDataManager.shared.context.count(for: request)
            return count == 0
        } catch {
            return true
        }
    }
    
    // Check TypeOfGeologicalStructuresDataTable data is empty or not
    
    var isEmptyTypeOfGeologicalStructuresData: Bool {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TypeOfGeologicalStructuresDataTable")
            let count  = try  CoreDataManager.shared.context.count(for: request)
            return count == 0
        } catch {
            return true
        }
    }
    
    // Check TypeOfFaultsDataTable data is empty or not
    
    var isEmptyTypeOfFaultsData: Bool {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TypeOfFaultsDataTable")
            let count  = try  CoreDataManager.shared.context.count(for: request)
            return count == 0
        } catch {
            return true
        }
    }
    
    // Check AttributeDataTable data is empty or not
    
    var isEmptyAttributeDataTable: Bool {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AttributeDataTable")
            let count  = try  CoreDataManager.shared.context.count(for: request)
            return count == 0
        } catch {
            return true
        }
    }
}




//MARK: - Center function that insert data in all respective table for local Database
extension CoreDataManager {
    
    func insertAllTableData(_ allContentData : JSON){
        
        GeologistDataModel.shared.insertAllGeologistData(allContentData["Geologist"].arrayValue) { completion in
            if completion {}
        }
        
        SampleCollectedModel.shared.insertAllSampleCollectedData(allContentData["sampleCollected"].arrayValue) { completion in
            if completion {}
        }
        
        WeatheringDataModel.shared.insertAllWeatheringData(allContentData["weatheringData"].arrayValue) { completion in
            if completion {}
        }
        
        RockStrengthDataModel.shared.insertAllRockStrengthData(allContentData["rockStrength"].arrayValue) { completion in
            if completion {}
        }
        
        WaterConditionDataModel.shared.insertAllWaterConditionData(allContentData["waterCondition"].arrayValue) { completion in
            if completion {}
        }
        
        TypeOfFaultsDataModel.shared.insertAllTypeOfFaultsData(allContentData["typeOfFaults"].arrayValue) { completion in
            if completion {}
        }
        
        TypeOfGeologicalStructuresModel.shared.insertAllTypeOfGeologicalStructuresData(allContentData["typeOfGeologicalStructures"].arrayValue) { completion in
            if completion {}
        }
        
        AttributeDataModel.shared.insertAllAttributedDataInTable(allContentData["attributeData"].arrayValue) { completion in
            if completion {}
        }
    }
    
    func getAllListDataFromLocalDatabase(){
        
        SampleCollectedModel.shared.getSampleCollectedData { completion in
            if completion{}
        }
        
        WeatheringDataModel.shared.getWeatheringData { completion in
            if completion{}
        }
        
        RockStrengthDataModel.shared.getRockStrengthData { completion in
            if completion{}
        }
        
        WaterConditionDataModel.shared.getWaterConditionData { completion in
            if completion{}
        }
        
        TypeOfFaultsDataModel.shared.getTypeOfFaultData { completion in
            if completion{}
        }
        
        TypeOfGeologicalStructuresModel.shared.getTypeOfGeologicalStructuresData { completion in
            if completion{}
        }
        
        AttributeDataModel.shared.getAttributeTabledData { completion in
            if completion{}
        }
    }
}
