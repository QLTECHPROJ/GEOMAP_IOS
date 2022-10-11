//
//  AppConstants.swift
//  NSC_iOS
//
//  Created by Dhruvit on 14/04/21.
//  Copyright © 2021 Dhruvit. All rights reserved.
//

import Foundation

class AppConstants {
    
    static let shared = AppConstants()
    
    // Static from App Side - not coming from response
    static let zero_amount = "\(AppVersionDetails.currencySign) 0.00"
    
    var maxDigits : Int {
        if AppVersionDetails.countryCode == "61" {
            return 10
        } else {
            return 10
        }
    }
    
}
