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
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
    }
    
    // Configure Cell
    func configureCell(data : NotificationListDataModel) {
        lblTitle.text = data.Title
        lblDesc.text = data.Desc
        lblDate.text = data.Date
    }
    
}
