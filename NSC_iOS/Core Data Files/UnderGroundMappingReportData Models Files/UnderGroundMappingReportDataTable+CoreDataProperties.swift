//
//  UnderGroundMappingReportDataTable+CoreDataProperties.swift


import Foundation


extension UnderGroundMappingReportDataTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UnderGroundMappingReportDataTable> {
        return NSFetchRequest<UnderGroundMappingReportDataTable>(entityName: "UnderGroundMappingReportDataTable")
    }

    @NSManaged public var iD: Int64
    @NSManaged public var mapSerialNo: String?
    @NSManaged public var ugDate: String?
    @NSManaged public var shift: String?
    @NSManaged public var mappedBy: String?
    @NSManaged public var scale: String?
    @NSManaged public var locations: String?
    @NSManaged public var veinOrLoad: String?
    @NSManaged public var xCoordinate: String?
    @NSManaged public var yCoordinate: String?
    @NSManaged public var zCoordinate: String?
    @NSManaged public var waterCondition: String?
    @NSManaged public var comment: String?
    @NSManaged public var attributes: String?
    @NSManaged public var createDate: String?
    @NSManaged public var updateDate: String?

}
