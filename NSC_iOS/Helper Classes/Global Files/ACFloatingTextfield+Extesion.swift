//
//  ACFloatingTextfield+Extesion.swift
//  NSC_iOS
//
//  Created by vishal parmar on 19/10/22.
//

import Foundation
import UIKit
@_exported import ACFloatingTextfield_Swift




var kRegex = "kRegex"
var kdefaultCharacter = "kRegex"

enum enumAppRegex : String {
    
    case PhoneNumber = "^[0-9]{0,11}$"
    case AlphaNumeric = "^[ a-zA-Z0-9._]*$"
    case allowDecimal = "^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"
    case EmailRegex = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,4})$"
}

extension ACFloatingTextfield : UITextFieldDelegate{
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.keyboardAppearance = .dark
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let placeHolderValue = self.placeholder {
//                self.placeholder = placeHolderValue.localized
                debugPrint("NSLocalizedString UITextField placeholder :::::::::::::::: \(placeHolderValue)")
            }
        }
        
        
        if #available(iOS 10.0, *) {
            self.adjustsFontForContentSizeCategory = true
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let textFieldText: NSString = self.text!as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        
        if regex != nil {
            if regex?.trim != "" {
                let test = NSPredicate(format: "SELF MATCHES %@", regex!)
                if test.evaluate(with: txtAfterUpdate) {
                    return true
                }
                
                return false
            }
            return true
        }
        else {
            return true
        }
    }
    
    var regex : String? {
        
        set {
            self.delegate = self
            objc_setAssociatedObject(self, &kRegex, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &kRegex) as? String
        }
    }
    
    func applyStyleFlotingTextfield(isAspectRatio : Bool = true,
                    noramlPlaceHolderColor : UIColor = .colorTextPlaceHolderGray,
                    selectedPlaceHolderColor : UIColor = .colorSkyBlue,
                    placeHolderFont : UIFont = UIFont.applyCustomFont(fontName: .InterMedium, fontSize: 16),
                    placeholderTitle : String? = nil,
                    textColor : UIColor = .colorTextBlack,
                    fontsize : CGFloat = kNormalFontSize,
                    fontname : CustomFont){
        
        self.font = UIFont.applyCustomFont(fontName: fontname, fontSize: fontsize, isAspectRasio: isAspectRatio)
                        
        self.placeHolderFont = placeHolderFont
        self.selectedPlaceHolderColor = .colorSkyBlue
        self.placeHolderColor = noramlPlaceHolderColor
        
        if let placeHolder = placeholderTitle{
            self.placeholder = placeHolder
        }
        
        self.textColor = textColor

            self.selectedLineColor = UIColor.clear
            self.lineColor = UIColor.clear
    }
    
    func setPlaceholderFont(placeHolderString: String, fontColor: UIColor, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(string: placeHolderString, attributes:[NSAttributedString.Key.foregroundColor: fontColor, NSAttributedString.Key.font : font])
        self.font = font
    }
    
    func setLeftPaddingText() {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftViewMode = .always
    }
    
   
}


class TextFieldPedding: UITextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - 20, y: 0, width: 20 , height: bounds.height)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: -5, y: 0, width: 30 , height: bounds.height)
    }
}
