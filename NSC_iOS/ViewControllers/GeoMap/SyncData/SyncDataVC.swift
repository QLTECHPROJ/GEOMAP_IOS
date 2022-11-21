//
//  SyncDataVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 14/10/22.
//

import UIKit

class SyncDataVC: ClearNaviagtionBarVC {
    
    
    @IBOutlet weak var lblInstruction : UILabel!
    
    @IBOutlet weak var btnSyncData  : AppThemeBlueButton!
    
    
    
    //MARK: - Variables
    
    var arrUnderGroundReport : [UndergroundReport] = []
    
    var arrOpenCastReport : [OpenCastReport] = []
    
    var viewModelSyncData : SyncDataVM = SyncDataVM()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        self.setupUI()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.view.backgroundColor = .colorBGSkyBlueLight
        
        self.lblInstruction.applyLabelStyle(text : kSyncDataInstrution,fontSize : 16,fontName : .InterSemibol)
        
        self.btnSyncData.isSelect = true
        self.btnSyncData.setTitle(kSyncData, for: .normal)
        self.btnSyncData.setContentEdges(ImageEngesLeft : -20)
    }
    
    
    
    // MARK: - ACTION
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSyncDataTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
        
        var arrUnderGroundDraftReportList : [UnderGroundMappingReportDataTable] = []
        
        UnderGroundMappingReportDataModel.shared.getUndergroundMappingReportData { completion in
            if completion{
                arrUnderGroundDraftReportList = UnderGroundMappingReportDataModel.shared.arrUnderGroundMappingReportData
            }
        }
        
        
        var arrOpenCastDraftReportList : [OpenCastMappingReportDataTable] = []
        
        OpenCastMappingReportDataModel.shared.getOpenCastMappingReportData { completion in
            if completion{
                arrOpenCastDraftReportList = OpenCastMappingReportDataModel.shared.arrOpenCastMappingReportData
                
            }
        }
        
        let finalParameters = APIParametersModel()
        finalParameters.underGroundReport = self.setUnderGroundReportList(arrUnderGroundDraftReportList)
        finalParameters.openCastReport = self.setOpenCastReportList(arrOpenCastDraftReportList).openCastDetails
        
        debugPrint(finalParameters.toDictionary())
        
        self.viewModelSyncData.callAPISyncData(parameters: finalParameters.toDictionary()) { responseJSON, statucCode, message, completion in
           if completion{
            
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                   self.navigationController?.popViewController(animated: true)
                   GFunctions.shared.showSnackBar(message: JSON(message as Any).stringValue)
               }
            }
            else if let _ = message{
                GFunctions.shared.showSnackBar(message: message!)
            }
        }
    }
    
}


extension SyncDataVC{
    
    func setUnderGroundReportList(_ underGroundReport : [UnderGroundMappingReportDataTable])->[UndergroundReport]{
        
        var arrUnderGroundDraftReportList : [UndergroundReport] = []
        var arrUploadImages : [UploadDataModel] = []
        
        for data in underGroundReport{
            
            let parameters = UndergroundReport()
            parameters.shift = JSON(data.shift as Any).stringValue
            parameters.mappedBy = JSON(data.mappedBy as Any).stringValue
            parameters.name = JSON(data.name as Any).stringValue
            parameters.comment = JSON(data.comment as Any).stringValue
            parameters.scale = JSON(data.scale as Any).stringValue
            parameters.location = JSON(data.locations as Any).stringValue
            parameters.venieLoad = JSON(data.veinOrLoad as Any).stringValue
            parameters.xCordinate = JSON(data.xCoordinate as Any).stringValue
            parameters.yCordinate = JSON(data.yCoordinate as Any).stringValue
            parameters.zCordinate = JSON(data.zCoordinate as Any).stringValue
            parameters.mapSerialNo = JSON(data.mapSerialNo as Any).stringValue
            parameters.ugDate = GFunctions.shared.convertDateFormat(dt: JSON(data.ugDate as Any).stringValue, inputFormat: DateTimeFormaterEnum.ddmm_yyyy.rawValue, outputFormat: DateTimeFormaterEnum.ddMMMyyyy.rawValue, status: .NOCONVERSION).str
            parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
            
            parameters.faceImage = UploadDataModel(name: "image.jpeg", key: "faceImage", data: data.faceImage, extention: "jpeg", mimeType: "image/jpeg").name
            parameters.rightImage = UploadDataModel(name: "image.jpeg", key: "rightImage", data: data.rightImage, extention: "jpeg", mimeType: "image/jpeg").name
            parameters.leftImage = UploadDataModel(name: "image.jpeg", key: "leftImage", data: data.leftImage, extention: "jpeg", mimeType: "image/jpeg").name
            parameters.roofImage = UploadDataModel(name: "image.jpeg", key: "roofImage", data: data.roofImage, extention: "jpeg", mimeType: "image/jpeg").name
            
            var attributesArr : [Attribute] = []
            if let attAry = data.attributeUndergroundMapping,let attArray = attAry.allObjects as? [AttributeUndergroundMappingTable]{
                for att in attArray{
                
                    let attributeObj = Attribute()
                    attributeObj.name = JSON(att.name as Any).stringValue
                    attributeObj.nose = JSON(att.nose as Any).stringValue
                    attributeObj.properties = JSON(att.properties as Any).stringValue
                    attributesArr.append(attributeObj)
                }
            }
            parameters.attribute = attributesArr
            
            arrUnderGroundDraftReportList.append(parameters)
        }
        
        return arrUnderGroundDraftReportList
    }
    
    
    func setOpenCastReportList(_ openCastReports : [OpenCastMappingReportDataTable])->(openCastDetails : [OpenCastReport], arrImages : [UploadDataModel]){
        
        var arrOpenCastDraftReportList : [OpenCastReport] = []
       
        var arrUploadImages : [UploadDataModel] = []
        for data in openCastReports{
            
            let parameters = OpenCastReport()
            parameters.minesSiteName = JSON(data.minesSiteName as Any).stringValue
            parameters.mappingSheetNo = JSON(data.mappingSheetNo as Any).stringValue
            parameters.pitName = JSON(data.pitName as Any).stringValue
            parameters.pitLoaction = JSON(data.pitLocation as Any).stringValue
            parameters.shiftInchargeName = JSON(data.shiftInChargeName as Any).stringValue
            parameters.geologistName = JSON(data.geologistName as Any).stringValue
            parameters.faceLocation = JSON(data.faceLocation as Any).stringValue
            parameters.faceLength = JSON(data.faceLength as Any).stringValue
            parameters.faceArea = JSON(data.faceArea as Any).stringValue
            parameters.faceRockType = JSON(data.faceRockTypes as Any).stringValue
            parameters.benchRl = JSON(data.benchRL as Any).stringValue
            parameters.benchHeightWidth = JSON(data.benchHeightWidth as Any).stringValue
            parameters.benchAngle = JSON(data.benchAngle as Any).stringValue
            parameters.thicknessOfOre = JSON(data.thicknessOfOre as Any).stringValue
            parameters.thicknessOfOverburdan = JSON(data.thicknessOfOverburden as Any).stringValue
            parameters.thicknessOfInterburden = JSON(data.thicknessOfInterBurden as Any).stringValue
            parameters.observedGradeOfOre = JSON(data.observedGradeOfOre as Any).stringValue
            parameters.sampleColledted = JSON(data.sampleCollected as Any).stringValue
            parameters.actualGradeOfOre = JSON(data.actualGradOfOre as Any).stringValue
            parameters.weathring = JSON(data.weathering as Any).stringValue
            parameters.rockStregth = JSON(data.rockStrength as Any).stringValue
            parameters.waterCondition = JSON(data.waterCondition as Any).stringValue
            parameters.typeOfGeologist = JSON(data.typeOfGeologicalStructures as Any).stringValue
            parameters.typeOfFaults = JSON(data.typeOfFaults as Any).stringValue
            
            parameters.shift = JSON(data.shift as Any).stringValue
            parameters.ocDate = GFunctions.shared.convertDateFormat(dt: JSON(data.ocDate as Any).stringValue, inputFormat: DateTimeFormaterEnum.ddmm_yyyy.rawValue, outputFormat: DateTimeFormaterEnum.ddMMMyyyy.rawValue, status: .NOCONVERSION).str
            
            parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
            parameters.dipDirectionAndAngle = JSON(data.dipdirectionandAngle as Any).stringValue
            parameters.notes = JSON(data.notes as Any).stringValue
            
            let imageDraw = UploadDataModel(name: "image.jpeg", key: "image", data: data.imagedrawn, extention: "jpeg", mimeType: "image/jpeg")
            arrUploadImages.append(imageDraw)
            parameters.image = imageDraw.name
            
            let clientGeologistSign = UploadDataModel(name: "image.jpeg", key: "clientsGeologistSign", data: data.clientsGeologistSign, extention: "jpeg", mimeType: "image/jpeg")
            arrUploadImages.append(clientGeologistSign)
            parameters.clientsGeologistSign = clientGeologistSign.name
            
            let geologistSign = UploadDataModel(name: "image.jpeg", key: "geologistSign", data: data.geologistSign, extention: "jpeg", mimeType: "image/jpeg")
            arrUploadImages.append(geologistSign)
            parameters.geologistSign = geologistSign.name
            
            arrOpenCastDraftReportList.append(parameters)
        }
        
        return (arrOpenCastDraftReportList,arrUploadImages)
    }
}

