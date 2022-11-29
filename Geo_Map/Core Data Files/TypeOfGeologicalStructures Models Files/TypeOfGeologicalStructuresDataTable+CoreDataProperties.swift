//
//  TypeOfGeologicalStructuresDataTable+CoreDataProperties.swift


import Foundation



extension TypeOfGeologicalStructuresDataTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TypeOfGeologicalStructuresDataTable> {
        return NSFetchRequest<TypeOfGeologicalStructuresDataTable>(entityName: "TypeOfGeologicalStructuresDataTable")
    }

    @NSManaged public var createDate: String?
    @NSManaged public var iD: Int64
    @NSManaged public var name: String?
    @NSManaged public var updateDate: String?

}
