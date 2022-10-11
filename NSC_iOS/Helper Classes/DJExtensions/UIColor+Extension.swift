//
//  UIColor+Extension.swift
//

import Foundation
import UIKit
// MARK: - UIColor Extension -
extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    convenience init(hexString: String) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            self.init(red: 1.0, green: 1.0, blue: 1.0)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    class func colorCode( _ colorCode:String ) -> UIColor {
        let paletteColor : Dictionary = [ "0":0
            ,"1":1
            ,"2":2
            ,"3":3
            ,"4":4
            ,"5":5
            ,"6":6
            ,"7":7
            ,"8":8
            ,"9":9
            ,"A":10
            ,"B":11
            ,"C":12
            ,"D":13
            ,"E":14
            ,"F":15
        ]
        
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        let alpha: CGFloat = 1.0
        
        if colorCode.hasPrefix("#") {
            if colorCode.length == 7 {
                red = CGFloat(paletteColor[(colorCode as NSString).substring(with: NSRange(location: 1, length: 1))]! * paletteColor[(colorCode as NSString).substring(with: NSRange(location: 2, length: 1))]!)
                
                green = CGFloat(paletteColor[(colorCode as NSString).substring(with: NSRange(location: 3, length: 1))]! * paletteColor[(colorCode as NSString).substring(with: NSRange(location: 4, length: 1))]!)
                
                
                blue = CGFloat(paletteColor[(colorCode as NSString).substring(with: NSRange(location: 5, length: 1))]! * paletteColor[(colorCode as NSString).substring(with: NSRange(location: 6, length: 1))]!)
            }else if colorCode.length == 4 {
                red = CGFloat(paletteColor[(colorCode as NSString).substring(with: NSRange(location: 1, length: 1))]! )
                
                green = CGFloat(paletteColor[(colorCode as NSString).substring(with: NSRange(location: 2, length: 1))]! )
                
                
                blue = CGFloat(paletteColor[(colorCode as NSString).substring(with: NSRange(location: 3, length: 1))]!)
            }
        }
        
        return UIColor(red:red, green:green, blue:blue, alpha:alpha)
    }
    class func fromRgbHex(_ fromHex: Int) -> UIColor {
        
        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func gradient(for rect:CGRect, from colors:[UIColor], startPoint:CGPoint, endPoint:CGPoint) -> UIColor? {
        let layer = CAGradientLayer()
        layer.frame = rect
        layer.colors = colors.map({ $0.cgColor })
        layer.startPoint = startPoint
        layer.endPoint = endPoint
        
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return UIColor(patternImage: img)
    }
    
    static var random: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }
    
}


@objc extension UIColor {

    convenience init(_ rgbValue: UInt32, _ alpha: CGFloat = 1.0) {
        let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgbValue & 0xFF00) >> 8) / 255.0
        let b = CGFloat(rgbValue & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }

    private func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            assertionFailure()
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count == 4 {
            a = Float(components[3])
        }

        if alpha {
            return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }

    var toHex: String? {
        return toHex()
    }
}
