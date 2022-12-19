//
//  EditOpenCastMappingImagesVC.swift
//  Geo_Map
//
//  Created by vishal parmar on 13/12/22.
//

import UIKit
import SignaturePad

class EditOpenCastMappingImagesVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    
    @IBOutlet weak var vwDrawPad : SignaturePad!
    
    @IBOutlet weak var btnClearDraw : AppThemeBorderBlueButton!
    @IBOutlet weak var btnSubmit : AppThemeBlueButton!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    
    var openCastMappingDetails : JSON = .null
    var drawImage : UIImage?
    var geologistSignImage : UIImage?
    var clientGeologistSignImage : UIImage?
    var isOfflineDataUpdate : Bool = false
    var viewModelSyncData : SyncDataVM = SyncDataVM()
    private var vmOCMappingReportDraft : OpenCastMappingReportDataModel = OpenCastMappingReportDataModel()
    
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
        
        self.vwDrawPad.isDisplay = false
        
        
        self.setDataForReport()
        self.buttonEnableDisable()
        self.btnSubmit.setTitle(kSave, for: .normal)
        self.btnClearDraw.setTitle(kClear, for: .normal)
        
    }
    
    private func setDataForReport(){
        
        guard let drawImage = self.drawImage else {return}
        self.vwDrawPad.setSignature(_image: drawImage)
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
        
        self.callAPIOrSavedOffline(geologistSign, clientGeologistSignature, drawImage)
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
extension EditOpenCastMappingImagesVC : SignaturePadDelegate{
    
    func didStart() {
        
    }
    
    func didFinish() {
        
        self.buttonEnableDisable()
    }
}

//--------------------------------------------------------------------------------------
// MARK: - API Calling Methods
//--------------------------------------------------------------------------------------
extension EditOpenCastMappingImagesVC{
    
    func callAPIOrSavedOffline(_ geologistSign : UIImage, _ clientGeologistSignature : UIImage, _ drawImage : UIImage){
        
        
        var arrImages : [UIImage] = [geologistSign,clientGeologistSignature,drawImage]
        for imageData in arrImages{
            
//            if let image = imageData{
                MyAppPhotoAlbum.shared.save(image: imageData)
//            }
        }
        
        if !self.isOfflineDataUpdate{
            
            let parameters = APIParametersModel()
            parameters.minesSiteName = self.openCastMappingDetails["minesSiteName"].stringValue
            parameters.mappingSheetNo = self.openCastMappingDetails["mappingSheetNo"].stringValue
            parameters.pitName = self.openCastMappingDetails["pitName"].stringValue
            parameters.pitLoaction = self.openCastMappingDetails["pitLoaction"].stringValue
            parameters.shiftInchargeName = self.openCastMappingDetails["shiftInchargeName"].stringValue
            parameters.geologistName = self.openCastMappingDetails["geologistName"].stringValue
            parameters.faceLocation = self.openCastMappingDetails["faceLocation"].stringValue
            parameters.faceLength = self.openCastMappingDetails["faceLength"].stringValue
            parameters.faceArea = self.openCastMappingDetails["faceArea"].stringValue
            parameters.faceRockType = self.openCastMappingDetails["faceRockType"].stringValue
            parameters.benchRl = self.openCastMappingDetails["benchRl"].stringValue
            parameters.benchHeightWidth = self.openCastMappingDetails["benchHeightWidth"].stringValue
            parameters.benchAngle = self.openCastMappingDetails["benchAngle"].stringValue
            parameters.thicknessOfOre = self.openCastMappingDetails["thicknessOfOre"].stringValue
            parameters.thicknessOfOverburdan = self.openCastMappingDetails["thicknessOfOverburdan"].stringValue
            parameters.thicknessOfInterburden = self.openCastMappingDetails["thicknessOfInterburden"].stringValue
            parameters.observedGradeOfOre = self.openCastMappingDetails["observedGradeOfOre"].stringValue
            parameters.sampleColledted = self.openCastMappingDetails["sampleColledted"].stringValue
            parameters.actualGradeOfOre = self.openCastMappingDetails["actualGradeOfOre"].stringValue
            parameters.weathring = self.openCastMappingDetails["weathring"].stringValue
            parameters.rockStregth = self.openCastMappingDetails["rockStregth"].stringValue
            parameters.waterCondition = self.openCastMappingDetails["waterCondition"].stringValue
            parameters.typeOfGeologist = self.openCastMappingDetails["typeOfGeologistStruture"].stringValue
            parameters.typeOfFaults = self.openCastMappingDetails["typeOfFaults"].stringValue
            parameters.shift = self.openCastMappingDetails["shift"].stringValue
            parameters.ocDate = GFunctions.shared.convertDateFormat(dt: self.openCastMappingDetails["ocDate"].stringValue, inputFormat: DateTimeFormaterEnum.ddmm_yyyy.rawValue, outputFormat: DateTimeFormaterEnum.ddMMMyyyy.rawValue, status: .NOCONVERSION).str
            
            parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
            parameters.dipDirectionAndAngle = self.openCastMappingDetails["dipDirectionAndAngle"].stringValue
            parameters.notes = self.openCastMappingDetails["notes"].stringValue
            
            let drawImage = UploadDataModel(name: "image.jpeg", key: "image", data: drawImage.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            let clientGeologistSignImage = UploadDataModel(name: "image.jpeg", key: "clientsGeologistSign", data: clientGeologistSignature.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            let geologistSignImage = UploadDataModel(name: "image.jpeg", key: "geologistSign", data: geologistSign.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            
            parameters.imageDraaw = drawImage.name
            parameters.clientsGeologistSign = clientGeologistSignImage.name
            parameters.geologistSign = geologistSignImage.name
            
            let arr : [UploadDataModel] = [drawImage,clientGeologistSignImage,geologistSignImage]
            debugPrint(parameters.toDictionary())
            
            
            self.viewModelSyncData.callAPIUploadOpenCastMappingReport(parameters: parameters.toDictionary(), uploadParameters: arr, completion: { completion,message  in
                if completion{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        AppDelegate.shared.updateWindow(.home)
                        GFunctions.shared.showSnackBar(message: message ?? "Error")
                    }
                }
                else{
                    GFunctions.shared.showSnackBar(message: message ?? "Error")
                }
            })
        }
        else{
            
            OpenCastMappingReportDataModel.shared.editOpenCastMappingReportData(JSON(UserModelClass.current.userId as Any).stringValue,
                                                                                self.openCastMappingDetails["mappingSheetNo"].stringValue,
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
                                                                                self.openCastMappingDetails["notes"].stringValue,
                                                                                geologistSign,
                                                                                clientGeologistSignature,
                                                                                drawImage) { completion in
                
                if completion{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        //                        AppDelegate.shared.updateWindow(.home)
                        //                        GFunctions.shared.showSnackBar(message: kOpenCastMappingReportSavedSuccessfully)
                        
                        self.vmOCMappingReportDraft.getOpenCastMappingReportData{ completion in
                            if completion{
                                let dict : JSON = ["offline_id" : self.openCastMappingDetails["mappingSheetNo"].stringValue]
                                for previousVC in self.navigationController!.viewControllers{
                                    
                                    if previousVC.isKind(of: OpenCastReportOfflineDetailVC.self){
                                        NotificationCenter.default.post(name: NSNotification.Name.updateOCOfflineReport, object: dict)
                                        self.navigationController?.popToViewController(previousVC, animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

