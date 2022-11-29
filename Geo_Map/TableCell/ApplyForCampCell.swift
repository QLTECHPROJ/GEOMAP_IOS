//
//  ApplyForCampCell.swift
//  Geo_Map
//
//  Created by Dhruvit on 26/05/22.
//

import UIKit

class ApplyForCampCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var imgSelect: UIImageView!
    @IBOutlet weak var viewAddress: UIView!
    
    @IBOutlet weak var lblSeparator: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Configure Cell
    func configureSelectionCell(data : ApplyCampModel) {
        lblName.text = data.Name
        lblAddress.text = data.Address
        lblDate.text = data.CampDates
        
        viewAddress.isHidden = data.Address.trim.count == 0
        lblDate.isHidden = data.CampDates.trim.count == 0
        
        if data.Selected == "1" {
            imgSelect.image = UIImage(named: "CheckSelect")
        } else {
            imgSelect.image = UIImage(named: "CheckDeselect")
        }
    }
    
}
