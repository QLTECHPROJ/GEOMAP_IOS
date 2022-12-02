//
//  ListItemCell.swift
//   
//
//  Created by Sapu on 13/08/20.
//  Copyright © 2020  . All rights reserved.
//

import UIKit

class ListItemCell: UITableViewCell {

    // MARK: - OUTLETS
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblCode : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.lblName.applyLabelStyle(fontSize :  12,fontName : .InterMedium)
        self.lblName.numberOfLines = 0
    }
    
    // Configure Cell
    func configureCell(data : JSON) {
        debugPrint(data)
        lblName.text = data["name"].stringValue
//        lblCode.text = "+" + data.Code
//        
        lblCode.isHidden = true//data.Code.trim.count == 0
//        
//        btnSelect.isHidden = true
    }
    
}
