//
//  TransationsCell.swift
//  NSC_iOS
//
//  Created by Dhruvit on 18/05/22.
//

import UIKit

class TransationsCell: UITableViewCell {
    
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblAmount : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Configure Cell
    func configureCell(data : TransactionModel) {
        lblName.text = data.Name
        lblDate.text = data.Date
        lblAmount.text = data.Amount
        
        if let strUrl = data.Profile_Image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let imgUrl = URL(string: strUrl) {
            imgView.sd_setImage(with: imgUrl, completed: nil)
        }
    }
    
}
