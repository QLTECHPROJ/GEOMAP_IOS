//
//  WhereAmIRunning.swift
//  Geo_Map
//
//  Created by Dhruvit on 01/11/21.
//  Copyright © 2021 Dhruvit. All rights reserved.
//

import Foundation

class WhereAmIRunning {
    
    // MARK: Public
    
    func isRunningInTestFlightEnvironment() -> Bool {
        if isSimulator() {
            return false
        } else {
            if isAppStoreReceiptSandbox() && !hasEmbeddedMobileProvision() {
                return true
            } else {
                return false
            }
        }
    }
    
    func isRunningInAppStoreEnvironment() -> Bool {
        if isSimulator() {
            return false
        } else {
            if isAppStoreReceiptSandbox() || hasEmbeddedMobileProvision() {
                return false
            } else {
                return true
            }
        }
    }

    // MARK: Private

    private func hasEmbeddedMobileProvision() -> Bool{
        if let _ = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") {
            return true
        }
        return false
    }
    
    private func isAppStoreReceiptSandbox() -> Bool {
        if isSimulator() {
            return false
        } else {
            if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
               appStoreReceiptURL.lastPathComponent == "sandboxReceipt" {
                    return true
            }
            return false
        }
    }
    
    private func isSimulator() -> Bool {
        #if arch(i386) || arch(x86_64)
            return true
            #else
            return false
        #endif
    }
    
}
