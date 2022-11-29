//
//  AppShadowViewClass.swift
//  Geo_Map
//
//  Created by vishal parmar on 19/10/22.
//

import Foundation
import UIKit
import SignaturePad


class AppShadowViewClass : UIView {
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyStyle()
    }
    
    func applyStyle() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.dropShadow(color: .colorTextPlaceHolderGray, offSet: CGSize(width: -1, height: 1))
        
    }
}

class SignatureView : SignaturePad {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyStyle()
    }
    
    func applyStyle() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.dropShadow(color: .colorTextPlaceHolderGray, offSet: CGSize(width: -1, height: 1))
    
        self.isMultipleTouchEnabled = true
        self.backgroundColor = .white
    }
}
