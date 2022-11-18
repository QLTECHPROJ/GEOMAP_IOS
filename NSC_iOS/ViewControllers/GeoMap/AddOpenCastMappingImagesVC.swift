//
//  AddOpenCastMappingImagesVC.swift
//  NSC_iOS
//
//  Created by vishal parmar on 27/10/22.
//

import UIKit
import SignaturePad

class AddOpenCastMappingImagesVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    
    @IBOutlet weak var vwDrawPad : SignaturePad!
   
    @IBOutlet weak var btnClearDraw : AppThemeBorderBlueButton!
    @IBOutlet weak var btnSubmit : AppThemeBlueButton!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    
    var isDrawStart : Bool = Bool()
    
    var openCastMappingDetails : JSON = .null
    var geologistSignImage : UIImage?
    var clientGeologistSignImage : UIImage?
    
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
    }
    
    
    
    //Desc:- Set layout desing customize
    
    func configureUI(){
        self.view.backgroundColor = .colorBGSkyBlueLight

        self.title = kGeologicalMapping
        
        self.vwDrawPad.delegate = self
        
        self.buttonEnableDisable()
        self.btnSubmit.setTitle(kSubmit, for: .normal)
        self.btnClearDraw.setTitle(kClear, for: .normal)

    }
 
    func buttonEnableDisable(){
        self.btnSubmit.isSelect = self.vwDrawPad.isSigned
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearDrawTapped(_ sender : UIButton){
        self.view.endEditing(true)
        
        self.vwDrawPad.clear()
        self.buttonEnableDisable()
    }
    
    @IBAction func btnSubmitTapped(_ sender : UIButton){
        self.view.endEditing(true)
        
        guard let drawImage = self.vwDrawPad.getSignature() , let geologistSign = self.geologistSignImage, let clientGeologistSignature = self.clientGeologistSignImage else { return }
        
        OpenCastMappingReportDataModel.shared.insertUnderGroundMappingReportData(self.openCastMappingDetails["iD"].stringValue,
                                                                                 self.openCastMappingDetails["ocDate"].stringValue,
                                                                                 self.openCastMappingDetails["mappingSheetNo"].stringValue,
                                                                                 self.openCastMappingDetails["minesSiteName"].stringValue,
                                                                                 self.openCastMappingDetails["pitName"].stringValue,
                                                                                 self.openCastMappingDetails["pitLoaction"].stringValue,
                                                                                 self.openCastMappingDetails["shiftInchargeName"].stringValue,
                                                                                 self.openCastMappingDetails["geologistName"].stringValue,
                                                                                 self.openCastMappingDetails["shift"].stringValue,
                                                                                 self.openCastMappingDetails["faceLocation"].stringValue,
                                                                                 self.openCastMappingDetails["faceLength"].stringValue,
                                                                                 self.openCastMappingDetails["faceArea"].stringValue,
                                                                                 self.openCastMappingDetails["faceRockType"].stringValue,
                                                                                 self.openCastMappingDetails["benchRl"].stringValue,
                                                                                 self.openCastMappingDetails["benchHeightWidth"].stringValue,
                                                                                 self.openCastMappingDetails["benchAngle"].stringValue,
                                                                                 self.openCastMappingDetails["dipDirectionAndAngle"].stringValue,
                                                                                 self.openCastMappingDetails["thicknessOfOre"].stringValue,
                                                                                 self.openCastMappingDetails["thicknessOfOverburdan"].stringValue,
                                                                                 self.openCastMappingDetails["thicknessOfInterburden"].stringValue,
                                                                                 self.openCastMappingDetails["observedGradeOfOre"].stringValue,
                                                                                 self.openCastMappingDetails["sampleColledted"].stringValue,
                                                                                 self.openCastMappingDetails["actualGradeOfOre"].stringValue,
                                                                                 self.openCastMappingDetails["weathring"].stringValue,
                                                                                 self.openCastMappingDetails["rockStregth"].stringValue,
                                                                                 self.openCastMappingDetails["waterCondition"].stringValue,
                                                                                 self.openCastMappingDetails["typeOfGeologistStruture"].stringValue,
                                                                                 self.openCastMappingDetails["typeOfFaults"].stringValue,
                                                                                 geologistSign,
                                                                                 clientGeologistSignature,
                                                                                 drawImage) { completion in
            
            if completion{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    AppDelegate.shared.updateWindow(.home)
                    GFunctions.shared.showSnackBar(message: kOpenCastMappingReportSavedSuccessfully)
                }
            }
        }
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
// MARK: - SignaturePadDelegate Methods
//--------------------------------------------------------------------------------------
extension AddOpenCastMappingImagesVC : SignaturePadDelegate{
    
    func didStart() {
        
    }
    
    func didFinish() {
        
        self.buttonEnableDisable()
    }
}
