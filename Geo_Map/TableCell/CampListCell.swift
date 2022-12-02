//
//  CampListCell.swift
//   
//
//  Created by Mac Mini on 27/04/22.
//

import UIKit
import SDWebImage

class CampListCell: UITableViewCell {
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var lblCampDesc: UILabel!
    @IBOutlet weak var lblCampLocation: UILabel!
    @IBOutlet weak var lblCampTitle: UILabel!
    @IBOutlet weak var imgCamp: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBack.dropShadow()
    }
    
    // Configure Cell
    func configureCell(data : CampDetailModel) {
        lblCampTitle.text = data.CampName
        lblCampDesc.text = data.CampDetail
        lblCampLocation.text = data.CampAddress
        
        imgCamp.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        
        if let strUrl = data.CampImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let imgUrl = URL(string: strUrl) {
            imgCamp.sd_setImage(with: imgUrl, completed: nil)
        }
    }
    
}
