//
//  UIButton+Extension.swift
//  NSC_iOS
//
//  Created by vishal parmar on 19/10/22.
//

import Foundation
import UIKit


extension UIButton{
    
    open override func awakeFromNib() {
        if #available(iOS 10.0, *) {
            self.titleLabel?.adjustsFontForContentSizeCategory = true
        }
        
        if let titleValue = self.titleLabel?.text {
//            self.setTitle(titleValue.localized, for: UIControl.State.normal)
            debugPrint("NSLocalizedString UIButton :::::::::::::::: \(titleValue)")
        }
        
        self.titleLabel?.lineBreakMode = .byTruncatingTail
        
    }
    
    
    func applystyle(isAdjustToFont : Bool = false ,isApsectRadio : Bool = true,cornerRadius : CGFloat = 0,fontname : CustomFont,fontsize : CGFloat = kMediumFontSize,bgcolor : UIColor = .clear,titleText : String? = nil,titleColor : UIColor = .white,shadowColor: UIColor = .clear,opacity : Float = 0.0,shadowOffset : CGSize = CGSize(width: 0, height: 0),shdowRadius : CGFloat = 0.0, borderColor : UIColor = .clear, borderWidth : CGFloat = 0.0){
        
        self.titleLabel?.font = UIFont.applyCustomFont(fontName: fontname, fontSize: fontsize, isAspectRasio: isApsectRadio)
        
        self.titleLabel?.adjustsFontSizeToFitWidth = isAdjustToFont
        
        self.backgroundColor = bgcolor
        
        self.setTitleColor(titleColor, for: .normal)
        
        self.layer.shadowColor =  shadowColor.cgColor
        
        self.layer.shadowOpacity = opacity
        
        self.layer.shadowOffset = shadowOffset
        
        self.layer.shadowRadius = shdowRadius
        
        self.layer.cornerRadius = cornerRadius
        
        if titleText != nil{
            self.setTitle(titleText, for: .normal)
        }
        
        self.layer.borderColor = borderColor.cgColor
        
        self.layer.borderWidth = borderWidth
        
    }
    
    func setContentEdges(contentEngesLeft : CGFloat = 0, contentEngesRight : CGFloat = 0,contentEngesTop : CGFloat = 0, contentEngesBottom : CGFloat = 0, titleEngesLeft : CGFloat = 0, ImageEngesLeft : CGFloat = 0){
       // if GFunctions.shared.checkDeviceiPhone(){
            
            self.contentEdgeInsets.left = contentEngesLeft
            self.contentEdgeInsets.right = contentEngesRight
            self.contentEdgeInsets.top = contentEngesTop
            self.contentEdgeInsets.bottom = contentEngesBottom
            
            self.titleEdgeInsets.left = titleEngesLeft
            
            self.imageEdgeInsets.left = ImageEngesLeft
         /*
        }else{
            
            self.contentEdgeInsets.top = contentEngesTop * 2.0
            self.contentEdgeInsets.bottom = contentEngesBottom * 2.0
            self.contentEdgeInsets.left = contentEngesLeft * 2.0
            self.contentEdgeInsets.right = contentEngesRight * 2.0
            
            self.titleEdgeInsets.left = titleEngesLeft * 2.0
            
            self.imageEdgeInsets.left = ImageEngesLeft * 2.0
        }*/
    }
}


