//
//  UIButtonClasses.swift
//  NSC_iOS
//
//  Created by vishal parmar on 19/10/22.
//

import Foundation
import UIKit

class AppThemeBlueButton : UIButton {
    
    var isSelect : Bool = false {
        didSet{
            self.applyStyle()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyStyle()
    }
    
    func applyStyle() {
        self.applystyle(isAdjustToFont : true ,cornerRadius: 10, fontname: .InterBold, fontsize: 14, bgcolor: isSelect ? .colorSkyBlue : .colorTextPlaceHolderGray, titleColor: .white)
        
        self.dropShadow(color: .colorTextPlaceHolderGray, offSet: CGSize(width: 1, height: 1))
        
        self.isUserInteractionEnabled = isSelect
    }
}

class AppThemeBorderBlueButton : UIButton {

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyStyle()
    }
    
    func applyStyle() {
        self.applystyle(isAdjustToFont : true,cornerRadius: 10, fontname: .InterBold, fontsize: 14, bgcolor: .clear, titleColor: .colorSkyBlue,borderColor : .colorSkyBlue, borderWidth : 1)
    }
}

