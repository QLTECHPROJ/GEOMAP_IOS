//
//  OCGeoAttributeVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 14/10/22.
//

import UIKit
import IQKeyboardManagerSwift
import SignaturePad


class OCGeoAttributeVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    
    @IBOutlet weak var lblMappingSheetNo : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    
    @IBOutlet weak var txtMineSiteName : ACFloatingTextfield!
    @IBOutlet weak var txtPitName : ACFloatingTextfield!
    @IBOutlet weak var txtPitLocation : ACFloatingTextfield!
    @IBOutlet weak var txtShiftinchargeName : ACFloatingTextfield!
    @IBOutlet weak var txtGeologistName : ACFloatingTextfield!
    
    @IBOutlet weak var lblShift : UILabel!
    @IBOutlet weak var btnNightShift : UIButton!
    @IBOutlet weak var btnDayShift : UIButton!
    
    @IBOutlet weak var lblMappingParameters : UILabel!
    
    @IBOutlet weak var txtFaceLocation : ACFloatingTextfield!
    @IBOutlet weak var txtFaceLength : ACFloatingTextfield!
    @IBOutlet weak var txtFaceAreaM2 : ACFloatingTextfield!
    @IBOutlet weak var txtFaceRockType : ACFloatingTextfield!
    
    @IBOutlet weak var txtBenchRL : ACFloatingTextfield!
    @IBOutlet weak var txtBenchHeightWidth : ACFloatingTextfield!
    @IBOutlet weak var txtBenchAngle : ACFloatingTextfield!
    @IBOutlet weak var txtDipDirectionAngle : ACFloatingTextfield!
    
    @IBOutlet weak var txtThicknessOfOre : ACFloatingTextfield!
    @IBOutlet weak var txtThicknessOfOverBurden : ACFloatingTextfield!
    @IBOutlet weak var txtThicknessOfInterburden : ACFloatingTextfield!
    @IBOutlet weak var txtObservedGradeOfOre : ACFloatingTextfield!
    
    @IBOutlet weak var lblSampleCollected : UILabel!
    @IBOutlet weak var vwSampleCollected : AppShadowViewClass!
    
    @IBOutlet weak var txtActualGradeOfOreLabGrade : ACFloatingTextfield!
    
    @IBOutlet weak var lblWeathering : UILabel!
    @IBOutlet weak var vwWeathering : AppShadowViewClass!
    
    @IBOutlet weak var lblRockStrenght : UILabel!
    @IBOutlet weak var vwRockStrenght : AppShadowViewClass!
    
    @IBOutlet weak var lblWaterCondition : UILabel!
    @IBOutlet weak var vwWaterCondition : AppShadowViewClass!
    
    @IBOutlet weak var lblTypeOfGeologicalStructure : UILabel!
    @IBOutlet weak var vwTypeOfGeologicalStructure : AppShadowViewClass!
    
    @IBOutlet weak var lblTypeOfFault : UILabel!
    @IBOutlet weak var vwTypeOfFault : AppShadowViewClass!
    
    @IBOutlet weak var tvNote : IQTextView!
    
    @IBOutlet weak var lblGeologistSign : UILabel!
    @IBOutlet weak var vwGeologistSign : SignaturePad!
    @IBOutlet weak var btnClearGeologistSign : AppThemeBlueButton!
    
    @IBOutlet weak var lblClientGeologistSign : UILabel!
    @IBOutlet weak var vwClientGeologistSign : SignaturePad!
    @IBOutlet weak var btnClearClientGeologistSign : AppThemeBlueButton!
    
    @IBOutlet weak var btnSubmit : AppThemeBlueButton!
    
    @IBOutlet weak var scrollView : UIScrollView!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    
    
    
    //----------------------------------------------------------------------------
    //MARK: - Memory management
    //----------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Custome Methods
    //----------------------------------------------------------------------------
    //Desc:- Centre method to call Of View Config.
    
    func setUpView(){
        
        self.configureUI()
        self.buttonEnableDisable()
    }
    
    
    //Desc:- Set layout desing customize
    
    func configureUI(){
        
        self.view.backgroundColor = .colorBGSkyBlueLight
        
        self.title = kGeologicalMapping
        
        self.vwGeologistSign.delegate = self
        self.vwClientGeologistSign.delegate = self
        
        self.selectShift()
        self.btnOtherActions()
        
        self.lblMappingSheetNo.applyLabelStyle(text : "\(kMappingSheetNoColn) 1523",fontSize : 12,fontName : .InterSemibol)
        self.lblDate.applyLabelStyle(text : "14 July 2022",fontSize : 12,fontName : .InterSemibol)
        
        self.txtMineSiteName.applyStyleFlotingTextfield(placeholderTitle : kMinesSiteName, fontsize : 16,fontname : .InterSemibol)
        self.txtPitName.applyStyleFlotingTextfield(placeholderTitle : kPitName, fontsize : 16,fontname : .InterSemibol)
        self.txtPitLocation.applyStyleFlotingTextfield(placeholderTitle : kPitLocation, fontsize : 16,fontname : .InterSemibol)
        
        self.txtShiftinchargeName.applyStyleFlotingTextfield(placeholderTitle : kShiftInchargeName, fontsize : 16,fontname : .InterSemibol)
        
        self.txtGeologistName.applyStyleFlotingTextfield(placeholderTitle : kGeologistName, fontsize : 16,fontname : .InterSemibol)
        
        self.lblShift.applyLabelStyle(text : kShift,fontSize : 12,fontName : .InterMedium, textColor: .colorTextPlaceHolderGray)
        
        self.btnNightShift.applystyle(fontname : .InterSemibol,fontsize : 16,titleText : kNightShift,titleColor : .colorTextBlack)
        self.btnNightShift.setContentEdges(titleEngesLeft : 5, ImageEngesLeft : -10)
        self.btnDayShift.applystyle(fontname : .InterSemibol,fontsize : 16,titleText : kDayShift,titleColor : .colorTextBlack)
        self.btnDayShift.setContentEdges(titleEngesLeft : 5, ImageEngesLeft : -10)
        
        self.lblMappingParameters.applyLabelStyle(text : kMappingParameters,fontSize : 12,fontName : .InterMedium)
        
        self.txtFaceLocation.applyStyleFlotingTextfield(placeholderTitle : kFaceLocation, fontsize : 16,fontname : .InterSemibol)
        self.txtFaceLength.applyStyleFlotingTextfield(placeholderTitle : kFaceLengthM, fontsize : 16,fontname : .InterSemibol)
        self.txtFaceAreaM2.applyStyleFlotingTextfield(placeholderTitle : kFaceAreaM, fontsize : 16,fontname : .InterSemibol)
        self.txtFaceRockType.applyStyleFlotingTextfield(placeholderTitle : kFaceRockType, fontsize : 16,fontname : .InterSemibol)
        self.txtBenchRL.applyStyleFlotingTextfield(placeholderTitle : kBenchRL, fontsize : 16,fontname : .InterSemibol)
        self.txtBenchHeightWidth.applyStyleFlotingTextfield(placeholderTitle : kBenchHeightWidthM, fontsize : 16,fontname : .InterSemibol)
        
        self.txtBenchAngle.applyStyleFlotingTextfield(placeholderTitle : kBenchAngle, fontsize : 16,fontname : .InterSemibol)
        self.txtDipDirectionAngle.applyStyleFlotingTextfield(placeholderTitle : kDipDirectionAndAngle, fontsize : 16,fontname : .InterSemibol)
        
        self.txtThicknessOfOre.applyStyleFlotingTextfield(placeholderTitle : kThicknessOfOreCoalSeam, fontsize : 16,fontname : .InterSemibol)
        self.txtThicknessOfOverBurden.applyStyleFlotingTextfield(placeholderTitle : kThicknessOfOverburdenM, fontsize : 16,fontname : .InterSemibol)
        self.txtThicknessOfInterburden.applyStyleFlotingTextfield(placeholderTitle : kThicknessOfInterburdenM, fontsize : 16,fontname : .InterSemibol)
        self.txtObservedGradeOfOre.applyStyleFlotingTextfield(placeholderTitle : kObservedGradeOfOre, fontsize : 16,fontname : .InterSemibol)
        
        self.txtActualGradeOfOreLabGrade.applyStyleFlotingTextfield(placeholderTitle : kActualGradeOfOreLabGrade, fontsize : 16,fontname : .InterSemibol)
        
        self.lblSampleCollected.applyLabelStyle(text : kSampleCollected,fontSize : 16,fontName : .InterSemibol)
        self.lblWeathering.applyLabelStyle(text : kWeathering,fontSize : 16,fontName : .InterSemibol)
        self.lblRockStrenght.applyLabelStyle(text : kRockStrength,fontSize : 16,fontName : .InterSemibol)
        self.lblWaterCondition.applyLabelStyle(text : kWaterCondition,fontSize : 16,fontName : .InterSemibol)
        self.lblTypeOfGeologicalStructure.applyLabelStyle(text : kTypeOfGeologicalStructures,fontSize : 16,fontName : .InterSemibol)
        self.lblTypeOfFault.applyLabelStyle(text : kTypeOfFaults,fontSize : 16,fontName : .InterSemibol)
        
        self.tvNote.applyTextViewStyle(placeholderText : kNote, fontSize : 16,fontName : .InterSemibol,placeholerColor : .colorTextPlaceHolderGray)
        
        self.lblGeologistSign.applyLabelStyle(text : kGeologistSign,fontSize : 16,fontName : .InterSemibol)
        self.lblClientGeologistSign.applyLabelStyle(text : kClientGeologistSign,fontSize : 16,fontName : .InterSemibol)
        
        self.btnClearGeologistSign.setTitle(kClearGeologistSign, for: .normal)
        self.btnClearClientGeologistSign.setTitle(kClearClientGeologistSign, for: .normal)
        self.btnSubmit.setTitle(kSubmit, for: .normal)
    }
    
    
    func selectShift(_ selectiontag : Int = 1){
        self.btnDayShift.isSelected = selectiontag == self.btnDayShift.tag
        self.btnNightShift.isSelected = selectiontag == self.btnNightShift.tag
    }
    
    func buttonEnableDisable(){
        
        var isEnable : Bool = false
        
        self.btnClearGeologistSign.isSelect = self.vwGeologistSign.getSignature() != nil
        
        self.btnClearClientGeologistSign.isSelect = self.vwClientGeologistSign.getSignature() != nil
        
        if self.txtMineSiteName.text!.trim.isEmpty
            || self.txtPitName.text!.trim.isEmpty
            || self.txtPitLocation.text!.trim.isEmpty
            || self.txtShiftinchargeName.text!.trim.isEmpty
            || self.txtGeologistName.text!.trim.isEmpty
            || self.txtFaceLocation.text!.trim.isEmpty
            || self.txtFaceLength.text!.trim.isEmpty
            || self.txtFaceAreaM2.text!.trim.isEmpty
            || self.txtFaceRockType.text!.trim.isEmpty
            || self.txtBenchRL.text!.trim.isEmpty
            || self.txtBenchHeightWidth.text!.trim.isEmpty
            || self.txtBenchAngle.text!.trim.isEmpty
            || self.txtDipDirectionAngle.text!.trim.isEmpty
            || self.txtThicknessOfOre.text!.trim.isEmpty
            || self.txtThicknessOfOverBurden.text!.trim.isEmpty
            || self.txtThicknessOfInterburden.text!.trim.isEmpty
            || self.txtObservedGradeOfOre.text!.trim.isEmpty
            || self.txtActualGradeOfOreLabGrade.text!.trim.isEmpty
            || self.tvNote.text!.trim.isEmpty || (self.btnNightShift.isSelected && self.btnDayShift.isSelected) ||  self.lblSampleCollected.text == kSampleCollected || self.lblWeathering.text == kWeathering || self.lblRockStrenght.text == kRockStrength || self.lblWaterCondition.text == kWaterCondition || self.lblTypeOfGeologicalStructure.text == kTypeOfGeologicalStructures || self.lblTypeOfFault.text == kTypeOfFaults{
            
            isEnable = false
            
        } else {
            
            isEnable = true
        }
        
        self.btnSubmit.isSelect = isEnable
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    func btnOtherActions(){
        
        self.vwSampleCollected.handleTapToAction {

            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .sampleCollected
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblSampleCollected.text = selectedItem["name"].stringValue
            }
        }
        
        self.vwWeathering.handleTapToAction {

            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .weathering
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblWeathering.text = selectedItem["name"].stringValue
            }
        }
        
        self.vwRockStrenght.handleTapToAction {

            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .rockStrenght
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblRockStrenght.text = selectedItem["name"].stringValue
            }
        }
        
        self.vwWaterCondition.handleTapToAction {

            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .waterCollection
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblWaterCondition.text = selectedItem["name"].stringValue
            }
        }
        
        self.vwTypeOfGeologicalStructure.handleTapToAction {
            
            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .typeOfGeologicalStructure
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblTypeOfGeologicalStructure.text = selectedItem["name"].stringValue
            }
        }
        
        self.vwTypeOfFault.handleTapToAction {

            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .typeOfFaults
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblTypeOfFault.text = selectedItem["name"].stringValue
            }
        }
    }
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSelectShiftTapped(_ sender : UIButton){
        self.selectShift(sender.tag)
    }
    
    @IBAction func btnClearGeologistSignTapped(_ sender : UIButton){
        self.view.endEditing(true)
        self.vwClientGeologistSign.clear()
        self.buttonEnableDisable()
        
    }
    
    @IBAction func btnClearClientGeologistSign(_ sender : UIButton){
        self.view.endEditing(true)
        
        self.vwGeologistSign.clear()
        self.buttonEnableDisable()
    }
    
    @IBAction func btnSubmitTapped(_ sender : UIButton){
        self.view.endEditing(true)
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: AddOpenCastMappingImagesVC.self)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    
    
    
    //----------------------------------------------------------------------------
    //MARK:- View life cycle
    //----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

//--------------------------------------------------------------------------------------
// MARK: - UITextFieldDelegate

extension OCGeoAttributeVC : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.buttonEnableDisable()
    }
}

//--------------------------------------------------------------------------------------
// MARK: - UITextViewDelegate
//--------------------------------------------------------------------------------------
extension OCGeoAttributeVC : UITextViewDelegate {
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        self.buttonEnableDisable()
    }
}

extension OCGeoAttributeVC : SignaturePadDelegate{
    
    func didStart() {
        self.scrollView.isScrollEnabled = false
        
        self.buttonEnableDisable()
    }
    
    func didFinish() {
        self.scrollView.isScrollEnabled = true
        self.buttonEnableDisable()
    }
}
