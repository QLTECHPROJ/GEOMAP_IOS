//
//  JSONSerializable+Helper.swift
//  NSC_iOS
//
//  Created by Dhruvit on 28/04/21.
//  Copyright © 2021 Dhruvit. All rights reserved.
//

import Foundation

protocol JSONSerializable {
    func toJSON() -> String?
}

extension String : JSONSerializable {
    func toJSON() -> String? {
        return "\"\(self)\""
    }
}

extension Int : JSONSerializable {
    func toJSON() -> String? {
        return "\(self)"
    }
}

extension Double : JSONSerializable {
    func toJSON() -> String? {
        return "\(self)"
    }
}

extension Array : JSONSerializable {
    func toJSON() -> String? {
        var out : [String] = []
        for element in self {
            if let json_element = element as? JSONSerializable, let string = json_element.toJSON() {
                out.append(string)
            } else {
                return nil
            }
        }
        
        return "[\(out.joined(separator: ","))]"
    }
}

extension Dictionary : JSONSerializable {
    func toJSON() -> String? {
        var out : [String] = []
        for (k, v) in self {
            if let json_element = v as? JSONSerializable, let string = json_element.toJSON() {
                out.append("\"\(k)\": \(string)")
            } else {
                return nil
            }
        }
        
        return "{\(out.joined(separator: ","))}"
    }
}
