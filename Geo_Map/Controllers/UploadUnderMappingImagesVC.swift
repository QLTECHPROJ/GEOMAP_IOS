//
//  UploadUnderMappingImagesVC.swift


import UIKit
import SignaturePad
import Combine

enum DrawingType : String{
    case roof = "Roof"
    case left = "Left"
    case right = "Right"
    case face = "Face"
}

class UploadUnderMappingImagesVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    
    @IBOutlet weak var lblContent : UILabel!
    
    @IBOutlet weak var vwDrawPad : SignaturePad!
    
    @IBOutlet weak var btnAdd : AppThemeBlueButton!
    @IBOutlet weak var btnClearDraw : AppThemeBorderBlueButton!
    
    @IBOutlet weak var stackView : UIStackView!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    
    var isDrawStart : Bool = Bool()
    var drawingType = DrawingType.roof.rawValue
    
    var arrDrawing : [[String:Any]] = [["title" : kROOF,"type" : DrawingType.roof.rawValue,"isDraw" : false,"draw_image" : UIImage()],
                                       ["title" : kLEFT,"type" : DrawingType.left.rawValue,"isDraw" : false,"draw_image" : UIImage()],
                                       ["title" : kRIGHT,"type" : DrawingType.right.rawValue,"isDraw" : false,"draw_image" : UIImage()],
                                       ["title" : kFACE,"type" : DrawingType.face.rawValue,"isDraw" : false,"draw_image" : UIImage()]]
    
    var underGroundMappingDetail : JSON = .null
    var viewModelSyncData : SyncDataVM = SyncDataVM()
    
    var cancellable: AnyCancellable?

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
        
        self.vwDrawPad.isDisplay = true
        
        self.lblContent.applyLabelStyle(fontSize : 16,fontName : .InterBold)
        self.vwDrawPad.delegate = self
        
        self.btnAdd.setTitle(kNext, for: .normal)
        self.btnClearDraw.setTitle(kClear, for: .normal)
        
        self.buttonEnableDisable()
    }
    
    func buttonEnableDisable(_ isDrawn : Bool = false){
        self.isDrawStart = isDrawn
        self.btnAdd.isSelect = isDrawn
        
        switch self.drawingType {
            
        case DrawingType.roof.rawValue:
            
            self.lblContent.text = kROOF
            self.btnAdd.setTitle(kNext, for: .normal)
            break
            
        case DrawingType.left.rawValue:
            
            self.lblContent.text = kLEFT
            
            self.btnAdd.setTitle(kNext, for: .normal)
            break
            
        case DrawingType.right.rawValue:
            
            self.lblContent.text = kRIGHT
            self.btnAdd.setTitle(kNext, for: .normal)
            
            break
            
        default:
            self.btnAdd.setTitle(kSubmit, for: .normal)
            self.lblContent.text = kFACE
            
            
            break
        }
        
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    @IBAction func btnBackTapped(_ sender : Any){
        
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
    }
    
    @IBAction func btnAddDrawTapped(_ sender : UIButton){
        self.view.endEditing(true)
        if let image = self.vwDrawPad.getSignature(){
            debugPrint(image)
            
            for (i,_) in self.arrDrawing.enumerated(){
                if JSON(self.arrDrawing[i]["type"] as Any).stringValue == self.drawingType{
                    self.arrDrawing[i]["draw_image"] = image
                    self.arrDrawing[i]["isDraw"] = true
                }
            }
            
            switch self.drawingType {
                
            case DrawingType.roof.rawValue:
                
                self.drawingType = DrawingType.left.rawValue
                break
                
            case DrawingType.left.rawValue:
                
                self.drawingType = DrawingType.right.rawValue
                break
                
            case DrawingType.right.rawValue:
                
                self.drawingType = DrawingType.face.rawValue
                
                break
                
            default:
                //                self.stackView.isHidden = true
                
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
                self.callAPIOrSavedOffline(rootImg, leftImg, rightImg, faceImg)
                break
            }
        }
        self.vwDrawPad.clear()
        self.buttonEnableDisable()
    }
    
    @IBAction func btnClearDrawTapped(_ sender : UIButton){
        self.view.endEditing(true)
        
        for (i,_) in self.arrDrawing.enumerated(){
            if JSON(self.arrDrawing[i]["type"] as Any).stringValue == self.drawingType{
                self.arrDrawing[i]["draw_image"] = UIImage()
                self.arrDrawing[i]["isDraw"] = false
            }
        }
        
        self.vwDrawPad.clear()
        self.buttonEnableDisable()
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
extension UploadUnderMappingImagesVC : SignaturePadDelegate{
    
    func didStart() {
        
        //        self.buttonEnableDisable()
    }
    
    func didFinish() {
        
        self.buttonEnableDisable(true)
    }
}


//--------------------------------------------------------------------------------------
// MARK: - API Calling Methods
//--------------------------------------------------------------------------------------
extension UploadUnderMappingImagesVC{
    
    func callAPIOrSavedOffline(_ rootImage : UIImage, _ leftImage : UIImage, _ rightImage : UIImage, _ faceImage : UIImage)
    {
        
        var arrImages : [UIImage] = [rootImage,leftImage,rightImage,faceImage]
        for imageData in arrImages{
            
//            if let image = imageData{
                MyAppPhotoAlbum.shared.save(image: imageData)
//            }
        }
        
        if checkInternet(true){
            
            let faceImageObj = UploadDataModel(name: "image.jpeg", key: "faceImage", data: faceImage.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            let rightImageObj = UploadDataModel(name: "image.jpeg", key: "rightImage", data: rightImage.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            let leftImageObj = UploadDataModel(name: "image.jpeg", key: "leftImage", data: leftImage.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            let rootImageObj = UploadDataModel(name: "image.jpeg", key: "roofImage", data: rootImage.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            
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
                "mapSerialNo" : "",//self.underGroundMappingDetail["mapSerialNo"].stringValue,
                "ugDate" : GFunctions.shared.convertDateFormat(dt: self.underGroundMappingDetail["ugDate"].stringValue, inputFormat: DateTimeFormaterEnum.ddmm_yyyy.rawValue, outputFormat: DateTimeFormaterEnum.ddMMMyyyy.rawValue, status: .NOCONVERSION).str,
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        AppDelegate.shared.updateWindow(.home)
                        GFunctions.shared.showSnackBar(message: JSON(message as Any).stringValue)
                    }
                }
                else{
                    GFunctions.shared.showSnackBar(message: JSON(message as Any).stringValue)
                }
            }
        }
        else{
            
            UnderGroundMappingReportDataModel.shared.insertUnderGroundMappingReportData(JSON(UserModelClass.current.userId as Any).stringValue,
//                                                                                        self.underGroundMappingDetail["iD"].stringValue,
//                                                                                        self.underGroundMappingDetail["iD"].stringValue,
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
                        AppDelegate.shared.updateWindow(.home)
                        GFunctions.shared.showSnackBar(message: kUnderGroundMappingReportSavedSuccessfully)
                    }
                }
            }
        }
    }
}


//--------------------------------------------------------------------------------------
// MARK: - UIColorPickerViewControllerDelegate Methods
//--------------------------------------------------------------------------------------
extension UploadUnderMappingImagesVC: UIColorPickerViewControllerDelegate {
    
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
