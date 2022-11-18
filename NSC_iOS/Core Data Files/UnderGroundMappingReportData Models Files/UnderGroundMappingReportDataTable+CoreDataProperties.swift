//
//  UnderGroundMappingReportDataTable+CoreDataProperties.swift

import Foundation


extension UnderGroundMappingReportDataTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UnderGroundMappingReportDataTable> {
        return NSFetchRequest<UnderGroundMappingReportDataTable>(entityName: "UnderGroundMappingReportDataTable")
    }

    @NSManaged public var faceImage: Data?
    @NSManaged public var iD: Int64
    @NSManaged public var leftImage: Data?
    @NSManaged public var locations: String?
    @NSManaged public var mappedBy: String?
    @NSManaged public var mapSerialNo: String?
    @NSManaged public var rightImage: Data?
    @NSManaged public var roofImage: Data?
    @NSManaged public var scale: String?
    @NSManaged public var shift: String?
    @NSManaged public var ugDate: String?
    @NSManaged public var userId: Int64
    @NSManaged public var veinOrLoad: String?
    @NSManaged public var xCoordinate: String?
    @NSManaged public var yCoordinate: String?
    @NSManaged public var zCoordinate: String?
    @NSManaged public var attributeUndergroundMapping: NSSet?

}

// MARK: Generated accessors for attributeUndergroundMapping
extension UnderGroundMappingReportDataTable {

    @objc(addAttributeUndergroundMappingObject:)
    @NSManaged public func addToAttributeUndergroundMapping(_ value: AttributeUndergroundMappingTable)

    @objc(removeAttributeUndergroundMappingObject:)
    @NSManaged public func removeFromAttributeUndergroundMapping(_ value: AttributeUndergroundMappingTable)

    @objc(addAttributeUndergroundMapping:)
    @NSManaged public func addToAttributeUndergroundMapping(_ values: NSSet)

    @objc(removeAttributeUndergroundMapping:)
    @NSManaged public func removeFromAttributeUndergroundMapping(_ values: NSSet)

}
