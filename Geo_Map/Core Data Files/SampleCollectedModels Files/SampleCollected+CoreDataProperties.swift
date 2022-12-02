//
//  SampleCollected+CoreDataProperties.swift
//  Geo_Map


import Foundation



extension SampleCollected {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SampleCollected> {
        return NSFetchRequest<SampleCollected>(entityName: "SampleCollected")
    }

    @NSManaged public var updateDate: String?
    @NSManaged public var name: String?
    @NSManaged public var iD: Int64
    @NSManaged public var createDate: String?

}

extension SampleCollected : Identifiable {

}
