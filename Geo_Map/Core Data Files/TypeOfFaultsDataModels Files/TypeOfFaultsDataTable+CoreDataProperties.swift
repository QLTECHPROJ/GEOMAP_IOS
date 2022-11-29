//
//  TypeOfFaultsDataTable+CoreDataProperties.swift


import Foundation
import CoreData


extension TypeOfFaultsDataTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TypeOfFaultsDataTable> {
        return NSFetchRequest<TypeOfFaultsDataTable>(entityName: "TypeOfFaultsDataTable")
    }

    @NSManaged public var iD: Int64
    @NSManaged public var name: String?
    @NSManaged public var createDate: String?
    @NSManaged public var updateDate: String?

}
