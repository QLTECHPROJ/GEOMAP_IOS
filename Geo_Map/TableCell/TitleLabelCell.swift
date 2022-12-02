//
//  TitleLabelCell.swift
//   
//
//  Created by   on 17/05/22.
//

import UIKit

class TitleLabelCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpUI()
    }
    
    func setUpUI(){
        self.lblTitle.applyLabelStyle(fontSize :  14,fontName : .InterSemibol, textColor : .colorSkyBlue)
        self.btnViewAll.applystyle(fontname : .InterSemibol,fontsize : 13,titleText : kViewAll,titleColor : .colorTextPlaceHolderGray)
    }
}
