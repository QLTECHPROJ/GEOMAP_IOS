//
//  UITextField+Extension.swift
//  Geo_Map
//
//  Created by vishal parmar on 01/12/22.
//

import Foundation
import UIKit

// MARK: - UITextField Style
extension UITextField {
    
    
    func applyStyle(isAspectRatio : Bool = true,leftImage : UIImage? = nil,leftImageContentMode : UIView.ContentMode = .center,rightImage : UIImage? = nil, rightImageContentMode : UIView.ContentMode = .center, x : Int? = 0, y : Int? = 0, w : Int? = 0, h : Int? = 0,placeholder : String? = nil,placeHolderColor : UIColor = .colorTextPlaceHolderGray,textColor : UIColor = .colorTextBlack,fontsize : CGFloat,fontname : CustomFont,mode : UITextField.ViewMode? = .always){
        

        self.font = UIFont.applyCustomFont(fontName: fontname, fontSize: fontsize, isAspectRasio: isAspectRatio)
                
        if placeholder != nil{
            self.placeholder = placeholder
            self.attributedPlaceholder = NSAttributedString(string: placeholder!,attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
        }
        
        self.textColor = textColor
        
        
        if rightImage != nil{
            let imgRightView = UIImageView()
            
            imgRightView.contentMode = rightImageContentMode
            
            if x != 0 || y != 0 || w != 0 || h != 0{
                imgRightView.frame = CGRect(x: x!, y: y!, width: w!, height: h!)
                imgRightView.image = rightImage
                self.addSubview(imgRightView)
                self.rightView = imgRightView
            }else{
                imgRightView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                imgRightView.image = rightImage
                self.addSubview(imgRightView)
                self.rightView = imgRightView
            }
            if mode != nil{
                self.rightViewMode = mode!
            }else{
                self.rightViewMode = .always
            }
            
        }
        
        if leftImage != nil{
            
            let leftImg = UIImageView()
            leftImg.contentMode = leftImageContentMode
            
            
            if x != 0 || y != 0 || w != 0 || h != 0{
                if leftImage == UIImage(){
                    
                    leftImg.frame = CGRect(x: x!, y: y!, width: 5, height: 5)
                }else{
                    leftImg.frame = CGRect(x: x!, y: y!, width: w!, height: h!)
                }
                
                leftImg.image = leftImage
                self.addSubview(leftImg)
                self.leftView = leftImg
            }else{
                leftImg.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                
                leftImg.image = leftImage
                self.addSubview(leftImg)
                self.leftView = leftImg
            }
            if mode != nil{
                self.leftViewMode = mode!
            }else{
                self.leftViewMode = .always
            }
        }
    }
    
}
