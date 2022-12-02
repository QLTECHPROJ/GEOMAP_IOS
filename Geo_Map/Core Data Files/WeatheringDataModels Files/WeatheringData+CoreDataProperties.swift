//
//  WeatheringData+CoreDataProperties.swift
//  Geo_Map


import Foundation


extension WeatheringData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatheringData> {
        return NSFetchRequest<WeatheringData>(entityName: "WeatheringData")
    }

    @NSManaged public var updateDate: String?
    @NSManaged public var name: String?
    @NSManaged public var iD: Int64
    @NSManaged public var createDate: String?

}

extension WeatheringData : Identifiable {

}
