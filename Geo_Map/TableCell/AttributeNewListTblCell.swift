//
//  AttributeNewListTblCell.swift


import Foundation
import UIKit

class AttributeNewListTblCell : UITableViewCell{
    
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblNos : UILabel!
    @IBOutlet weak var lblProperties : UILabel!
    
    @IBOutlet weak var lblNameValue : UILabel!
    @IBOutlet weak var lblNosValue : UILabel!
    @IBOutlet weak var lblPropertiesValue : UILabel!
    
    @IBOutlet weak var btnDelete : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.lblName.applyLabelStyle(text : kNameColn,fontSize :  12,fontName : .InterMedium,textColor: .colorTextPlaceHolderGray)
        self.lblNameValue.applyLabelStyle(fontSize :  14,fontName : .InterMedium)
        
        self.lblNos.applyLabelStyle(text : kNosColn,fontSize :  12,fontName : .InterMedium,textColor: .colorTextPlaceHolderGray)
        self.lblNosValue.applyLabelStyle(fontSize :  14,fontName : .InterMedium)
        
        self.lblProperties.applyLabelStyle(text : kPropertiesColn,fontSize :  12,fontName : .InterMedium,textColor: .colorTextPlaceHolderGray)
        self.lblPropertiesValue.applyLabelStyle(fontSize :  14,fontName : .InterMedium)
    }
    
    
    func configuredCell(with data : JSON){
        
        self.lblNameValue.text = data["name"].stringValue
        self.lblNosValue.text = data["nose"].stringValue
        self.lblPropertiesValue.text = data["properties"].stringValue
    }
}
