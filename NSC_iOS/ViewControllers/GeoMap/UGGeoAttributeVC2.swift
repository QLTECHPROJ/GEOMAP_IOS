//
//  BankDetailsVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 06/05/22.
//

import UIKit

class UGGeoAttributeVC2: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
   
    
    @IBOutlet weak var txtMapSerialNo : ACFloatingTextfield!
    @IBOutlet weak var txtDate : ACFloatingTextfield!
    @IBOutlet weak var txtShift : ACFloatingTextfield!
    @IBOutlet weak var txtMappedBy : ACFloatingTextfield!
    @IBOutlet weak var txtScale : ACFloatingTextfield!
    @IBOutlet weak var txtLocation : ACFloatingTextfield!
    @IBOutlet weak var txtVeinLoad : ACFloatingTextfield!
    @IBOutlet weak var txtXCordinate : ACFloatingTextfield!
    @IBOutlet weak var txtYCordinate : ACFloatingTextfield!
    @IBOutlet weak var txtZCordinate : ACFloatingTextfield!
    
    
    @IBOutlet weak var btnNextStep: AppThemeBlueButton!
    
    
    // MARK: - VARIABLES
    var isFromEdit = false
    var arrayErrorLabels = [UILabel]()
    let dateDatePicker = UIDatePicker()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.view.backgroundColor = .colorBGSkyBlueLight
        self.title = kGeologicalAttributes
        
        self.txtMapSerialNo.applyStyleFlotingTextfield(placeholderTitle : kMapSerialNo, fontsize : 16,fontname : .InterSemibol)
        self.txtDate.applyStyleFlotingTextfield(placeholderTitle : kDate, fontsize : 16,fontname : .InterSemibol)
        self.txtShift.applyStyleFlotingTextfield(placeholderTitle : kShift, fontsize : 16,fontname : .InterSemibol)
        self.txtMappedBy.applyStyleFlotingTextfield(placeholderTitle : kMappedBy, fontsize : 16,fontname : .InterSemibol)
        self.txtScale.applyStyleFlotingTextfield(placeholderTitle : kScale, fontsize : 16,fontname : .InterSemibol)
        self.txtLocation.applyStyleFlotingTextfield(placeholderTitle : kLocation, fontsize : 16,fontname : .InterSemibol)
        self.txtVeinLoad.applyStyleFlotingTextfield(placeholderTitle : kVeinload, fontsize : 16,fontname : .InterSemibol)
        self.txtXCordinate.applyStyleFlotingTextfield(placeholderTitle : kXCordinate, fontsize : 16,fontname : .InterSemibol)
        self.txtYCordinate.applyStyleFlotingTextfield(placeholderTitle : kYCordinate, fontsize : 16,fontname : .InterSemibol)
        self.txtZCordinate.applyStyleFlotingTextfield(placeholderTitle : kZCordinate, fontsize : 16,fontname : .InterSemibol)
        
        self.btnNextStep.setTitle(kNextStep, for: .normal)
        
        self.buttonEnableDisable()
        self.initDatePicker()
    }
    
    func buttonEnableDisable(){
        
        var isEnable : Bool = false
        
        if !self.txtMapSerialNo.text!.trim.isEmpty && !self.txtDate.text!.trim.isEmpty && !self.txtShift.text!.trim.isEmpty && !self.txtMappedBy.text!.trim.isEmpty && !self.txtScale.text!.trim.isEmpty && !self.txtLocation.text!.trim.isEmpty && !self.txtVeinLoad.text!.trim.isEmpty && !self.txtXCordinate.text!.trim.isEmpty && !self.txtYCordinate.text!.trim.isEmpty && !self.txtZCordinate.text!.trim.isEmpty{
            
            isEnable = true
        }
        self.btnNextStep.isSelect = isEnable
    }
    
    func initDatePicker(){
        self.dateDatePicker.datePickerMode = .date
        self.dateDatePicker.maximumDate = Date()
        self.txtDate.inputView = self.dateDatePicker
        
        if #available(iOS 14, *) {// Added condition for iOS 14
            self.dateDatePicker.preferredDatePickerStyle  = .wheels
            self.dateDatePicker.sizeToFit()
        }
        
        let dateFormattor = DateFormatter()
        dateFormattor.dateFormat = DateTimeFormaterEnum.ddmm_yyyy.rawValue
        self.dateDatePicker.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateTimeFormaterEnum.ddmm_yyyy.rawValue
        self.txtDate.text = dateFormatter.string(from: sender.date)
    }
    
    // MARK: - ACTION
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnNextStepTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: UploadUnderMappingImagesVC.self)
        self.navigationController?.pushViewController(aVC, animated: true)
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
}
