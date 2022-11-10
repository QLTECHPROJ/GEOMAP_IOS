//
//  NotificationListCell.swift
//  NSC_iOS
//
//  Created by Dhruvit on 19/07/22.
//

import UIKit

class NotificationListCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.setUpUI()
    }
    
    func setUpUI(){
        self.lblTitle.applyLabelStyle(fontSize :  14,fontName : .InterSemibol, textColor : .colorTextPlaceHolderGray)
        self.lblCity.applyLabelStyle(fontSize :  12,fontName : .InterMedium, textColor : .colorTextPlaceHolderGray)
        self.lblSubtitle.applyLabelStyle(fontSize :  12,fontName : .InterMedium, textColor : .colorTextPlaceHolderGray)
        self.lblDate.applyLabelStyle(fontSize :  12,fontName : .InterMedium, textColor : .colorTextPlaceHolderGray)
        self.lblDescription.applyLabelStyle(fontSize :  12,fontName : .InterMedium, textColor : .colorTextPlaceHolderGray)
    }
    
    // Configure Cell
    func configureCell( _ reportData : JSON,_ type : String) {
       
        debugPrint(reportData)
        if type == ReportListType.underGroundReport.rawValue{
            self.lblTitle.text = reportData["name"].stringValue
            self.lblDate.text = reportData["ugDate"].stringValue
            self.lblCity.text = reportData["location"].stringValue
            self.lblSubtitle.text = "\(kScaleColnm) \(reportData["scale"].stringValue)"
            self.lblDescription.text = "\(kMapSerialNoColmn) \(reportData["mapSerialNo"].stringValue)"
        }
        else{
            self.lblTitle.text = reportData["pitName"].stringValue
            self.lblDate.text = reportData["ocDate"].stringValue
            self.lblCity.text = reportData["pitLoaction"].stringValue
            self.lblSubtitle.text = "\(kMinesSiteNameColmn) \(reportData["kMinesSiteNameColmn"].stringValue)"
            self.lblDescription.text = "\(kMappingSheetNoColn) \(reportData["mappingSheetNo"].stringValue)"
        }
    }
    
}
