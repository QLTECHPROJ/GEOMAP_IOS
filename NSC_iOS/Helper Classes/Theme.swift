//
//  File.swift
//  NSC_iOS
//
//  Created by Dhruvit on 12/08/20.
//  Copyright © 2020 Dhruvit. All rights reserved.
//

import Foundation
import SVProgressHUD

// Theme Did Change notification object
extension Notification.Name {
    static let ThemeDidChangeNotification = Notification.Name("themeDidChangeNotfication")
    static let likedOrDownloadedAudio = Notification.Name("likedOrDownloadedAudio")
    static let refreshLikedList = Notification.Name("refreshLikedList")
}

// SET APP THEME
var isSystemDarkMode: Bool = false {
    didSet {
        NotificationCenter.default.post(name: .ThemeDidChangeNotification, object: nil)
        SVProgressHUD.setDefaultStyle( isSystemDarkMode ? .dark : .light)
    }
}


// MARK: - Application Theme
struct Theme {
    
    static var shared = Theme()
    
    static var colors = AppColors()
    static var images = AppImages()
    static var strings = AppStrings()
    static var fonts = AppFonts()
    static var dateFormats = AppDateFormats()
    
    func changeTheme() {
        Theme.colors = AppColors()
        Theme.images = AppImages()
        Theme.strings = AppStrings()
        Theme.fonts = AppFonts()
        Theme.dateFormats = AppDateFormats()
    }
    
}


// MARK: - Application Images
struct AppImages {
    let btnBgWOShadow = UIImage(named: "btnBgWOShadow")
}


// MARK: - Application Date Formats
struct AppDateFormats {
    let backend = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    let backend2 = "yyyy-MM-dd HH:mm:ss"
    let common = "dd/MM/yyyy"
    let navigationBarFormat = "EEEE, MMMM dd"
    let eventsFormat = "MMM dd, yyyy"
    let eventStartDateFormat = "yyyy-MM-dd hh:mm:ss"
    let comment = "MMM dd, yyyy, hh:mm a"
    let DOB_Backend = "yyyy-MM-dd"
    let DOB_App = "dd MMM, yyyy"
    let Billing_Order_App = "dd MMMM, yyyy"
}


// MARK: - UIStatusBarStyle - autoDarkContent

extension UIStatusBarStyle {
    static var autoDarkContent: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
}
