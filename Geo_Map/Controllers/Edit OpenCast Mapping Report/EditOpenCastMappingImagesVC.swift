//
//  EditOpenCastMappingImagesVC.swift
//  Geo_Map
//
//  Created by vishal parmar on 13/12/22.
//

import UIKit
import SignaturePad
import Combine

enum DrawingOCType : String {
    
    case geologistSign = "geologistSign"
    case clientGeologistSign = "clientGeologistSign"
    case ocDrawing = "ocDrawing"
}

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
    
    var isEditedDrawing : Bool = false
    
    var dictDrawSign : [String:Any] = [:]
    
    var isOfflineDataUpdate : Bool = false
    var cancellable: AnyCancellable?
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
        
        self.vwDrawPad.isDisplay = true
        
        
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
        self.btnSubmit.isSelect = true //self.vwDrawPad.isSigned
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearDrawTapped(_ sender : UIButton){
        self.view.endEditing(true)
        self.isEditedDrawing = false
        self.vwDrawPad.clear()
        self.buttonEnableDisable()
    }
    
    @IBAction func btnSubmitTapped(_ sender : UIButton){
        self.view.endEditing(true)
        
        guard let drawImage = self.vwDrawPad.getSignature()/* , let geologistSign = self.geologistSignImage, let clientGeologistSignature = self.clientGeologistSignImage*/ else { return }
        
        self.callAPIOrSavedOffline()
    }
    
    
    @IBAction func onTappedChangeColor(_ sender: UIButton) {
        
        let picker = UIColorPickerViewController()
        picker.selectedColor = self.vwDrawPad.strokeColor
        
        //  Subscribing selectedColor property changes.
        self.cancellable = picker.publisher(for: \.selectedColor)
            .sink { color in
                
                //  Changing view color on main thread.
                DispatchQueue.main.async {
                    self.vwDrawPad.strokeColor = color
                }
            }
        
        self.present(picker, animated: true, completion: nil)
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
        self.isEditedDrawing = true
        self.buttonEnableDisable()
    }
}

//--------------------------------------------------------------------------------------
// MARK: - API Calling Methods
//--------------------------------------------------------------------------------------
extension EditOpenCastMappingImagesVC{
    
    func callAPIOrSavedOffline(){
        
        MyAppPhotoAlbum.shared.saveImagesInGallary { success in
            
            var geoSigned = UIImage()
            var clientGeoSigned = UIImage()
            var drawImage = UIImage()
            
            var geoSignIsSigned = Bool()
            var clientGeoSignedIsSigned = Bool()
            
            if let _ = self.vwDrawPad.getSignature(){
                drawImage = self.vwDrawPad.getSignature()!
            }
            
            var arrImages : [[String:Any]] = [["draw" : drawImage,"type" : DrawingOCType.ocDrawing.rawValue, "isSigned" : self.vwDrawPad.isSigned, "isEdited" : self.isEditedDrawing]]
            
            if let geoSign = self.dictDrawSign["geologistSignImage"] as? UIImage{
                
                geoSigned = geoSign
                arrImages.append(["draw" : geoSign,"type" : DrawingOCType.geologistSign.rawValue, "isSigned" : JSON(self.dictDrawSign["geologistSignImageIsSigned"] as Any).boolValue])
                geoSignIsSigned = JSON(self.dictDrawSign["geologistSignImageIsSigned"] as Any).boolValue
            }
            if let clientGeoSign  = self.dictDrawSign["clientGeologistSignImage"] as? UIImage{
                
                clientGeoSigned = clientGeoSign
                arrImages.append(["draw" : clientGeoSigned,"type" : DrawingOCType.clientGeologistSign.rawValue, "isSigned" : JSON(self.dictDrawSign["clientGeologistSignImageIsSigned"] as Any).boolValue])
                clientGeoSignedIsSigned = JSON(self.dictDrawSign["clientGeologistSignImageIsSigned"] as Any).boolValue
            }
            
            MyAppPhotoAlbum.shared.checkAuthorizationWithHandler { success in
                if success{
                    
                    for imageData in arrImages{
                        
                        debugPrint(imageData)
                        if let drawSigned = imageData["draw"] as? UIImage, let isSigned = imageData["isSigned"] as? Bool,isSigned{
                            debugPrint(self.isEditedDrawing)
                            if JSON(imageData["type"] as Any).stringValue == DrawingOCType.ocDrawing.rawValue ,let isEdited = imageData["isEdited"] as? Bool,isEdited{
                                MyAppPhotoAlbum.shared.save(image: drawSigned)
                            }
                            else if JSON(imageData["type"] as Any).stringValue == DrawingOCType.geologistSign.rawValue || JSON(imageData["type"] as Any).stringValue == DrawingOCType.clientGeologistSign.rawValue{
                                MyAppPhotoAlbum.shared.save(image: drawSigned)
                            }
                            
                        }
                    }
                }
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
                
                let drawImage = UploadDataModel(name: "image.jpeg", key: "image", data: drawImage.jpegData(compressionQuality: 1), extention: "jpeg", mimeType: "image/jpeg")
                
                let clientGeologistSignImage = UploadDataModel(name: "image.jpeg", key: "clientsGeologistSign", data: clientGeoSignedIsSigned ? clientGeoSigned.jpegData(compressionQuality: 1) : Data(), extention: "jpeg", mimeType: "image/jpeg")
                
                let geologistSignImage = UploadDataModel(name: "image.jpeg", key: "geologistSign", data: geoSignIsSigned ? geoSigned.jpegData(compressionQuality: 1) : Data(), extention: "jpeg", mimeType: "image/jpeg")
                
                var arr : [UploadDataModel] = []
                
                arr.append(drawImage)
                arr.append(clientGeologistSignImage)
                arr.append(geologistSignImage)
                
                parameters.imageDraaw = drawImage.name
                parameters.clientsGeologistSign = clientGeologistSignImage.name
                parameters.geologistSign = geologistSignImage.name
                
                debugPrint(parameters.toDictionary())
                
                
                self.viewModelSyncData.callAPIUploadOpenCastMappingReport(parameters: parameters.toDictionary(), uploadParameters: arr, completion: { completion,message  in
                    if completion{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0){
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
                                                                                    geoSignIsSigned ? geoSigned : nil,
                                                                                    clientGeoSignedIsSigned ? clientGeoSigned : nil,
                                                                                    drawImage) { completion in
                    
                    if completion{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0){
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
}


//--------------------------------------------------------------------------------------
// MARK: - UIColorPickerViewControllerDelegate Methods
//--------------------------------------------------------------------------------------
extension EditOpenCastMappingImagesVC: UIColorPickerViewControllerDelegate {
    
    //  Called once you have finished picking the color.
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.vwDrawPad.strokeColor = viewController.selectedColor
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.cancellable?.cancel()
            print(self.cancellable == nil)
        }
    }
    
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.vwDrawPad.strokeColor = viewController.selectedColor
        
    }
    
}
