//
//  WaterConditionDataTable+CoreDataProperties.swift


import Foundation



extension WaterConditionDataTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WaterConditionDataTable> {
        return NSFetchRequest<WaterConditionDataTable>(entityName: "WaterConditionDataTable")
    }

    @NSManaged public var updateDate: String?
    @NSManaged public var name: String?
    @NSManaged public var iD: Int64
    @NSManaged public var createDate: String?

}

extension WaterConditionDataTable : Identifiable {

}
