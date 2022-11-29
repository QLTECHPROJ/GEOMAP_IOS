//
//  BankDetailsVC.swift
//  Geo_Map
//
//  Created by Dhruvit on 06/05/22.
//

import UIKit
import IQKeyboardManagerSwift

class UGGeoAttributeVC2: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
   
    
    @IBOutlet weak var txtMapSerialNo : ACFloatingTextfield!
    @IBOutlet weak var txtName : ACFloatingTextfield!
    @IBOutlet weak var txtDate : ACFloatingTextfield!
    @IBOutlet weak var txtMappedBy : ACFloatingTextfield!
    @IBOutlet weak var txtScale : ACFloatingTextfield!
    @IBOutlet weak var txtLocation : ACFloatingTextfield!
    @IBOutlet weak var txtVeinLoad : ACFloatingTextfield!
    @IBOutlet weak var txtXCordinate : ACFloatingTextfield!
    @IBOutlet weak var txtYCordinate : ACFloatingTextfield!
    @IBOutlet weak var txtZCordinate : ACFloatingTextfield!
    
    
    @IBOutlet weak var tvComment : IQTextView!
    
    
    @IBOutlet weak var btnNightShift : UIButton!
    @IBOutlet weak var btnDayShift : UIButton!
    
    @IBOutlet weak var lblShift : UILabel!
    
    
    @IBOutlet weak var btnNextStep: AppThemeBlueButton!
    
    
    // MARK: - VARIABLES
    var isFromEdit = false
    var arrayErrorLabels = [UILabel]()
    var arrAddedAttributes : [JSON] = []
//    let dateDatePicker = UIDatePicker()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.view.backgroundColor = .colorBGSkyBlueLight
        self.title = kGeologicalMapping
        
        self.txtMapSerialNo.applyStyleFlotingTextfield(placeholderTitle : kMapSerialNo, fontsize : 14,fontname : .InterSemibol)
        self.txtName.applyStyleFlotingTextfield(placeholderTitle : kName, fontsize : 14,fontname : .InterSemibol)
        self.txtDate.applyStyleFlotingTextfield(placeholderTitle : kDate, fontsize : 14,fontname : .InterSemibol)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateTimeFormaterEnum.ddmm_yyyy.rawValue
        self.txtDate.text = dateFormatter.string(from: Date())
        self.txtDate.isUserInteractionEnabled = false
        
        self.txtMappedBy.applyStyleFlotingTextfield(placeholderTitle : kMappedBy, fontsize : 14,fontname : .InterSemibol)
        self.txtScale.applyStyleFlotingTextfield(placeholderTitle : kScale, fontsize : 14,fontname : .InterSemibol)
        self.txtLocation.applyStyleFlotingTextfield(placeholderTitle : kLocation, fontsize : 14,fontname : .InterSemibol)
        self.txtVeinLoad.applyStyleFlotingTextfield(placeholderTitle : kVeinload, fontsize : 14,fontname : .InterSemibol)
        self.txtXCordinate.applyStyleFlotingTextfield(placeholderTitle : kXCordinate, fontsize : 14,fontname : .InterSemibol)
        self.txtYCordinate.applyStyleFlotingTextfield(placeholderTitle : kYCordinate, fontsize : 14,fontname : .InterSemibol)
        self.txtZCordinate.applyStyleFlotingTextfield(placeholderTitle : kZCordinate, fontsize : 14,fontname : .InterSemibol)
        
        self.lblShift.applyLabelStyle(text : kShift,fontSize : 12,fontName : .InterMedium, textColor: .colorTextPlaceHolderGray)
        
        self.btnNightShift.applystyle(fontname : .InterSemibol,fontsize : 14,titleText : kNightShift,titleColor : .colorTextBlack)
        self.btnNightShift.setContentEdges(titleEngesLeft : 5, ImageEngesLeft : -10)
        self.btnDayShift.applystyle(fontname : .InterSemibol,fontsize : 14,titleText : kDayShift,titleColor : .colorTextBlack)
        self.btnDayShift.setContentEdges(titleEngesLeft : 5, ImageEngesLeft : -10)
        
        self.tvComment.applyTextViewStyle(placeholderText : kComment, fontSize : 14,fontName : .InterSemibol,placeholerColor : .colorTextPlaceHolderGray)
        
        self.btnNextStep.setTitle(kNextStep, for: .normal)
        
        self.buttonEnableDisable()
        self.selectShift()
//        self.btnNextStep.isSelect = true
//        self.initDatePicker()
    }
    
    func buttonEnableDisable(){
        
        var isEnable : Bool = false
        
        if !self.txtMapSerialNo.text!.trim.isEmpty && !self.txtName.text!.trim.isEmpty && !self.txtDate.text!.trim.isEmpty && !self.txtMappedBy.text!.trim.isEmpty && !self.txtScale.text!.trim.isEmpty && !self.txtLocation.text!.trim.isEmpty && !self.txtVeinLoad.text!.trim.isEmpty && !self.txtXCordinate.text!.trim.isEmpty && !self.txtYCordinate.text!.trim.isEmpty && !self.txtZCordinate.text!.trim.isEmpty && !self.tvComment.text!.trim.isEmpty{
            
            isEnable = true
        }
        self.btnNextStep.isSelect = isEnable
    }

    func selectShift(_ selectiontag : Int = 1){
        self.btnDayShift.isSelected = selectiontag == self.btnDayShift.tag
        self.btnNightShift.isSelected = selectiontag == self.btnNightShift.tag
    }
    
    func getShiftType()-> String{
        
        return self.btnDayShift.isSelected ? kDayShift : kNightShift
    }
    
    // MARK: - ACTION
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSelectShiftTapped(_ sender : UIButton){
        self.selectShift(sender.tag)
    }

    @IBAction func btnNextStepTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let mappingData : JSON = [
            "iD" : UnderGroundMappingReportDataTable.nextAvailble(),
            "attributes" : self.arrAddedAttributes,
            "mapSerialNo" : JSON(self.txtMapSerialNo.text as Any).stringValue,
            "name" : JSON(self.txtName.text as Any).stringValue,
            "ugDate" : JSON(self.txtDate.text as Any).stringValue,
            "shift" : self.getShiftType(),
            "mappedBy" : JSON(self.txtMappedBy.text as Any).stringValue,
            "scale" : JSON(self.txtScale.text as Any).stringValue,
            "locations" : JSON(self.txtLocation.text as Any).stringValue,
            "veinOrLoad" : JSON(self.txtVeinLoad.text as Any).stringValue,
            "xCoordinate" : JSON(self.txtXCordinate.text as Any).stringValue,
            "yCoordinate" : JSON(self.txtYCordinate.text as Any).stringValue,
            "zCoordinate" : JSON(self.txtZCordinate.text as Any).stringValue,
            "comment" : JSON(self.tvComment.text as Any).stringValue
        ]
        let vc = AppStoryBoard.main.viewController(viewControllerClass: UploadUnderMappingImagesVC.self)
        vc.underGroundMappingDetail = mappingData
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//--------------------------------------------------------------------------------------
// MARK: - UITextViewDelegate

extension UGGeoAttributeVC2 : UITextViewDelegate {
   
    func textViewDidChangeSelection(_ textView: UITextView) {
        self.buttonEnableDisable()
    }
    
}

//--------------------------------------------------------------------------------------
// MARK: - UITextFieldDelegate

extension UGGeoAttributeVC2 : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.buttonEnableDisable()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtMapSerialNo {

            self.txtName.becomeFirstResponder()
//            self.txtDate.becomeFirstResponder()
            
        }
        else if textField == self.txtName {

            self.txtMappedBy.becomeFirstResponder()
        }
        else if textField == self.txtMappedBy {

            self.txtScale.becomeFirstResponder()
        }
        else if textField == self.txtScale {

            self.txtLocation.becomeFirstResponder()
        }
        else if textField == self.txtLocation {

            self.txtVeinLoad.becomeFirstResponder()
        }
        else if textField == self.txtVeinLoad {

            self.txtXCordinate.becomeFirstResponder()
        }
        else if textField == self.txtXCordinate {

            self.txtYCordinate.becomeFirstResponder()
        }
        else if textField == self.txtYCordinate {

            self.txtZCordinate.becomeFirstResponder()
        }
        else if textField == self.txtZCordinate {

            textField.resignFirstResponder()
        }
        
        return true
    }
    
}
