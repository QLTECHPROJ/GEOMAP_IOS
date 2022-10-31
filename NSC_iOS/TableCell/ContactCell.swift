//
//  ContactCell.swift
//  NSC_iOS
//
//  Created by Dhruvit on 13/05/22.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblSubtitle : UILabel!
    
    var inviteClicked : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTitle.applyLabelStyle(fontSize :  12,fontName : .InterMedium, textColor: .colorTextPlaceHolderGray)
        self.lblSubtitle.applyLabelStyle(fontSize :  16,fontName : .InterMedium)
    }
    
    // Configure Cell

    func configureDataInCell(_ reportDetail : [String:Any]){
        
        self.lblTitle.text = reportDetail["title"] as! String
        self.lblSubtitle.text = reportDetail["subtitle"] as! String
    }
}
