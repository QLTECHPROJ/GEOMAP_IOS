//
//  OpenCastMappingReportDataTable+CoreDataProperties.swift

import Foundation


extension OpenCastMappingReportDataTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OpenCastMappingReportDataTable> {
        return NSFetchRequest<OpenCastMappingReportDataTable>(entityName: "OpenCastMappingReportDataTable")
    }

    @NSManaged public var iD: Int64
    @NSManaged public var ocDate: String?
    @NSManaged public var mappingSheetNo: String?
    @NSManaged public var minesSiteName: String?
    @NSManaged public var pitName: String?
    @NSManaged public var pitLocation: String?
    @NSManaged public var shiftInChargeName: String?
    @NSManaged public var geologistName: String?
    @NSManaged public var shift: String?
    @NSManaged public var faceLocation: String?
    @NSManaged public var faceLength: String?
    @NSManaged public var faceArea: String?
    @NSManaged public var faceRockTypes: String?
    @NSManaged public var benchRL: String?
    @NSManaged public var benchHeightWidth: String?
    @NSManaged public var benchAngle: String?
    @NSManaged public var dipdirectionandAngle: String?
    @NSManaged public var thicknessOfOre: String?
    @NSManaged public var thicknessOfOverburden: String?
    @NSManaged public var thicknessOfInterBurden: String?
    @NSManaged public var observedGradeOfOre: String?
    @NSManaged public var sampleCollected: String?
    @NSManaged public var actualGradOfOre: String?
    @NSManaged public var weathering: String?
    @NSManaged public var rockStrength: String?
    @NSManaged public var waterCondition: String?
    @NSManaged public var typeOfGeologicalStructures: String?
    @NSManaged public var typeOfFaults: String?
    @NSManaged public var geologistSign: String?
    @NSManaged public var clientsGeologistSign: String?
    @NSManaged public var createDate: String?
    @NSManaged public var updateDate: String?

}
