//
//  UploadUnderMappingImagesVC.swift
//  NSC_iOS
//
//  Created by vishal parmar on 27/10/22.
//

import UIKit
import SignaturePad


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
        
        self.vwDrawPad.delegate = self
        
        self.btnAdd.setTitle(kAdd, for: .normal)
        self.btnClearDraw.setTitle(kClear, for: .normal)
       
        
        self.buttonEnableDisable()
    }
    
    func buttonEnableDisable(_ isDrawn : Bool = false){
        self.isDrawStart = isDrawn
        self.btnAdd.isSelect = isDrawn
       
        switch self.drawingType {
            
        case DrawingType.roof.rawValue:
            
            self.title = kROOF
            
            break
            
        case DrawingType.left.rawValue:
            
            self.title = kLEFT
            
            break
            
        case DrawingType.right.rawValue:
            
            self.title = kRIGHT
            
            break
            
        default:
            self.btnAdd.setTitle(kSubmit, for: .normal)
            self.title = kFACE
            
            break
        }
        
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
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
        
        if checkInternet(true){
            
            let parameters = APIParametersModel()
            parameters.shift = self.underGroundMappingDetail["shift"].stringValue
            parameters.mappedBy = self.underGroundMappingDetail["mappedBy"].stringValue
            parameters.name = self.underGroundMappingDetail["name"].stringValue
            parameters.scale = self.underGroundMappingDetail["scale"].stringValue
            parameters.location = self.underGroundMappingDetail["locations"].stringValue
            parameters.venieLoad = self.underGroundMappingDetail["veinOrLoad"].stringValue
            parameters.xCordinate = self.underGroundMappingDetail["xCoordinate"].stringValue
            parameters.yCordinate = self.underGroundMappingDetail["yCoordinate"].stringValue
            parameters.zCordinate = self.underGroundMappingDetail["zCoordinate"].stringValue
            parameters.mapSerialNo = self.underGroundMappingDetail["mapSerialNo"].stringValue
            parameters.ugDate = GFunctions.shared.convertDateFormat(dt: self.underGroundMappingDetail["ugDate"].stringValue, inputFormat: DateTimeFormaterEnum.ddmm_yyyy.rawValue, outputFormat: DateTimeFormaterEnum.ddMMMyyyy.rawValue, status: .NOCONVERSION).str
            parameters.comment = self.underGroundMappingDetail["comment"].stringValue
                    
            let faceImageObj = UploadDataModel(name: "image.jpeg", key: "faceImage", data: faceImage.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            let rightImageObj = UploadDataModel(name: "image.jpeg", key: "rightImage", data: rightImage.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            let leftImageObj = UploadDataModel(name: "image.jpeg", key: "leftImage", data: leftImage.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            let rootImageObj = UploadDataModel(name: "image.jpeg", key: "roofImage", data: rootImage.jpegData(compressionQuality: 0.5), extention: "jpeg", mimeType: "image/jpeg")
            
            parameters.attribute = self.underGroundMappingDetail["attributes"].arrayValue.compactMap({ obj -> Attribute in
                let attributeObj = Attribute()
                attributeObj.name = obj["name"].stringValue
                attributeObj.nose = obj["nose"].stringValue
                attributeObj.properties = obj["properties"].stringValue
                return attributeObj
            })
            
            parameters.faceImage = faceImageObj.name
            parameters.rightImage = rightImageObj.name
            parameters.leftImage = leftImageObj.name
            parameters.roofImage = rootImageObj.name
                   
            let arrUploadDataModel : [UploadDataModel] = [faceImageObj,rightImageObj,leftImageObj,rootImageObj]
            parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
            
            /*
             attribute
             name
             nose

             properties
             */
            debugPrint(parameters.toDictionary())
            
            self.viewModelSyncData.callAPIUploadUnderGroungMappingReport(parameters: parameters.toDictionary(), uploadParameters: arrUploadDataModel) { completion,message in
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
            UnderGroundMappingReportDataModel.shared.insertUnderGroundMappingReportData(self.underGroundMappingDetail["iD"].stringValue, self.underGroundMappingDetail["mapSerialNo"].stringValue,self.underGroundMappingDetail["name"].stringValue, self.underGroundMappingDetail["ugDate"].stringValue, self.underGroundMappingDetail["shift"].stringValue, self.underGroundMappingDetail["mappedBy"].stringValue, self.underGroundMappingDetail["scale"].stringValue, self.underGroundMappingDetail["locations"].stringValue, self.underGroundMappingDetail["veinOrLoad"].stringValue, self.underGroundMappingDetail["xCoordinate"].stringValue, self.underGroundMappingDetail["yCoordinate"].stringValue, self.underGroundMappingDetail["zCoordinate"].stringValue, self.underGroundMappingDetail["attributes"].arrayValue, rootImage, leftImage, rightImage, faceImage,self.underGroundMappingDetail["comment"].stringValue) { completion in
                
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
