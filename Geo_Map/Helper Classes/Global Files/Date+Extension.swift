//
//  Date+Extension.swift
//

import Foundation
import UIKit


let kMinute = 60
let kHour = kMinute * 60
let kDaySeconds = kHour * 24
let kDayMinutes = kMinute * 24
let kWeek = kDayMinutes * 7
let kMonth = kDayMinutes * 31
let kYear = kDayMinutes * 365

enum WeekDay : String {
    case Sunday = "Sun"
    case Monday = "Mon"
    case Tuesday = "Tue"
    case Wednseday = "Wed"
    case Thursday = "Thu"
    case Friday = "Fri"
    case Saturday = "Sat"
}

// MARK: - Date Extension -
extension Date
{
    var daysUntilNow: NSNumber {
        let interval = Date().timeIntervalSince(self as Date)
        let days: Int = Int(interval) / kDaySeconds
        return NSNumber(value: days)
    }
    
    func getDateDifference(toDate : Date) -> (Int,Int,Int,Int) {
        let countDownSeconds = Int(self.timeIntervalSince(toDate))
        if countDownSeconds > 0 {
            let days = Int(countDownSeconds / (3600*24))
            let hours = Int((countDownSeconds / 3600) % 24)
            let mins = Int((countDownSeconds / 60) % 60)
            let secs = Int(countDownSeconds % 60)
            return (days,hours,mins,secs)
        }
        return (0,0,0,0)
    }
    
    var midhight: Date {
        var calendar = current
        calendar.timeZone = NSTimeZone.system
        let comps = calendar.dateComponents([.day , .month , .year], from: self as Date)
        return calendar.date(from: comps)! as Date
    }
    func dateSinceMidnightByAddingTimeInterval(_ timeInterval: TimeInterval) -> Date {
        let midnight = self.midhight
        return midnight.addingTimeInterval(timeInterval)
    }
    
     
    var current: Calendar {
        return Calendar.current
    }
    
    var calendarComponents : Set<Calendar.Component>{
        return [Calendar.Component.second , Calendar.Component.minute , Calendar.Component.hour , Calendar.Component.day , Calendar.Component.weekday , Calendar.Component.weekOfMonth , Calendar.Component.month , Calendar.Component.year]
    }
    
    var components: DateComponents {
        return current.dateComponents(calendarComponents, from: self)
    }
    
    var time: String {
        return String(format: "%02d:%02d", hour, minute)
    }
    func toString( _ format:String) -> String? {
        let formatter:DateFormatter = DateFormatter()
        //formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.timeZone =  TimeZone(abbreviation: "UTC")!
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    func toStringTime() -> String? {
        let formatter:DateFormatter = DateFormatter()
        //formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone =  TimeZone(abbreviation: "IST")!
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
    func toStringLongDate() -> String? {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        return formatter.string(from: self)
    }
    mutating func weekdayBetweenDay (_ endDate : Date, weekDay : WeekDay) -> Int{
        let ar = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        let days = self.daysBetweenDay(endDate)
        let day = (days/7)
        let dayStr = self.toString("EEE")
        let strIndex : Int = ar.firstIndex(of: dayStr!)!
        let modIndex : Int = Int(days % 7)
        let index = ar.firstIndex(of: weekDay.rawValue)
        var arr = [String]()
        if modIndex > 0 {
            var count = 0;
            var i = strIndex
            while count < modIndex {
                
                arr.append(ar[i])
                i += 1
                if i > 6 {
                    i = 0
                }
                
                count += 1
            }
        }
        return day + Int(  arr.firstIndex(of: ar[index!]) == nil ? 0 : 1 )
    }
    func daysBetweenDay (_ endDate : Date) -> Int{
        //FIXME: remove comment
        //        if self == endDate {
        //            return 1
        //        }
        //        else if endDate == (self + 1.day) {
        //            return 2
        //        }
        //        else if self < endDate {
        //            let cal = Calendar.current
        //            let unit: Calendar.Component = .day
        //            let components = cal.dateComponents([unit], from: self, to: endDate)
        //            return components.day! + 2
        //        }
        return 0
    }
    var timeAgoSince : String {
        
        let calendar = Calendar.current
        let now = Date()
        let unitFlags : Set<Calendar.Component> = [Calendar.Component.second, Calendar.Component.minute, Calendar.Component.hour, Calendar.Component.day, Calendar.Component.weekOfYear, Calendar.Component.month, Calendar.Component.year]
        let components = calendar.dateComponents(unitFlags, from: self, to: now)
        
        if components.year! >= 2 {
            return "\(components.year!) years ago"
        }
        
        if components.year! >= 1 {
            return "Last year"
        }
        
        if components.month! >= 2 {
            return "\(components.month!) months ago"
        }
        
        if components.month! >= 1 {
            return "Last month"
        }
        
        if components.weekOfYear! >= 2 {
            return "\(components.weekOfYear!) weeks ago"
        }
        
        if components.weekOfYear! >= 1 {
            return "Last week"
        }
        
        if components.day! >= 2 {
            return "\(components.day!) days ago"
        }
        
        if components.day! >= 1 {
            return "Yesterday"
        }
        
        if components.hour! >= 2 {
            return "\(components.hour!) hours ago"
        }
        
        if components.hour! >= 1 {
            return "An hour ago"
        }
        
        if components.minute! >= 2 {
            return "\(components.minute!) minutes ago"
        }
        
        if components.minute! >= 1 {
            return "A minute ago"
        }
        
        if components.second! >= 3 {
            return "\(components.second!) seconds ago"
        }
        
        return "Just now"
        
    }
    func plusSeconds(_ s: UInt) -> Date {
        return self.addComponentsto(seconds: Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func minusSeconds(_ s: UInt) -> Date {
        return self.addComponentsto(seconds: -Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func plusMinutes(_ m: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func minusMinutes(_ m: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: -Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func plusHours(_ h: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: 0, hours: Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func minusHours(_ h: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: 0, hours: -Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func plusDays(_ d: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: 0, hours: 0, days: Int(d), weeks: 0, months: 0, years: 0)
    }
    
    func minusDays(_ d: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: 0, hours: 0, days: -Int(d), weeks: 0, months: 0, years: 0)
    }
    
    func plusWeeks(_ w: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: Int(w), months: 0, years: 0)
    }
    
    func minusWeeks(_ w: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: -Int(w), months: 0, years: 0)
    }
    
    func plusMonths(_ m: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: Int(m), years: 0)
    }
    
    func minusMonths(_ m: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: -Int(m), years: 0)
    }
    
    func plusYears(_ y: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: Int(y))
    }
    
    func minusYears(_ y: UInt) -> Date {
        return self.addComponentsto(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -Int(y))
    }
    
    fileprivate func addComponentsto(seconds sec: Int, minutes min: Int, hours hrs: Int, days d: Int, weeks wks: Int, months mts: Int, years yrs: Int) -> Date {
        var dc: DateComponents = DateComponents()
        dc.second = sec
        dc.minute = min
        dc.hour = hrs
        dc.day = d
        dc.weekOfYear = wks
        dc.month = mts
        dc.year = yrs
        return Calendar.current.date(byAdding: dc, to: self)!
    }
    
    func midnightUTCDate() -> Date {
        var dc: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        dc.hour = 0
        dc.minute = 0
        dc.second = 0
        dc.nanosecond = 0
        dc.timeZone = TimeZone(secondsFromGMT: 0)! as TimeZone
        return Calendar.current.date(from: dc)!
    }
    
    static func secondsBetween(date1 d1:Date, date2 d2:Date) -> Int {
        return Calendar.current.dateComponents([.second], from: d1, to: d2).second ?? 0
    }
    
    static func minutesBetween(date1 d1: Date, date2 d2: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: d1, to: d2).minute ?? 0
    }
    
    static func hoursBetween(date1 d1: Date, date2 d2: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: d1, to: d2).hour ?? 0
    }
    
    static func daysBetween(date1 d1: Date, date2 d2: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: d1, to: d2).day ?? 0
    }
    
    static func weeksBetween(date1 d1: Date, date2 d2: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: d1, to: d2).weekOfYear ?? 0
    }
    
    static func monthsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: d1, to: d2).month ?? 0
    }
    
    static func yearsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: d1, to: d2).year ?? 0
    }
    func isGreaterThan(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedDescending)
    }
    
    func isLessThan(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedAscending)
    }
//    var day: UInt {
//        return UInt(Calendar.current.component(.day, from: self))
//    }
    
//    var month: UInt {
//        return UInt(Calendar.current.component(.month, from: self))
//    }
//
//    var year: UInt {
//        return UInt(Calendar.current.component(.year, from: self))
//    }
//
//    var hour: UInt {
//        return UInt(Calendar.current.component(.hour, from: self))
//    }
//
//    var minute: UInt {
//        return UInt(Calendar.current.component(.minute, from: self))
//    }
//
//    var second: UInt {
//        return UInt(Calendar.current.component(.second, from: self))
//    }
//
//    var weekday: UInt {
//        return UInt(Calendar.current.component(.weekday, from: self))
//    }
    
    var weekdayName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        let dayInWeek = formatter.string(from: self)
        return dayInWeek
    }
    
    var getCurrentTimestamp : Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    
    func dayName(index: UInt) -> String {
        switch index {
        case 1:
            return WeekDay.Sunday.rawValue
        case 2:
            return WeekDay.Monday.rawValue
        case 3:
            return WeekDay.Tuesday.rawValue
        case 4:
            return WeekDay.Wednseday.rawValue
        case 5:
            return WeekDay.Thursday.rawValue
        case 6:
            return WeekDay.Friday.rawValue
        case 7:
            return WeekDay.Saturday.rawValue
        default:
            return ""
        }
    }
    
}


