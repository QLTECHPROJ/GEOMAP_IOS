//
//  OpenCastMappingReportDataModel.swift


import Foundation
import UIKit


class OpenCastMappingReportDataModel : NSObject{
    
    
    var arrOpenCastMappingReportData : [OpenCastMappingReportDataTable] = []
    
    static let shared : OpenCastMappingReportDataModel = OpenCastMappingReportDataModel()
    
    override init() {
        
    }
    
    func insertOpenCastMappingReportData(_ userId : String,
                                            _ iD : String,
                                            _ ocDate : String,
                                            _ mappingSheetNo : String,
                                            _ minesSiteName: String,
                                            _ pitName: String,
                                            _ pitLocation: String,
                                            _ shiftInChargeName: String,
                                            _ geologistName: String,
                                            _ shift: String,
                                            _ faceLocation: String,
                                            _ faceLength: String,
                                            _ faceArea: String,
                                            _ faceRockTypes: String,
                                            _ benchRL: String,
                                            _ benchHeightWidth: String,
                                            _ benchAngle: String,
                                            _ dipdirectionandAngle: String,
                                            _ thicknessOfOre: String,
                                            _ thicknessOfOverburden :String,
                                            _ thicknessOfInterBurden :String,
                                            _ observedGradeOfOre :String,
                                            _ sampleCollected :String,
                                            _ actualGradOfOre:String,
                                            _ weathering :String,
                                            _ rockStrength :String,
                                            _ waterCondition :String,
                                            _ typeOfGeologicalStructures :String,
                                            _ typeOfFaults :String,
                                            _ notes : String,
                                            _ geologistSign :UIImage,
                                            _ clientsGeologistSign :UIImage,
                                            _ imageDraw : UIImage,
                                            _ completionBlock : (Bool)->Void?){
        // Add
        let tableViewAttributes = OpenCastMappingReportDataTable(context: CoreDataManager.shared.context)
        
        tableViewAttributes.userId = userId
        tableViewAttributes.iD = Int64(OpenCastMappingReportDataTable.nextAvailble())
        tableViewAttributes.ocDate = ocDate
        tableViewAttributes.mappingSheetNo = mappingSheetNo
        tableViewAttributes.minesSiteName = minesSiteName
        tableViewAttributes.pitName = pitName
        tableViewAttributes.pitLocation = pitLocation
        tableViewAttributes.shiftInChargeName = shiftInChargeName
        tableViewAttributes.geologistName = geologistName
        tableViewAttributes.shift = shift
        tableViewAttributes.faceLocation = faceLocation
        tableViewAttributes.faceLength = faceLength
        tableViewAttributes.faceArea = faceArea
        tableViewAttributes.faceRockTypes = faceRockTypes
        tableViewAttributes.benchRL = benchRL
        tableViewAttributes.benchHeightWidth = benchHeightWidth
        tableViewAttributes.benchAngle = benchAngle
        tableViewAttributes.dipdirectionandAngle = dipdirectionandAngle
        tableViewAttributes.thicknessOfOre = thicknessOfOre
        tableViewAttributes.thicknessOfOverburden = thicknessOfOverburden
        tableViewAttributes.thicknessOfInterBurden = thicknessOfInterBurden
        tableViewAttributes.observedGradeOfOre = observedGradeOfOre
        tableViewAttributes.sampleCollected = sampleCollected
        tableViewAttributes.actualGradOfOre = actualGradOfOre
        tableViewAttributes.weathering = weathering
        tableViewAttributes.rockStrength = rockStrength
        tableViewAttributes.waterCondition = waterCondition
        tableViewAttributes.typeOfGeologicalStructures = typeOfGeologicalStructures
        tableViewAttributes.typeOfFaults = typeOfFaults
        tableViewAttributes.notes = notes
        tableViewAttributes.geologistSign = geologistSign.jpegData(compressionQuality: 0.5)
        tableViewAttributes.clientsGeologistSign = clientsGeologistSign.jpegData(compressionQuality: 0.5)
        tableViewAttributes.imagedrawn = imageDraw.jpegData(compressionQuality: 0.5)
        CoreDataManager.shared.saveContext()
        completionBlock(true)
    }
    
    func getOpenCastMappingReportData(_ completionBlock : (Bool)->Void?){
        
        let fetchRequest: NSFetchRequest<OpenCastMappingReportDataTable> = OpenCastMappingReportDataTable.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "iD", ascending: false)]
        
        
        do {
            let fetchUserData = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            fetchUserData.forEach({print($0.mappingSheetNo)})
            
            self.arrOpenCastMappingReportData = fetchUserData.filter{$0.userId == JSON(UserModelClass.current.userId as Any).stringValue}
            
            completionBlock(true)
                        
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    func deleteOpenCastMappingReportData(_ iD : String, _ completionBlock : (Bool)->Void){
        let fetchRequest: NSFetchRequest<OpenCastMappingReportDataTable> = OpenCastMappingReportDataTable.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "mappingSheetNo = %@", "\(iD)")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
        
            try CoreDataManager.shared.context.execute(deleteRequest)
            CoreDataManager.shared.saveContext()
            
            if let data = self.arrOpenCastMappingReportData.filter({$0.mappingSheetNo == iD}).first, let indexOfReportData = self.arrOpenCastMappingReportData.firstIndex(of: data){
                self.arrOpenCastMappingReportData.remove(at: indexOfReportData)
            }
            
            completionBlock(true)
            
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
            completionBlock(false)
        }
    }
    
    
    
    func editOpenCastMappingReportData(_ userId : String,
                                       _ iD : String,
                                       _ ocDate : String,
                                       _ mappingSheetNo : String,
                                       _ minesSiteName: String,
                                       _ pitName: String,
                                       _ pitLocation: String,
                                       _ shiftInChargeName: String,
                                       _ geologistName: String,
                                       _ shift: String,
                                       _ faceLocation: String,
                                       _ faceLength: String,
                                       _ faceArea: String,
                                       _ faceRockTypes: String,
                                       _ benchRL: String,
                                       _ benchHeightWidth: String,
                                       _ benchAngle: String,
                                       _ dipdirectionandAngle: String,
                                       _ thicknessOfOre: String,
                                       _ thicknessOfOverburden :String,
                                       _ thicknessOfInterBurden :String,
                                       _ observedGradeOfOre :String,
                                       _ sampleCollected :String,
                                       _ actualGradOfOre:String,
                                       _ weathering :String,
                                       _ rockStrength :String,
                                       _ waterCondition :String,
                                       _ typeOfGeologicalStructures :String,
                                       _ typeOfFaults :String,
                                       _ notes : String,
                                       _ geologistSign :UIImage,
                                       _ clientsGeologistSign :UIImage,
                                       _ imageDraw : UIImage,
                                       _ completionBlock : (Bool)->Void?){
        // Edit
        
        
        let fetchRequest: NSFetchRequest<OpenCastMappingReportDataTable> = OpenCastMappingReportDataTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "iD = %@", "\(iD)")
        
        
        do {
            let fetchOCReportData = try CoreDataManager.shared.context.fetch(fetchRequest)
        
            // Edit
            
            fetchOCReportData[0].userId = userId
            fetchOCReportData[0].iD = Int64(iD)!
            fetchOCReportData[0].ocDate = ocDate
            fetchOCReportData[0].mappingSheetNo = mappingSheetNo
            fetchOCReportData[0].minesSiteName = minesSiteName
            fetchOCReportData[0].pitName = pitName
            fetchOCReportData[0].pitLocation = pitLocation
            fetchOCReportData[0].shiftInChargeName = shiftInChargeName
            fetchOCReportData[0].geologistName = geologistName
            fetchOCReportData[0].shift = shift
            fetchOCReportData[0].faceLocation = faceLocation
            fetchOCReportData[0].faceLength = faceLength
            fetchOCReportData[0].faceArea = faceArea
            fetchOCReportData[0].faceRockTypes = faceRockTypes
            fetchOCReportData[0].benchRL = benchRL
            fetchOCReportData[0].benchHeightWidth = benchHeightWidth
            fetchOCReportData[0].benchAngle = benchAngle
            fetchOCReportData[0].dipdirectionandAngle = dipdirectionandAngle
            fetchOCReportData[0].thicknessOfOre = thicknessOfOre
            fetchOCReportData[0].thicknessOfOverburden = thicknessOfOverburden
            fetchOCReportData[0].thicknessOfInterBurden = thicknessOfInterBurden
            fetchOCReportData[0].observedGradeOfOre = observedGradeOfOre
            fetchOCReportData[0].sampleCollected = sampleCollected
            fetchOCReportData[0].actualGradOfOre = actualGradOfOre
            fetchOCReportData[0].weathering = weathering
            fetchOCReportData[0].rockStrength = rockStrength
            fetchOCReportData[0].waterCondition = waterCondition
            fetchOCReportData[0].typeOfGeologicalStructures = typeOfGeologicalStructures
            fetchOCReportData[0].typeOfFaults = typeOfFaults
            fetchOCReportData[0].notes = notes
            fetchOCReportData[0].geologistSign = geologistSign.jpegData(compressionQuality: 0.5)
            fetchOCReportData[0].clientsGeologistSign = clientsGeologistSign.jpegData(compressionQuality: 0.5)
            fetchOCReportData[0].imagedrawn = imageDraw.jpegData(compressionQuality: 0.5)
            
            CoreDataManager.shared.saveContext()
        
            completionBlock(true)
            
        } catch(let error) {
            debugPrint("Error in fetch data : ", error.localizedDescription)
        }
    }
}



