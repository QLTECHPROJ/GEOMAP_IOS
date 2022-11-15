//
//  AttributeDataTable+CoreDataProperties.swift


import Foundation


extension AttributeDataTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AttributeDataTable> {
        return NSFetchRequest<AttributeDataTable>(entityName: "AttributeDataTable")
    }

    @NSManaged public var iD: Int64
    @NSManaged public var name: String?
    @NSManaged public var createDate: String?
    @NSManaged public var updateDate: String?

}
