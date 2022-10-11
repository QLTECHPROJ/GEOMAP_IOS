//
//  UISearchBar+Extension.swift
//

import Foundation
import UIKit

// MARK: - UISearchBar Extension -
extension UISearchBar {
    
    func radiusRemove() {
        self.tintColor = UIColor.white
        if let textfield = textFieldView(self) {
            textfield.layer.cornerRadius = 0.0
            textfield.borderStyle = .none
            textfield.textColor = UIColor.white
            textfield.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15)
            textfield.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
            
            let iconView : UIImageView = textfield.leftView as! UIImageView
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
    }
    fileprivate func textFieldView(_ view: UIView) -> UITextField? {
        if view is UITextField {
            return (view as! UITextField)
        }
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let textField : UITextField = textFieldView(subview) {
                return textField
            }
        }
        
        return nil
    }
}
