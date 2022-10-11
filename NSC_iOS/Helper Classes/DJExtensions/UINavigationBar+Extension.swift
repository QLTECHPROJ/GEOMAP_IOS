//
//  UINavigationBar+Extension.swift
//

import Foundation
import UIKit

// MARK: - UINavigationBar Extension -
extension UINavigationBar {
    
    
    func hideBottomHairline() {
        shadowImage = UIImage()
//        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
//        navigationBarImageView!.isHidden = true
    }
    
    func showBottomHairline() {
//        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
//        navigationBarImageView!.isHidden = false
    }
    
    fileprivate func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}
