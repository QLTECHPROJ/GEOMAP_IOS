//
//  WeatheringData+CoreDataProperties.swift

//
//

import Foundation


extension WeatheringData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatheringData> {
        return NSFetchRequest<WeatheringData>(entityName: "WeatheringData")
    }

    @NSManaged public var iD: Int64
    @NSManaged public var name: String?
    @NSManaged public var createDate: String?
    @NSManaged public var updateDate: String?

}
