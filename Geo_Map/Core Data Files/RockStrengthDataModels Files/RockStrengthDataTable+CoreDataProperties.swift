//
//  RockStrengthDataTable+CoreDataProperties.swift
//  Geo_Map


import Foundation



extension RockStrengthDataTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RockStrengthDataTable> {
        return NSFetchRequest<RockStrengthDataTable>(entityName: "RockStrengthDataTable")
    }

    @NSManaged public var updateDate: String?
    @NSManaged public var name: String?
    @NSManaged public var iD: Int64
    @NSManaged public var createDate: String?

}

extension RockStrengthDataTable : Identifiable {

}
