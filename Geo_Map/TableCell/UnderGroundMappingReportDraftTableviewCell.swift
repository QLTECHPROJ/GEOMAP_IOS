//
//  UnderGroundMappingReportDraftTableviewCell.swift


import Foundation
import UIKit

class UnderGroundMappingReportDraftTableviewCell: UITableViewCell {
    
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
    
    // Configure Cell with UnderGroundMappingReportData
    func configureCellUnderGroundMappingReportData( _ reportData : UnderGroundMappingReportDataTable){
        
        debugPrint(reportData)
        
        self.lblTitle.text = JSON(reportData.name as Any).stringValue
        self.lblDate.text = JSON(reportData.ugDate as Any).stringValue
        self.lblCity.text = JSON(reportData.location as Any).stringValue
        
        let attributedText1: NSMutableAttributedString = NSMutableAttributedString(string: "\(kMappedByColn) \(JSON(reportData.mappedBy as Any).stringValue)")
        attributedText1.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kMappedByColn, font: 12, fontname: .InterMedium)
        attributedText1.setAttributes(color: UIColor.colorTextBlack, forText: JSON(reportData.mappedBy as Any).stringValue, font: 12, fontname: .InterMedium)
        self.lblSubtitle.attributedText = attributedText1
        
        let attributedText2: NSMutableAttributedString = NSMutableAttributedString(string: "\(kMapSerialNoColmn) \(JSON(reportData.mapSerialNo as Any).stringValue)")
        attributedText2.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kMapSerialNoColmn, font: 12, fontname: .InterMedium)
        attributedText2.setAttributes(color: UIColor.colorTextBlack, forText: JSON(reportData.mapSerialNo as Any).stringValue, font: 12, fontname: .InterMedium)
        self.lblDescription.attributedText = attributedText2
        
    }
    
    
    func configureCellOpenCastMappingReportData( _ reportData : OpenCastMappingReportDataTable){
        
        debugPrint(reportData)
        
        self.lblTitle.text = JSON(reportData.pitName as Any).stringValue
        self.lblDate.text = JSON(reportData.ocDate as Any).stringValue
        self.lblCity.text = JSON(reportData.pitLocation as Any).stringValue
        
        let attributedText1: NSMutableAttributedString = NSMutableAttributedString(string: "\(kMinesSiteNameColmn) \(JSON(reportData.minesSiteName as Any).stringValue)")
        attributedText1.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kMinesSiteNameColmn, font: 12, fontname: .InterMedium)
        attributedText1.setAttributes(color: UIColor.colorTextBlack, forText: JSON(reportData.minesSiteName as Any).stringValue, font: 12, fontname: .InterMedium)
        self.lblSubtitle.attributedText = attributedText1
        
        let attributedText2: NSMutableAttributedString = NSMutableAttributedString(string: "\(kMappingSheetNoColn) \(JSON(reportData.mappingSheetNo as Any).stringValue)")
        attributedText2.setAttributes(color: UIColor.colorTextPlaceHolderGray, forText: kMappingSheetNoColn, font: 12, fontname: .InterMedium)
        attributedText2.setAttributes(color: UIColor.colorTextBlack, forText: JSON(reportData.mappingSheetNo as Any).stringValue, font: 12, fontname: .InterMedium)
        self.lblDescription.attributedText = attributedText2
        
    }
    
}
