//
//  NotificationListCell.swift
//  NSC_iOS
//
//  Created by Dhruvit on 19/07/22.
//

import UIKit

class NotificationListCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgView.isHidden = true
    }
    
    // Configure Cell
    func configureCell(data : NotificationListDataModel) {
        lblTitle.text = data.Title
        lblDesc.text = data.Desc
        lblDate.text = data.Date
    }
    
}
