//
//  ContactCell.swift
//   
//
//  Created by   on 13/05/22.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblSubtitle : UILabel!
    
    var inviteClicked : (() -> Void)?
    
   
    
    deinit {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTitle.applyLabelStyle(fontSize :  12,fontName : .InterMedium, textColor: .colorTextPlaceHolderGray)
        self.lblSubtitle.applyLabelStyle(fontSize :  14,fontName : .InterMedium)
        self.lblSubtitle.numberOfLines = 0

    }
    
    // Configure Cell
    
    func configureDataInCell(_ reportDetail : JSON){
        
        self.lblTitle.text = reportDetail["key"].stringValue
        self.lblSubtitle.text = reportDetail["value"].stringValue
    }
}

