//
//  OCGeoAttributeVC.swift


import UIKit
import SignaturePad


class OCGeoAttributeVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    
    @IBOutlet weak var lblDate : UILabel!
    
    @IBOutlet weak var txtMappingSheetNo : ACFloatingTextfield!
    @IBOutlet weak var txtMineSiteName : ACFloatingTextfield!
    @IBOutlet weak var txtPitName : ACFloatingTextfield!
    @IBOutlet weak var txtPitLocation : ACFloatingTextfield!
    @IBOutlet weak var txtShiftinchargeName : ACFloatingTextfield!
//    @IBOutlet weak var txtGeologistName : ACFloatingTextfield!
    
    @IBOutlet weak var lblGeologistName : UILabel!
    @IBOutlet weak var vwGeologistName : AppShadowViewClass!
    
    @IBOutlet weak var lblShift : UILabel!
    @IBOutlet weak var btnNightShift : UIButton!
    @IBOutlet weak var btnDayShift : UIButton!
    
    @IBOutlet weak var lblMappingParameters : UILabel!
    
    @IBOutlet weak var txtFaceLocation : ACFloatingTextfield!
    @IBOutlet weak var txtFaceLengthM : ACFloatingTextfield!
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
    
    var isGeologistSigned : Bool = false
    var isClientGeologistSigned : Bool = false
    
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
        self.signatureButtonEnable()
        
    
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = DateTimeFormaterEnum.ddmm_yyyy.rawValue
        
        self.lblDate.applyLabelStyle(text : dateFormat.string(from: Date()),fontSize : 12,fontName : .InterSemibol)
        
//        self.txtMappingSheetNo.applyStyleFlotingTextfield(placeholderTitle : kMappingSheetNo, fontsize : 14,fontname : .InterSemibol)
        self.txtMineSiteName.applyStyleFlotingTextfield(placeholderTitle : kMinesSiteName, fontsize : 14,fontname : .InterSemibol)
        self.txtPitName.applyStyleFlotingTextfield(placeholderTitle : kPitName, fontsize : 14,fontname : .InterSemibol)
        self.txtPitLocation.applyStyleFlotingTextfield(placeholderTitle : kPitLocation, fontsize : 14,fontname : .InterSemibol)
        
        self.txtShiftinchargeName.applyStyleFlotingTextfield(placeholderTitle : kShiftInchargeName, fontsize : 14,fontname : .InterSemibol)
        
        self.lblShift.applyLabelStyle(text : kShift,fontSize : 12,fontName : .InterMedium, textColor: .colorTextPlaceHolderGray)
        
        self.btnNightShift.applystyle(fontname : .InterSemibol,fontsize : 14,titleText : kNightShift,titleColor : .colorTextBlack)
        self.btnNightShift.setContentEdges(titleEngesLeft : 5, ImageEngesLeft : -10)
        self.btnDayShift.applystyle(fontname : .InterSemibol,fontsize : 14,titleText : kDayShift,titleColor : .colorTextBlack)
        self.btnDayShift.setContentEdges(titleEngesLeft : 5, ImageEngesLeft : -10)
        
        self.lblMappingParameters.applyLabelStyle(text : kMappingParameters,fontSize : 12,fontName : .InterMedium)
        
        self.txtFaceLocation.applyStyleFlotingTextfield(placeholderTitle : kFaceLocation, fontsize : 14,fontname : .InterSemibol)
        
        self.txtFaceLengthM.applyStyleFlotingTextfield(placeholderTitle : kFaceLengthM, fontsize : 14,fontname : .InterSemibol)

        self.txtFaceAreaM2.applyStyleFlotingTextfield(placeholderTitle : kFaceAreaM, fontsize : 14,fontname : .InterSemibol)
        self.txtFaceRockType.applyStyleFlotingTextfield(placeholderTitle : kFaceRockType, fontsize : 14,fontname : .InterSemibol)
        self.txtBenchRL.applyStyleFlotingTextfield(placeholderTitle : kBenchRL, fontsize : 14,fontname : .InterSemibol)
        self.txtBenchHeightWidth.applyStyleFlotingTextfield(placeholderTitle : kBenchHeightWidthM, fontsize : 14,fontname : .InterSemibol)
        
        self.txtBenchAngle.applyStyleFlotingTextfield(placeholderTitle : kBenchAngle, fontsize : 14,fontname : .InterSemibol)
        self.txtDipDirectionAngle.applyStyleFlotingTextfield(placeholderTitle : kDipDirectionAndAngle, fontsize : 14,fontname : .InterSemibol)
        
        self.txtThicknessOfOre.applyStyleFlotingTextfield(placeholderTitle : kThicknessOfOreCoalSeam, fontsize : 14,fontname : .InterSemibol)
        self.txtThicknessOfOverBurden.applyStyleFlotingTextfield(placeholderTitle : kThicknessOfOverburdenM, fontsize : 14,fontname : .InterSemibol)
        self.txtThicknessOfInterburden.applyStyleFlotingTextfield(placeholderTitle : kThicknessOfInterburdenM, fontsize : 14,fontname : .InterSemibol)
        self.txtObservedGradeOfOre.applyStyleFlotingTextfield(placeholderTitle : kObservedGradeOfOre, fontsize : 14,fontname : .InterSemibol)
        
        self.txtActualGradeOfOreLabGrade.applyStyleFlotingTextfield(placeholderTitle : kActualGradeOfOreLabGrade, fontsize : 14,fontname : .InterSemibol)
        self.lblGeologistName.applyLabelStyle(text : kGeologistName,fontSize : 14,fontName : .InterSemibol,textColor: .colorTextPlaceHolderGray)
        
        self.lblSampleCollected.applyLabelStyle(text : kSampleCollected,fontSize : 14,fontName : .InterSemibol,textColor: .colorTextPlaceHolderGray)
        self.lblWeathering.applyLabelStyle(text : kWeathering,fontSize : 14,fontName : .InterSemibol,textColor: .colorTextPlaceHolderGray)
        self.lblRockStrenght.applyLabelStyle(text : kRockStrength,fontSize : 14,fontName : .InterSemibol,textColor: .colorTextPlaceHolderGray)
        self.lblWaterCondition.applyLabelStyle(text : kWaterCondition,fontSize : 14,fontName : .InterSemibol,textColor: .colorTextPlaceHolderGray)
        self.lblTypeOfGeologicalStructure.applyLabelStyle(text : kTypeOfGeologicalStructures,fontSize : 14,fontName : .InterSemibol,textColor: .colorTextPlaceHolderGray)
        self.lblTypeOfFault.applyLabelStyle(text : kTypeOfFaults,fontSize : 14,fontName : .InterSemibol,textColor: .colorTextPlaceHolderGray)
        
        self.tvNote.applyTextViewStyle(placeholderText : kNote, fontSize : 14,fontName : .InterSemibol,placeholerColor : .colorTextPlaceHolderGray)
        
        self.lblGeologistSign.applyLabelStyle(text : kGeologistSign,fontSize : 14,fontName : .InterSemibol)
        self.lblClientGeologistSign.applyLabelStyle(text : kClientGeologistSign,fontSize : 14,fontName : .InterSemibol)
        
        self.btnClearGeologistSign.setTitle(kClearGeologistSign, for: .normal)
        self.btnClearClientGeologistSign.setTitle(kClearClientGeologistSign, for: .normal)
        self.btnSubmit.setTitle(kSubmit, for: .normal)
        
        
        self.vwGeologistSign.isDisplay = false
        self.vwClientGeologistSign.isDisplay = false
    }
    
    
    func selectShift(_ selectiontag : Int = 1){
        self.btnDayShift.isSelected = selectiontag == self.btnDayShift.tag
        self.btnNightShift.isSelected = selectiontag == self.btnNightShift.tag
    }
    
    func getShiftType()-> String{
        
        return self.btnDayShift.isSelected ? kDayShift : kNightShift
    }
    
    private func signatureButtonEnable(){
        self.btnClearGeologistSign.isSelect = self.vwGeologistSign.isSigned
        
        self.btnClearClientGeologistSign.isSelect = self.vwClientGeologistSign.isSigned
    }
    
    func buttonEnableDisable(){
        
        var isEnable : Bool = false
        
        self.btnClearGeologistSign.isSelect = self.vwGeologistSign.isSigned
        
        self.btnClearClientGeologistSign.isSelect = self.vwClientGeologistSign.isSigned
       /*
        if self.txtMappingSheetNo.text!.trim.isEmpty
            || self.txtMineSiteName.text!.trim.isEmpty
            || self.txtPitName.text!.trim.isEmpty
            || self.txtPitLocation.text!.trim.isEmpty
            || self.txtShiftinchargeName.text!.trim.isEmpty
            || self.txtGeologistName.text!.trim.isEmpty
            || self.txtFaceLocation.text!.trim.isEmpty
            || self.txtFaceLengthM.text!.trim.isEmpty
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
            || self.tvNote.text!.trim.isEmpty || (self.btnNightShift.isSelected && self.btnDayShift.isSelected) ||  self.lblSampleCollected.text == kSampleCollected || self.lblWeathering.text == kWeathering || self.lblRockStrenght.text == kRockStrength || self.lblWaterCondition.text == kWaterCondition || self.lblTypeOfGeologicalStructure.text == kTypeOfGeologicalStructures || self.lblTypeOfFault.text == kTypeOfFaults || !self.vwGeologistSign.isSigned || !self.vwClientGeologistSign.isSigned{
            
            isEnable = false
            
        }*/
        
        if self.txtMineSiteName.text!.trim.isEmpty{
            isEnable = true
        }else {
            
            isEnable = false
        }
        
        self.btnSubmit.isSelect = true// isEnable
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    func btnOtherActions(){
        
        self.vwGeologistName.handleTapToAction {
            self.view.endEditing(true)
            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .geologistName
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblGeologistName.text = selectedItem["name"].stringValue
                self.lblGeologistName.textColor = .colorTextBlack
            }
        }
        
        self.vwSampleCollected.handleTapToAction {
            self.view.endEditing(true)
            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .sampleCollected
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblSampleCollected.text = selectedItem["name"].stringValue
                self.lblSampleCollected.textColor = .colorTextBlack
            }
        }
        
        
        
        self.vwWeathering.handleTapToAction {
            self.view.endEditing(true)
            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .weathering
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblWeathering.text = selectedItem["name"].stringValue
                self.lblWeathering.textColor = .colorTextBlack
            }
        }
        
        self.vwRockStrenght.handleTapToAction {
            self.view.endEditing(true)
            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .rockStrenght
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblRockStrenght.text = selectedItem["name"].stringValue
                self.lblRockStrenght.textColor = .colorTextBlack
            }
        }
        
        self.vwWaterCondition.handleTapToAction {
            self.view.endEditing(true)
            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .waterCollection
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblWaterCondition.text = selectedItem["name"].stringValue
                self.lblWaterCondition.textColor = .colorTextBlack
            }
        }
        
        self.vwTypeOfGeologicalStructure.handleTapToAction {
            self.view.endEditing(true)
            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .typeOfGeologicalStructure
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblTypeOfGeologicalStructure.text = selectedItem["name"].stringValue
                self.lblTypeOfGeologicalStructure.textColor = .colorTextBlack
            }
        }
        
        self.vwTypeOfFault.handleTapToAction {
            self.view.endEditing(true)
            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .typeOfFaults
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                print(selectedItem)
                self.lblTypeOfFault.text = selectedItem["name"].stringValue
                self.lblTypeOfFault.textColor = .colorTextBlack
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
//        self.buttonEnableDisable()
        
    }
    
    @IBAction func btnClearClientGeologistSign(_ sender : UIButton){
        self.view.endEditing(true)
        
        self.vwGeologistSign.clear()
//        self.buttonEnableDisable()
    }
    
    @IBAction func btnSubmitTapped(_ sender : UIButton){
        self.view.endEditing(true)
     
        guard let geologistSignImage = self.vwGeologistSign.getSignature(), let clientGeologistSignImage = self.vwClientGeologistSign.getSignature() else {return}
        
        let openCastMappingDetails : JSON = [
            "iD" :OpenCastMappingReportDataTable.nextAvailble(),
            "minesSiteName" : JSON(self.txtMineSiteName.text as Any).stringValue,
//            "mappingSheetNo" : JSON(self.txtMappingSheetNo.text as Any).stringValue,
            "pitName" : JSON(self.txtPitName.text as Any).stringValue,
            "pitLoaction" : JSON(self.txtPitLocation.text as Any).stringValue,
            "shiftInchargeName" : JSON(self.txtShiftinchargeName.text as Any).stringValue,
            "geologistName" : JSON(self.lblGeologistName.text as Any).stringValue.trim != kGeologistName ? JSON(self.lblGeologistName.text as Any).stringValue : "",
            "faceLocation" : JSON(self.txtFaceLocation.text as Any).stringValue,
            "faceLength" : JSON(self.txtFaceLengthM.text as Any).stringValue,
            "faceArea" : JSON(self.txtFaceAreaM2.text as Any).stringValue,
            "faceRockType" : JSON(self.txtFaceRockType.text as Any).stringValue,
            "benchRl" : JSON(self.txtBenchRL.text as Any).stringValue,
            "benchHeightWidth" : JSON(self.txtBenchHeightWidth.text as Any).stringValue,
            "benchAngle" : JSON(self.txtBenchAngle.text as Any).stringValue,
            "thicknessOfOre" : JSON(self.txtThicknessOfOre.text as Any).stringValue,
            "thicknessOfOverburdan" : JSON(self.txtThicknessOfOverBurden.text as Any).stringValue,
            "thicknessOfInterburden" : JSON(self.txtThicknessOfInterburden.text as Any).stringValue,
            "observedGradeOfOre" : JSON(self.txtObservedGradeOfOre.text as Any).stringValue,
            "sampleColledted" : JSON(self.lblSampleCollected.text as Any).stringValue.trim != kSampleCollected ? JSON(self.lblSampleCollected.text as Any).stringValue : "",
            "actualGradeOfOre" : JSON(self.txtActualGradeOfOreLabGrade.text as Any).stringValue.trim != kActualGradeOfOreLabGrade ? JSON(self.txtActualGradeOfOreLabGrade.text as Any).stringValue : "",
            "weathring" : JSON(self.lblWeathering.text as Any).stringValue.trim != kWeathering ? JSON(self.lblWeathering.text as Any).stringValue : "",
            "rockStregth" : JSON(self.lblRockStrenght.text as Any).stringValue.trim != kRockStrength ? JSON(self.lblRockStrenght.text as Any).stringValue : "",
            "waterCondition" : JSON(self.lblWaterCondition.text as Any).stringValue.trim != kWaterCondition ? JSON(self.lblWaterCondition.text as Any).stringValue : "",
            "typeOfGeologistStruture" : JSON(self.lblTypeOfGeologicalStructure.text as Any).stringValue.trim != kTypeOfGeologicalStructures ? JSON(self.lblTypeOfGeologicalStructure.text as Any).stringValue : "",
            "typeOfFaults" : JSON(self.lblTypeOfFault.text as Any).stringValue.trim != kTypeOfFaults ? JSON(self.lblTypeOfFault.text as Any).stringValue : "",
            "notes" : JSON(self.tvNote.text as Any).stringValue,
            "shift" : self.getShiftType(),
            "ocDate" : JSON(self.lblDate.text as Any).stringValue,
            "dipDirectionAndAngle" : JSON(self.txtDipDirectionAngle.text as Any).stringValue,
            
        ]
        
        let vc = AppStoryBoard.main.viewController(viewControllerClass: AddOpenCastMappingImagesVC.self)
        vc.openCastMappingDetails = openCastMappingDetails
        vc.geologistSignImage = geologistSignImage
        vc.clientGeologistSignImage = clientGeologistSignImage
        self.navigationController?.pushViewController(vc, animated: true)
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
//        self.buttonEnableDisable()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
//        if textField == self.txtMappingSheetNo{
//            
//            self.txtMineSiteName.becomeFirstResponder()
//        }
//        else
        if textField == self.txtMineSiteName {

            self.txtPitName.becomeFirstResponder()
            
        } else if textField == self.txtPitName {

            self.txtPitLocation.becomeFirstResponder()
        }
        else if textField == self.txtPitLocation {

            self.txtShiftinchargeName.becomeFirstResponder()
        }
        else if textField == self.txtShiftinchargeName {

            self.txtFaceLocation.becomeFirstResponder()
        }
        else if textField == self.txtFaceLocation {

            self.txtFaceLengthM.becomeFirstResponder()
        }
        else if textField == self.txtFaceLengthM {

            self.txtFaceAreaM2.becomeFirstResponder()
        }
        else if textField == self.txtFaceAreaM2 {

            self.txtFaceRockType.becomeFirstResponder()
        }
        else if textField == self.txtFaceRockType {

            self.txtBenchRL.becomeFirstResponder()
        }
        else if textField == self.txtBenchRL {

            self.txtBenchHeightWidth.becomeFirstResponder()
        }
        else if textField == self.txtBenchHeightWidth {

            self.txtBenchAngle.becomeFirstResponder()
        }
        else if textField == self.txtBenchAngle {

            self.txtDipDirectionAngle.becomeFirstResponder()
        }
        else if textField == self.txtDipDirectionAngle {

            self.txtThicknessOfOre.becomeFirstResponder()
        }
        else if textField == self.txtThicknessOfOre {

            self.txtThicknessOfOverBurden.becomeFirstResponder()
        }
        else if textField == self.txtThicknessOfOverBurden {

            self.txtThicknessOfInterburden.becomeFirstResponder()
        }
        else if textField == self.txtThicknessOfInterburden {

            self.txtObservedGradeOfOre.becomeFirstResponder()
        }
        else if textField == self.txtObservedGradeOfOre {

            self.txtActualGradeOfOreLabGrade.becomeFirstResponder()
        }
        else if textField == self.txtActualGradeOfOreLabGrade {

            self.tvNote.becomeFirstResponder()
        }
        return true
    }
}

//--------------------------------------------------------------------------------------
// MARK: - UITextViewDelegate Methods
//--------------------------------------------------------------------------------------
extension OCGeoAttributeVC : UITextViewDelegate {
    
    func textViewDidChangeSelection(_ textView: UITextView) {
//        self.buttonEnableDisable()
    }
}

//--------------------------------------------------------------------------------------
// MARK: - SignaturePadDelegate Methods
//--------------------------------------------------------------------------------------
extension OCGeoAttributeVC : SignaturePadDelegate{
    
    func didStart() {
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
//        self.buttonEnableDisable()
//        self.signatureButtonEnable()
    }
    
    func didFinish() {
        self.scrollView.isScrollEnabled = true
//        self.buttonEnableDisable()
        self.signatureButtonEnable()
    }
}
