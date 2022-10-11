//
//  ListItemCell.swift
//  NSC_iOS
//
//  Created by Sapu on 13/08/20.
//  Copyright © 2020 Dhruvit. All rights reserved.
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
    }
    
    // Configure Cell
    func configureCell(data : ListItem) {
        lblName.text = data.Name
        lblCode.text = "+" + data.Code
        
        lblCode.isHidden = data.Code.trim.count == 0
        
        btnSelect.isHidden = true
    }
    
}
