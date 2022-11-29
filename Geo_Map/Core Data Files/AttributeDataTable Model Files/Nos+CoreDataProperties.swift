//
//  Nos+CoreDataProperties.swift


import Foundation


extension Nos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nos> {
        return NSFetchRequest<Nos>(entityName: "Nos")
    }

    @NSManaged public var iD: Int64
    @NSManaged public var name: String?
    @NSManaged public var attributeId: Int64
    @NSManaged public var createDate: String?
    @NSManaged public var updateDate: String?
    @NSManaged public var attributedData: AttributeDataTable?

}
