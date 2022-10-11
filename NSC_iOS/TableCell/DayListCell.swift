//
//  DayListCell.swift
//  NSC_iOS
//
//  Created by Dhruvit on 17/05/22.
//

import UIKit

class DayListCell: UITableViewCell {
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBack.dropShadow()
    }
    
    // Configure Cell
    func configureCell(data : CampDaysDetailModel) {
        lblTitle.text = "Day \(data.dayId)"
        
        btnSelect.setImage(UIImage(named: "OrangeArrow_Tint"), for: .normal)
        
        DispatchQueue.main.async {
            if data.currentDay == "1" {
                self.viewBack.backgroundColor = Theme.colors.white
                self.lblTitle.textColor = Theme.colors.textColor
                self.btnSelect.tintColor = Theme.colors.theme_dark
            } else {
                self.viewBack.backgroundColor = Theme.colors.gray_7E7E7E
                self.lblTitle.textColor = Theme.colors.white
                self.btnSelect.tintColor = Theme.colors.white
            }
        }
    }
    
}
