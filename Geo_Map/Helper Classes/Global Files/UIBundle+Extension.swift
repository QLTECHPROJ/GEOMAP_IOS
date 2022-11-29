//
//  UIBundle+Extension.swift
//  Geo_Map
//
//  Created by vishal parmar on 10/11/22.
//

import Foundation
import UIKit

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
