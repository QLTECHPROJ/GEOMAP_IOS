//
//  AttributeDataTable+CoreDataProperties.swift
//  Geo_Map


import Foundation


extension AttributeDataTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AttributeDataTable> {
        return NSFetchRequest<AttributeDataTable>(entityName: "AttributeDataTable")
    }

    @NSManaged public var updateDate: String?
    @NSManaged public var name: String?
    @NSManaged public var iD: Int64
    @NSManaged public var createDate: String?
    @NSManaged public var nos: NSSet?

}

// MARK: Generated accessors for nos
extension AttributeDataTable {

    @objc(addNosObject:)
    @NSManaged public func addToNos(_ value: Nos)

    @objc(removeNosObject:)
    @NSManaged public func removeFromNos(_ value: Nos)

    @objc(addNos:)
    @NSManaged public func addToNos(_ values: NSSet)

    @objc(removeNos:)
    @NSManaged public func removeFromNos(_ values: NSSet)

}

extension AttributeDataTable : Identifiable {

}
