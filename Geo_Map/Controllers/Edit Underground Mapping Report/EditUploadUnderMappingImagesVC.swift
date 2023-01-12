//
//  EditUploadUnderMappingImagesVC.swift
//  Geo_Map
//
//  Created by vishal parmar on 12/12/22.
//

import UIKit
import SignaturePad
import Combine

class EditUploadUnderMappingImagesVC:ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    
    @IBOutlet weak var lblContent : UILabel!
    
    @IBOutlet weak var vwDrawPad : SignaturePad!
    
    @IBOutlet weak var btnAdd : AppThemeBlueButton!
    @IBOutlet weak var btnClearDraw : AppThemeBorderBlueButton!
    
    @IBOutlet weak var stackView : UIStackView!
    
    @IBOutlet weak var lblImageTimeStamp : UILabel!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    
    var isOfflineDataUpdate : Bool = false
    var isDrawStart : Bool = Bool()
    var drawingType = DrawingType.roof.rawValue
    
    var arrDrawing : [[String:Any]] = [["title" : kROOF,"type" : DrawingType.roof.rawValue,"isDraw" : false,"draw_image" : UIImage(),"isEdited" : false],
                                       ["title" : kLEFT,"type" : DrawingType.left.rawValue,"isDraw" : false,"draw_image" : UIImage(),"isEdited" : false],
                                       ["title" : kRIGHT,"type" : DrawingType.right.rawValue,"isDraw" : false,"draw_image" : UIImage(),"isEdited" : false],
                                       ["title" : kFACE,"type" : DrawingType.face.rawValue,"isDraw" : false,"draw_image" : UIImage(),"isEdited" : false]]
    
    var underGroundMappingDetail : JSON = .null
    var viewModelSyncData : SyncDataVM = SyncDataVM()
    private var vmUGMappingReportDraft : UnderGroundMappingReportListDraftVM = UnderGroundMappingReportListDraftVM()
    
    
    var faceImage : UIImage?
    var roofImage : UIImage?
    var leftImage : UIImage?
    var rightImage : UIImage?
    
    var isEdited : Bool = false
    
    var cancellable : AnyCancellable?
    
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
    
    
    func setData(){
        for (i,_) in self.arrDrawing.enumerated(){
            
            if JSON(self.arrDrawing[i]["type"] as Any).stringValue == DrawingType.roof.rawValue, let _ = self.roofImage{
                self.arrDrawing[i]["draw_image"] = self.roofImage!
                self.arrDrawing[i]["isDraw"] = true
            }
            else if JSON(self.arrDrawing[i]["type"] as Any).stringValue == DrawingType.face.rawValue, let _ = self.faceImage{
                self.arrDrawing[i]["draw_image"] = self.faceImage!
                
            }
            else if JSON(self.arrDrawing[i]["type"] as Any).stringValue == DrawingType.left.rawValue, let _ = self.leftImage{
                self.arrDrawing[i]["draw_image"] = self.leftImage!
                
            }
            else if JSON(self.arrDrawing[i]["type"] as Any).stringValue == DrawingType.right.rawValue, let _ = self.rightImage{
                self.arrDrawing[i]["draw_image"] = self.rightImage!
                
            }
        }
        self.drawingType = DrawingType.roof.rawValue
        self.vwDrawPad.setSignature(_image: (self.arrDrawing.filter{JSON($0["type"] as Any).stringValue == DrawingType.roof.rawValue}.first!["draw_image"] as? UIImage)!)
        
        self.setBGGraph()
    }
    //Desc:- Set layout desing customize
    
    func configureUI(){
        self.view.backgroundColor = .colorBGSkyBlueLight
        self.title = kGeologicalMapping
        
        self.lblContent.applyLabelStyle(fontSize : 16,fontName : .InterBold)
        self.lblImageTimeStamp.applyLabelStyle(fontSize :  13,fontName : .InterSemibol,textColor : .white,bgColor : .colorSkyBlue)
        self.vwDrawPad.delegate = self
        
        self.vwDrawPad.isDisplay = true
        
        self.btnAdd.setTitle(kNext, for: .normal)
        self.btnClearDraw.setTitle(kClear, for: .normal)
        
        self.setData()
        self.buttonEnableDisable(true)
    }
    
    private func setBGGraph(){
        
        for (i,_) in self.arrDrawing.enumerated(){
            if JSON(self.arrDrawing[i]["type"] as Any).stringValue == self.drawingType{

                self.vwDrawPad.isDisplay = !JSON(self.arrDrawing[i]["isDraw"] as Any).boolValue
            }
        }
    }
    
    func buttonEnableDisable(_ isDrawn : Bool = false){
        self.isDrawStart = isDrawn
        self.btnAdd.isSelect = true//isDrawn
        
        switch self.drawingType {
            
        case DrawingType.roof.rawValue:
            
            self.lblContent.text = kROOF
            self.lblImageTimeStamp.text = "\(self.underGroundMappingDetail["ugDate"].stringValue)_UG_\(kROOF)_Image"
            self.btnAdd.setTitle(kNext, for: .normal)
            break
            
        case DrawingType.left.rawValue:
            
            self.lblContent.text = kLEFT
            self.lblImageTimeStamp.text = "\(self.underGroundMappingDetail["ugDate"].stringValue)_UG_\(kLEFT)_Image"
            self.btnAdd.setTitle(kNext, for: .normal)
            break
            
        case DrawingType.right.rawValue:
            
            self.lblContent.text = kRIGHT
            self.lblImageTimeStamp.text = "\(self.underGroundMappingDetail["ugDate"].stringValue)_UG_\(kRIGHT)_Image"
            self.btnAdd.setTitle(kNext, for: .normal)
            
            break
            
        default:
            
            self.lblContent.text = kFACE
            self.lblImageTimeStamp.text = "\(self.underGroundMappingDetail["ugDate"].stringValue)_UG_\(kFACE)_Image"
            self.btnAdd.setTitle(kSave, for: .normal)
            
            break
        }
        
        
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.vwDrawPad.clear()
        if self.drawingType == DrawingType.roof.rawValue{
            self.navigationController?.popViewController(animated: true)
        }
        else if self.drawingType == DrawingType.left.rawValue{
            self.drawingType = DrawingType.roof.rawValue
            self.vwDrawPad.setSignature(_image: (self.arrDrawing.filter{JSON($0["type"] as Any).stringValue == DrawingType.roof.rawValue}.first!["draw_image"] as? UIImage)!)
        }
        else if self.drawingType == DrawingType.right.rawValue{
            self.drawingType = DrawingType.left.rawValue
            self.vwDrawPad.setSignature(_image: (self.arrDrawing.filter{JSON($0["type"] as Any).stringValue == DrawingType.left.rawValue}.first!["draw_image"] as? UIImage)!)
        }
        else if self.drawingType == DrawingType.face.rawValue{
            self.drawingType = DrawingType.right.rawValue
            self.vwDrawPad.setSignature(_image: (self.arrDrawing.filter{JSON($0["type"] as Any).stringValue == DrawingType.right.rawValue}.first!["draw_image"] as? UIImage)!)
        }
        
        self.buttonEnableDisable(true)
        self.setBGGraph()
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
    
    @IBAction func btnAddDrawTapped(_ sender : UIButton){
        self.view.endEditing(true)
        
        if let image = self.vwDrawPad.getSignature()/*, self.vwDrawPad.isSigned*/{
            debugPrint(image)
            
            for (i,_) in self.arrDrawing.enumerated(){
                if JSON(self.arrDrawing[i]["type"] as Any).stringValue == self.drawingType, self.isEdited{
                    self.arrDrawing[i]["draw_image"] = image
                    self.arrDrawing[i]["isDraw"] = self.vwDrawPad.isSigned
                    self.arrDrawing[i]["isEdited"] = self.isEdited
                }
            }
            self.setBGGraph()
            self.isEdited = false
            switch self.drawingType {
                
            case DrawingType.roof.rawValue:
                
                self.drawingType = DrawingType.left.rawValue
                
                if let data = self.arrDrawing.filter({JSON($0["type"] as Any).stringValue == DrawingType.left.rawValue}).first, let img = data["draw_image"] as? UIImage{
                    self.vwDrawPad.setSignature(_image: img)
                    self.buttonEnableDisable(true)
                }
                
                break
                
            case DrawingType.left.rawValue:
                
                self.drawingType = DrawingType.right.rawValue
                self.vwDrawPad.setSignature(_image: (self.arrDrawing.filter{JSON($0["type"] as Any).stringValue == DrawingType.right.rawValue}.first!["draw_image"] as? UIImage)!)
                self.buttonEnableDisable(true)
                break
                
            case DrawingType.right.rawValue:
                
                self.drawingType = DrawingType.face.rawValue
                self.vwDrawPad.setSignature(_image: (self.arrDrawing.filter{JSON($0["type"] as Any).stringValue == DrawingType.face.rawValue}.first!["draw_image"] as? UIImage)!)
                self.buttonEnableDisable(true)
                
                break
                
            default:
            
                var rootImg = UIImage()
                var leftImg = UIImage()
                var rightImg = UIImage()
                var faceImg = UIImage()
                
                if let rootImageData = self.arrDrawing.filter({JSON($0["type"] as Any).stringValue == DrawingType.roof.rawValue}).first, let rootImage = rootImageData["draw_image"] as? UIImage{
                    
                    rootImg = rootImage
                }
                if let leftImageData = self.arrDrawing.filter({JSON($0["type"] as Any).stringValue == DrawingType.left.rawValue}).first, let leftImage = leftImageData["draw_image"] as? UIImage{
                    
                    leftImg = leftImage
                }
                if let rightImageData = self.arrDrawing.filter({JSON($0["type"] as Any).stringValue == DrawingType.right.rawValue}).first, let rightImage = rightImageData["draw_image"] as? UIImage{
                    
                    rightImg = rightImage
                }
                if let faceImageData = self.arrDrawing.filter({JSON($0["type"] as Any).stringValue == DrawingType.face.rawValue}).first, let faceImage = faceImageData["draw_image"] as? UIImage{
                    
                    faceImg = faceImage
                }
                
                if self.isOfflineDataUpdate{
                    
                }
                else{
                    
                }
                self.callAPIOrSavedOffline()
                
                break
            }
        }
//        self.setBGGraph()
    }
    
    @IBAction func btnClearDrawTapped(_ sender : UIButton){
        self.view.endEditing(true)
        self.vwDrawPad.clear()
        self.isEdited = false
        for (i,_) in self.arrDrawing.enumerated(){
            if JSON(self.arrDrawing[i]["type"] as Any).stringValue == self.drawingType{
                self.arrDrawing[i]["draw_image"] = self.vwDrawPad.getSignature()
                self.arrDrawing[i]["isDraw"] = self.vwDrawPad.isSigned
                self.arrDrawing[i]["isEdited"] = self.isEdited
            }
        }
        
//        self.vwDrawPad.clear()
        self.buttonEnableDisable()
        self.setBGGraph()
    }
    
    
    
    
    
    //----------------------------------------------------------------------------
    //MARK: - View life cycle
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
extension EditUploadUnderMappingImagesVC : SignaturePadDelegate{
    
    func didStart() {
        
        //        self.buttonEnableDisable()
    }
    
    func didFinish() {
        self.isEdited = true
        self.buttonEnableDisable(true)
    }
}


//--------------------------------------------------------------------------------------
// MARK: - API Calling Methods
//--------------------------------------------------------------------------------------
extension EditUploadUnderMappingImagesVC{
    
    
    func callAPIOrSavedOffline()
    {
        showHud()
        
        var rootImage = UIImage()
        var leftImage = UIImage()
        var rightImage = UIImage()
        var faceImage = UIImage()
        var faceImageObj = UploadDataModel()
        var rightImageObj = UploadDataModel()
        var leftImageObj = UploadDataModel()
        var rootImageObj = UploadDataModel()
        
        for imageData2 in self.arrDrawing{
    
            if let img = imageData2["draw_image"] as? UIImage{
                if JSON(imageData2["title"] as Any).stringValue == kROOF{
                    rootImage = img
                    rootImageObj = UploadDataModel(name: "image.jpeg", key: "roofImage", data: rootImage.jpegData(compressionQuality: 1), extention: "jpeg", mimeType: "image/jpeg")
                }
                else if JSON(imageData2["title"] as Any).stringValue == kRIGHT{
                    rightImage = img
                    rightImageObj = UploadDataModel(name: "image.jpeg", key: "rightImage", data: rightImage.jpegData(compressionQuality: 1), extention: "jpeg", mimeType: "image/jpeg")
                }
                else if JSON(imageData2["title"] as Any).stringValue == kLEFT{
                    leftImage = img
                    leftImageObj = UploadDataModel(name: "image.jpeg", key: "leftImage", data: leftImage.jpegData(compressionQuality: 1), extention: "jpeg", mimeType: "image/jpeg")
                }
                else if JSON(imageData2["title"] as Any).stringValue == kFACE{
                    faceImage = img
                    faceImageObj = UploadDataModel(name: "image.jpeg", key: "faceImage", data: faceImage.jpegData(compressionQuality: 1), extention: "jpeg", mimeType: "image/jpeg")
                }
            }
        }
       
        MyAppPhotoAlbum.shared.saveImagesInGallary { success in
            
            MyAppPhotoAlbum.shared.checkAuthorizationWithHandler { success in
                if success{
                    
                    for imageData2 in self.arrDrawing{
                        
                        if JSON(imageData2["isDraw"] as Any).boolValue, let img = imageData2["draw_image"] as? UIImage{
                            
                            
                            debugPrint(imageData2)
                            if let isEdited = imageData2["isEdited"] as? Bool,isEdited{
                                MyAppPhotoAlbum.shared.save(image: img)
                            }
                            
                        }
                    }
                }
            }
            
            if !self.isOfflineDataUpdate{
                
                let arrUploadDataModel : [UploadDataModel] = [faceImageObj,rightImageObj,leftImageObj,rootImageObj]
                
                var arrOfDict : [[String:Any]] = [[String:Any]]()
                let _ = self.underGroundMappingDetail["attributes"].arrayValue.compactMap({ obj in
                    
                    var dict = [String:Any]()
                    dict["name"] = obj["name"].stringValue
                    dict["nose"]  = obj["nose"].stringValue
                    dict["properties"] = obj["properties"].stringValue
                    
                    arrOfDict.append(dict)
                })
                
                let dictionary : [String:Any] = [
                    "shift" : self.underGroundMappingDetail["shift"].stringValue,
                    "mappedBy" : self.underGroundMappingDetail["mappedBy"].stringValue,
                    "name" : self.underGroundMappingDetail["name"].stringValue,
                    "scale" : self.underGroundMappingDetail["scale"].stringValue,
                    "location" : self.underGroundMappingDetail["locations"].stringValue,
                    "venieLoad" : self.underGroundMappingDetail["veinOrLoad"].stringValue,
                    "xCordinate" : self.underGroundMappingDetail["xCoordinate"].stringValue,
                    "yCordinate" : self.underGroundMappingDetail["yCoordinate"].stringValue,
                    "zCordinate" : self.underGroundMappingDetail["zCoordinate"].stringValue,
                    "mapSerialNo" : self.underGroundMappingDetail["mapSerialNo"].stringValue,
                    "ugDate" : self.underGroundMappingDetail["ugDate"].stringValue,
                    "comment" : self.underGroundMappingDetail["comment"].stringValue,
                    "faceImage" : faceImageObj.name,
                    "rightImage" : rightImageObj.name,
                    "leftImage" : leftImageObj.name,
                    "roofImage" : rootImageObj.name,
                    "userId" : JSON(UserModelClass.current.userId as Any).stringValue,
                    "attribute" : arrOfDict.toJSON()!
                ]
                
                debugPrint(dictionary)
                
                self.viewModelSyncData.callAPIUploadUnderGroungMappingReport(parameters: dictionary, uploadParameters: arrUploadDataModel) { completion,message in
                    if completion{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0){
                            AppDelegate.shared.updateWindow(.home)
                            GFunctions.shared.showSnackBar(message: JSON(message as Any).stringValue)
                        }
                    }
                    else{
                        GFunctions.shared.showSnackBar(message: JSON(message as Any).stringValue)
                    }
                    hideHud()
                }
            }
            else{
                
                UnderGroundMappingReportDataModel.shared.editUnderGroundMappingReportData(JSON(UserModelClass.current.userId as Any).stringValue,
                                                                                          self.underGroundMappingDetail["mapSerialNo"].stringValue,
                                                                                          self.underGroundMappingDetail["name"].stringValue,
                                                                                          self.underGroundMappingDetail["ugDate"].stringValue,
                                                                                          self.underGroundMappingDetail["shift"].stringValue,
                                                                                          self.underGroundMappingDetail["mappedBy"].stringValue,
                                                                                          self.underGroundMappingDetail["scale"].stringValue,
                                                                                          self.underGroundMappingDetail["locations"].stringValue,
                                                                                          self.underGroundMappingDetail["veinOrLoad"].stringValue,
                                                                                          self.underGroundMappingDetail["xCoordinate"].stringValue,
                                                                                          self.underGroundMappingDetail["yCoordinate"].stringValue,
                                                                                          self.underGroundMappingDetail["zCoordinate"].stringValue,
                                                                                          self.underGroundMappingDetail["attributes"].arrayValue,
                                                                                          rootImage,
                                                                                          leftImage,
                                                                                          rightImage,
                                                                                          faceImage,
                                                                                          self.underGroundMappingDetail["comment"].stringValue) { completion in
                    
                    if completion{
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            //                        AppDelegate.shared.updateWindow(.home)
                            //                        GFunctions.shared.showSnackBar(message: kUnderGroundMappingReportSavedSuccessfully)
                            
                            self.vmUGMappingReportDraft.getUnderGroundMappingReportList { completion in
                                if completion{
                                    let dict : JSON = ["offline_id" : self.underGroundMappingDetail["mapSerialNo"].stringValue]
                                    
                                    guard let _ = self.navigationController else {return}
                                    for previousVC in self.navigationController!.viewControllers{
                                        
                                        if previousVC.isKind(of: UnderGroundReportOfflineDetailVC.self){
                                            NotificationCenter.default.post(name: NSNotification.Name.updateUGOfflineReport, object: dict)
                                            self.navigationController?.popToViewController(previousVC, animated: true)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    hideHud()
                }
            }
        }
    }
}

//--------------------------------------------------------------------------------------
// MARK: - UIColorPickerViewControllerDelegate Methods
//--------------------------------------------------------------------------------------
extension EditUploadUnderMappingImagesVC: UIColorPickerViewControllerDelegate {
    
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
