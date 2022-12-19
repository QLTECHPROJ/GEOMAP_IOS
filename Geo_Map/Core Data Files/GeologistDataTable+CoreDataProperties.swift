//
//  GeologistDataTable+CoreDataProperties.swift

import Foundation



extension GeologistDataTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GeologistDataTable> {
        return NSFetchRequest<GeologistDataTable>(entityName: "GeologistDataTable")
    }

    @NSManaged public var company_type: String?
    @NSManaged public var email: String?
    @NSManaged public var iD: Int64
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var position: String?

}

extension GeologistDataTable : Identifiable {

}
