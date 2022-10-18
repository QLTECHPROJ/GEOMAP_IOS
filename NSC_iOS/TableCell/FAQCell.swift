//
//  FAQCell.swift
//  BWS_iOS_2
//
//  Created by Dhruvit on 24/03/21.
//  Copyright © 2021 Dhruvit. All rights reserved.
//

import UIKit

class FAQCell: UITableViewCell {
    
    @IBOutlet weak var lblQuestion : UILabel!
    @IBOutlet weak var lblAnswer : UILabel!
    
    @IBOutlet weak var viewBack : UIView!
    @IBOutlet weak var viewQuestion : UIView!
    @IBOutlet weak var viewAnswer : UIView!
    
    @IBOutlet weak var btnArrow : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewQuestion.backgroundColor = Theme.colors.white
        viewAnswer.isHidden = true
        btnArrow.setImage(UIImage(named: "arrowRightFAQ"), for: .normal)
    }
    
    // Configure Cell
    func configureCell(data : FAQDataModel) {
        lblQuestion.text = data.Title
        lblAnswer.text = data.Desc
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewBack.dropShadow(color: Theme.colors.black, opacity: 0.1, offSet: CGSize(width: 0, height: 0), radius: 5)
            self.viewAnswer.roundCorners([.bottomLeft,.bottomRight], radius: 5)
        }
        
        if data.isSelected {
            lblQuestion.textColor = .white
            viewQuestion.backgroundColor = Theme.colors.theme_dark
            viewAnswer.isHidden = false
            btnArrow.setImage(UIImage(named: "arrowDownFAQ"), for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.viewQuestion.roundCorners([.topLeft,.topRight], radius: 5)
            }
        } else {
            lblQuestion.textColor = Theme.colors.gray_7E7E7E
            viewQuestion.backgroundColor = Theme.colors.white
            viewAnswer.isHidden = true
            btnArrow.setImage(UIImage(named: "arrowRightFAQ"), for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.viewQuestion.roundCorners([.allCorners], radius: 5)
            }
        }
    }
    
}
