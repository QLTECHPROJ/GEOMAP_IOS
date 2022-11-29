//
//  SampleCollected+CoreDataProperties.swift
//  Geo_Map
//
//  Created by vishal parmar on 11/11/22.
//
//

import Foundation



extension SampleCollected {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SampleCollected> {
        return NSFetchRequest<SampleCollected>(entityName: "SampleCollected")
    }

    @NSManaged public var uid: Int64
    @NSManaged public var iD: Int64
    @NSManaged public var name: String?
    @NSManaged public var createDate: String?
    @NSManaged public var updateDate: String?

}
