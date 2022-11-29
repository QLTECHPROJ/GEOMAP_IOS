//
//  UnderGroundMappingReportDataTable+CoreDataClass.swift

import Foundation


@objc(UnderGroundMappingReportDataTable)
public class UnderGroundMappingReportDataTable: NSManagedObject {

    static func nextAvailble(_ idKey: String = "iD") -> Int {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: self))
        fetchRequest.propertiesToFetch = [idKey]
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: idKey, ascending: true)]
        
        do {
            let results = try CoreDataManager.shared.context.fetch(fetchRequest)
            let lastObject = (results as? [NSManagedObject])?.last
            
            guard lastObject != nil else {
                return 1
            }
            
            return lastObject?.value(forKey: idKey) as! Int + 1
            
        } catch let error as NSError {
            debugPrint("error in \(self.classForCoder())", #function, " : ", error.localizedDescription)
        }
        
        return 1
    }
}
