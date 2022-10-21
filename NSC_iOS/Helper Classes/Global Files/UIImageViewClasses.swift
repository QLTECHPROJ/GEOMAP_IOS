//
//  UIImageViewClasses.swift
//  NSC_iOS
//
//  Created by vishal parmar on 20/10/22.
//

import Foundation
import UIKit


class ImageThemeBorderClass: UIImageView {
    
    var isView : Bool = true
    var isThemeBordered : Bool = true
    var isRound : Bool = true
    var imgCornerRadius : CGFloat? = nil
    var imgBorderColor : UIColor = UIColor.colorSkyBlue
    var imgBorderWidth : CGFloat = 3
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
            if let corner = self.imgCornerRadius{
            self.layer.cornerRadius = corner
        }
        else if self.isRound{
            self.layer.cornerRadius = self.frame.height / 2
        }
   
        if self.isThemeBordered{
            self.setBorderOfProfile()
        }
        if self.isView{
            self.isUserInteractionEnabled = true
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
//            self.addGestureRecognizer(tapGesture)
        }
    }
    
    func setBorderOfProfile(){
        self.layer.borderWidth = self.imgBorderWidth
        self.layer.borderColor = self.imgBorderColor.cgColor
    }
}
