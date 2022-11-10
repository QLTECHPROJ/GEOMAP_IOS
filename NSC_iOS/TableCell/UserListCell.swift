//
//  UserListCell.swift
//  BWS_2.0
//
//  Created by Mac Mini on 16/03/21.
//  Copyright © 2021 Mac Mini. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.lblName.applyLabelStyle(fontSize : 14,fontName : .InterMedium,textColor : .colorTextPlaceHolderGray)
    }
    
}
