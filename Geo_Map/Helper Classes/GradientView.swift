//
//  GradientView.swift
//  Geo_Map
//
//  Created by Dhruvit on 12/08/20.
//  Copyright © 2020 Dhruvit. All rights reserved.
//

import Foundation
import UIKit

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint : CGPoint {
        return points.startPoint
    }
    
    var endPoint : CGPoint {
        return points.endPoint
    }
    
    var points : GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
        case .horizontal:
            return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
        }
    }
}


extension UIView {
    
    func applyGradient(with colours: [UIColor], gradient orientation: GradientOrientation) {
        DispatchQueue.main.async {
            let gradient = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colours.map { $0.cgColor }
            gradient.startPoint = orientation.startPoint
            gradient.endPoint = orientation.endPoint
            gradient.accessibilityHint = "gradient"
            self.layer.sublayers?.forEach({
                if $0.accessibilityHint == "gradient" {
                    $0.removeFromSuperlayer()
                }
            })
            self.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    func removeGradient() {
        self.layer.sublayers?.forEach({
            if $0.accessibilityHint == "gradient" {
                $0.removeFromSuperlayer()
            }
        })
    }
    
}
