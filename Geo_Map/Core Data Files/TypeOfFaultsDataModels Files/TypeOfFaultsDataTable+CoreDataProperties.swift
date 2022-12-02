//
//  TypeOfFaultsDataTable+CoreDataProperties.swift
//  Geo_Map


import Foundation



extension TypeOfFaultsDataTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TypeOfFaultsDataTable> {
        return NSFetchRequest<TypeOfFaultsDataTable>(entityName: "TypeOfFaultsDataTable")
    }

    @NSManaged public var updateDate: String?
    @NSManaged public var name: String?
    @NSManaged public var iD: Int64
    @NSManaged public var createDate: String?

}

extension TypeOfFaultsDataTable : Identifiable {

}
