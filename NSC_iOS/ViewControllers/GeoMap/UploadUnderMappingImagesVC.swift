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
                self.stackView.isHidden = true

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
                
                UnderGroundMappingReportDataModel.shared.insertUnderGroundMappingReportData(self.underGroundMappingDetail["iD"].stringValue, self.underGroundMappingDetail["mapSerialNo"].stringValue, self.underGroundMappingDetail["ugDate"].stringValue, self.underGroundMappingDetail["shift"].stringValue, self.underGroundMappingDetail["mappedBy"].stringValue, self.underGroundMappingDetail["scale"].stringValue, self.underGroundMappingDetail["locations"].stringValue, self.underGroundMappingDetail["veinOrLoad"].stringValue, self.underGroundMappingDetail["xCoordinate"].stringValue, self.underGroundMappingDetail["yCoordinate"].stringValue, self.underGroundMappingDetail["zCoordinate"].stringValue, self.underGroundMappingDetail["attributes"].arrayValue, rootImg, leftImg, rightImg, faceImg) { completion in
                    
                    if completion{
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            AppDelegate.shared.updateWindow(.home)
                            GFunctions.shared.showSnackBar(message: kUnderGroundMappingReportSavedSuccessfully)
                        }
                    }
                }
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
