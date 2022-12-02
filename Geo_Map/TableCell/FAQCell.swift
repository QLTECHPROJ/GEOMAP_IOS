//
//  FAQCell.swift
//  BWS_iOS_2
//
//  Created by   on 24/03/21.
//  Copyright © 2021  . All rights reserved.
//

import UIKit

class FAQCell: UITableViewCell {
    
    @IBOutlet weak var lblQuestion : UILabel!
    @IBOutlet weak var lblAnswer : UILabel!
    
    @IBOutlet weak var viewBack : AppShadowViewClass!
    @IBOutlet weak var viewQuestion : UIView!
    @IBOutlet weak var viewAnswer : UIView!
    
    @IBOutlet weak var vwClear : UIView!
    
    @IBOutlet weak var btnArrow : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        viewQuestion.backgroundColor = Theme.colors.white
        viewAnswer.isHidden = false
//        btnArrow.setImage(UIImage(named: "arrowRightFAQ"), for: .normal)
        
        self.lblQuestion.applyLabelStyle(fontSize :  15,fontName : .InterMedium)
        self.lblAnswer.applyLabelStyle(fontSize :  13,fontName : .InterMedium,textColor: .colorTextPlaceHolderGray)
        self.vwClear.layer.cornerRadius = 10
    }
    
    // Configure Cell
    func configureDataInCell(_ data : JSON) {
        self.lblQuestion.text = data["question"].stringValue
        self.lblAnswer.text = data["answer"].stringValue
        
        self.lblQuestion.textColor = data["isOpen"].boolValue ? .white : .colorTextPlaceHolderGray
        self.viewQuestion.backgroundColor = data["isOpen"].boolValue ? .colorSkyBlue : .white
        
        self.viewAnswer.isHidden = !data["isOpen"].boolValue
        self.btnArrow.isSelected = data["isOpen"].boolValue
        print(data)
    }
    
}
