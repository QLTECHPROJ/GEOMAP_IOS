//
//  NotificationListCell.swift
//   
//
//  Created by   on 19/07/22.
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
            self.lblTitle.text = reportData["name"].stringValue.deshOrText
             let date = GFunctions.shared.convertDateFormat(dt: reportData["ugDate"].stringValue, inputFormat: DateTimeFormaterEnum.UTCFormat.rawValue, outputFormat: DateTimeFormaterEnum.ddmm_yyyy.rawValue, status: .NOCONVERSION).str.deshOrText
            
            let time = GFunctions.shared.convertDateFormat(dt: reportData["ugDate"].stringValue, inputFormat: DateTimeFormaterEnum.UTCFormat.rawValue, outputFormat: DateTimeFormaterEnum.hhmmA.rawValue, status: .NOCONVERSION).str.deshOrText
            
            
            self.lblDate.text = "\(date)\n\(time)"
            self.lblCity.text = reportData["location"].stringValue.deshOrText
            
            let attributedScale: NSMutableAttributedString = NSMutableAttributedString(string: "\(kMappedByColn) \(reportData["mappedBy"].stringValue.deshOrText)")
            attributedScale.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kMappedByColn, font: 12, fontname: .InterMedium)
            attributedScale.setAttributes(color: UIColor.colorTextBlack, forText: reportData["mappedBy"].stringValue.deshOrText, font: 12, fontname: .InterMedium)
            self.lblSubtitle.attributedText = attributedScale
            
            let attributedMapSerialNo: NSMutableAttributedString = NSMutableAttributedString(string: "\(kMapSerialNoColmn) \(reportData["mapSerialNo"].stringValue.deshOrText)")
            attributedMapSerialNo.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kMapSerialNoColmn, font: 12, fontname: .InterMedium)
            attributedMapSerialNo.setAttributes(color: UIColor.colorTextBlack, forText: reportData["mapSerialNo"].stringValue.deshOrText, font: 12, fontname: .InterMedium)
            self.lblDescription.attributedText = attributedMapSerialNo
            
        }
        else{
            self.lblTitle.text = reportData["pitName"].stringValue.deshOrText
            self.lblCity.text = reportData["pitLoaction"].stringValue.deshOrText
            
            
            let date = GFunctions.shared.convertDateFormat(dt: reportData["ocDate"].stringValue, inputFormat: DateTimeFormaterEnum.UTCFormat.rawValue, outputFormat: DateTimeFormaterEnum.ddmm_yyyy.rawValue, status: .NOCONVERSION).str.deshOrText
           
           let time = GFunctions.shared.convertDateFormat(dt: reportData["ocDate"].stringValue, inputFormat: DateTimeFormaterEnum.UTCFormat.rawValue, outputFormat: DateTimeFormaterEnum.hhmmA.rawValue, status: .NOCONVERSION).str.deshOrText
           
           
           self.lblDate.text = "\(date)\n\(time)"
    
            let attributedMineSite: NSMutableAttributedString = NSMutableAttributedString(string: "\(kMinesSiteNameColmn) \(reportData["minesSiteName"].stringValue.deshOrText)")
            attributedMineSite.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kMinesSiteNameColmn, font: 12, fontname: .InterMedium)
            attributedMineSite.setAttributes(color: UIColor.colorTextBlack, forText: reportData["minesSiteName"].stringValue.deshOrText, font: 12, fontname: .InterMedium)
            self.lblSubtitle.attributedText = attributedMineSite
            
            let attributedMapSerialNo: NSMutableAttributedString = NSMutableAttributedString(string: "\(kMappingSheetNoColn) \(reportData["mappingSheetNo"].stringValue.deshOrText)")
            attributedMapSerialNo.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kMappingSheetNoColn, font: 12, fontname: .InterMedium)
            attributedMapSerialNo.setAttributes(color: UIColor.colorTextBlack, forText: reportData["mappingSheetNo"].stringValue.deshOrText, font: 12, fontname: .InterMedium)
            self.lblDescription.attributedText = attributedMapSerialNo
        }
        
    }
    
}
