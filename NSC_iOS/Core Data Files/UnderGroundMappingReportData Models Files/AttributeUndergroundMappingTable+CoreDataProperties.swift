//
//  AttributeUndergroundMappingTable+CoreDataProperties.swift


import Foundation



extension AttributeUndergroundMappingTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AttributeUndergroundMappingTable> {
        return NSFetchRequest<AttributeUndergroundMappingTable>(entityName: "AttributeUndergroundMappingTable")
    }

    @NSManaged public var name: String?
    @NSManaged public var nose: String?
    @NSManaged public var properties: String?
    @NSManaged public var undergroundMappingReport: UnderGroundMappingReportDataTable?

}
