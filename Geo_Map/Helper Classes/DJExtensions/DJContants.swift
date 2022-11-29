//
//  DJConstants.swift
//

import Foundation
import UIKit
import CoreGraphics
import CoreData
import SystemConfiguration
import UserNotifications

// MARK: - getImageWithColor Function -
func getImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
    let rect  =  CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
}

var sharedCache : NSCache<AnyObject, AnyObject> = NSCache()

func degreesToRadians(_ x : Double) -> Float {
    return Float(Double.pi * x / 180.0)
}

func radiandsToDegrees(_ x : Double) -> Float {
    return Float(x * 180.0 / Double.pi)
}

func localNotification(_ fireDate : Date, alertBody  :String, userInfo : [AnyHashable: Any]? = nil) {
    
    if #available(iOS 10.0, *) {
        //iOS 10 or above version
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
//        content.title = ""
        content.body = alertBody
//        content.categoryIdentifier = "alarm"
        content.userInfo = userInfo!
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = fireDate.hour
        dateComponents.minute = fireDate.minute
        dateComponents.second = fireDate.second
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    else {
        let notification = UILocalNotification()
        notification.fireDate = fireDate
        notification.alertBody = alertBody
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = userInfo
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
}
