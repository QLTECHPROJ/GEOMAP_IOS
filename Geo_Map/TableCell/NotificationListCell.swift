//
//  NotificationListCell.swift
//  Geo_Map
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
        self.lblTitle.applyLabelStyle(fontSize :  14,fontName : .InterSemibol)
        self.lblCity.applyLabelStyle(fontSize :  12,fontName : .InterMedium)
        self.lblSubtitle.applyLabelStyle(fontSize :  12,fontName : .InterMedium, textColor : .colorTextPlaceHolderGray)
        self.lblDate.applyLabelStyle(fontSize :  12,fontName : .InterMedium)
        self.lblDescription.applyLabelStyle(fontSize :  12,fontName : .InterMedium, textColor : .colorTextPlaceHolderGray)
    }
    
    // Configure Cell
    func configureCell( _ reportData : JSON,_ type : String) {
       
        debugPrint(reportData)
        if type == ReportListType.underGroundReport.rawValue{
            self.lblTitle.text = reportData["name"].stringValue
            self.lblDate.text = reportData["ugDate"].stringValue
            self.lblCity.text = reportData["location"].stringValue
            
            let attributedScale: NSMutableAttributedString = NSMutableAttributedString(string: "\(kScaleColnm) \(reportData["scale"].stringValue)")
            attributedScale.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kScaleColnm, font: 12, fontname: .InterMedium)
            attributedScale.setAttributes(color: UIColor.colorTextBlack, forText: reportData["scale"].stringValue, font: 12, fontname: .InterMedium)
            self.lblSubtitle.attributedText = attributedScale
            
            let attributedMapSerialNo: NSMutableAttributedString = NSMutableAttributedString(string: "\(kMapSerialNoColmn) \(reportData["mapSerialNo"].stringValue)")
            attributedMapSerialNo.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kMapSerialNoColmn, font: 12, fontname: .InterMedium)
            attributedMapSerialNo.setAttributes(color: UIColor.colorTextBlack, forText: reportData["mapSerialNo"].stringValue, font: 12, fontname: .InterMedium)
            self.lblDescription.attributedText = attributedMapSerialNo
            
        }
        else{
            self.lblTitle.text = reportData["pitName"].stringValue
            self.lblDate.text = reportData["ocDate"].stringValue
            self.lblCity.text = reportData["pitLoaction"].stringValue
    
            let attributedMineSite: NSMutableAttributedString = NSMutableAttributedString(string: "\(kMinesSiteNameColmn) \(reportData["minesSiteName"].stringValue)")
            attributedMineSite.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kMinesSiteNameColmn, font: 12, fontname: .InterMedium)
            attributedMineSite.setAttributes(color: UIColor.colorTextBlack, forText: reportData["minesSiteName"].stringValue, font: 12, fontname: .InterMedium)
            self.lblSubtitle.attributedText = attributedMineSite
            
            let attributedMapSerialNo: NSMutableAttributedString = NSMutableAttributedString(string: "\(kMappingSheetNoColn) \(reportData["mappingSheetNo"].stringValue)")
            attributedMapSerialNo.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kMappingSheetNoColn, font: 12, fontname: .InterMedium)
            attributedMapSerialNo.setAttributes(color: UIColor.colorTextBlack, forText: reportData["mappingSheetNo"].stringValue, font: 12, fontname: .InterMedium)
            self.lblDescription.attributedText = attributedMapSerialNo
        }
    }
    
}
