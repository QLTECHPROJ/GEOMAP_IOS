//
//  SyncDataVC.swift

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
    
        
        let arrUnderGroundReportList : [UnderGroundMappingReportDataTable] = self.getReportListFromOfflineDatabase().underGroundReportList
        let arrOpenCastReportList : [OpenCastMappingReportDataTable] = self.getReportListFromOfflineDatabase().openCastReportList
        
        
        guard checkInternet() else {
            
            
            GFunctions.shared.showSnackBar(message: kSyncDataWithNoInternetConnection)
            return
            
        }
        
        guard !arrUnderGroundReportList.isEmpty || !arrOpenCastReportList.isEmpty else {
            GFunctions.shared.showSnackBar(message: kNoOfflineReportFound)
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let dispatchGroup = DispatchGroup()
        showHud()
        for uGReportData in arrUnderGroundReportList{
            dispatchGroup.enter()
            
            let uGReport = self.getUnderGroundReportDetailsParameters(underGroundReportDetail: uGReportData)
            
            self.viewModelSyncData.callAPIUploadUnderGroungMappingReport(isLoader : false,parameters: uGReport.underGroundParam, uploadParameters: uGReport.arrUnderGroundImages) { completion, message in
                
                if completion{
                    
                    UnderGroundMappingReportDataModel.shared.deleteUnderGroundMappingReportData(JSON(uGReportData.mapSerialNo as Any).stringValue) { completion in
                        
                        if completion{
                            
                        }
                    }
                }
                dispatchGroup.leave()
            }
        }
        
        for oCReportData in arrOpenCastReportList{
            dispatchGroup.enter()
            
            let uCReport = self.getOpenCastReportDetailsParameters(openCastReportDetail: oCReportData)
            self.viewModelSyncData.callAPIUploadOpenCastMappingReport(isLoader : false,parameters: uCReport.openCastParam, uploadParameters: uCReport.arrOpenCastImages, completion: { completion,message  in
                
                if completion{
                   
                    OpenCastMappingReportDataModel.shared.deleteOpenCastMappingReportData(JSON(oCReportData.mappingSheetNo as Any).stringValue) { completion in
                       
                        if completion{
                            
                        }
                    }
                }
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: .main) {
            hideHud()
            
            GFunctions.shared.showSnackBar(message: kAllDataHasBeenSynchronised)
            
            NotificationCenter.default.post(name: NSNotification.Name.reloadUGOCReportList, object: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

//----------------------------------------------------------------------------
// MARK: - Get parameters methods
//----------------------------------------------------------------------------
extension SyncDataVC{
    
    func getReportListFromOfflineDatabase()-> (underGroundReportList : [UnderGroundMappingReportDataTable], openCastReportList : [OpenCastMappingReportDataTable]){
       
        
        UnderGroundMappingReportDataModel.shared.getUndergroundMappingReportData { completion in
            if completion{
               debugPrint("UnderGround report list found")
            }
        }
        
        OpenCastMappingReportDataModel.shared.getOpenCastMappingReportData { completion in
            if completion{
                debugPrint("OpenCast report list found")
            }
        }
        return (UnderGroundMappingReportDataModel.shared.arrUnderGroundMappingReportData,OpenCastMappingReportDataModel.shared.arrOpenCastMappingReportData)
    }
    
    func getUnderGroundReportDetailsParameters(underGroundReportDetail : UnderGroundMappingReportDataTable)-> (underGroundParam : [String:Any],arrUnderGroundImages : [UploadDataModel]){
        
       
        var arrOfDict : [[String:Any]] = [[String:Any]]()
        if let attAry = underGroundReportDetail.attributeUndergroundMapping,let attArray = attAry.allObjects as? [AttributeUndergroundMappingTable]{
            for att in attArray{
                
                var dict = [String:Any]()
                dict["name"] = JSON(att.name as Any).stringValue
                dict["nose"]  = JSON(att.nose as Any).stringValue
                dict["properties"] = JSON(att.properties as Any).stringValue
                arrOfDict.append(dict)
            }
        }
        let faceImageObj = UploadDataModel(name: "image.jpeg", key: "faceImage", data: underGroundReportDetail.faceImage, extention: "jpeg", mimeType: "image/jpeg")
        let rightImageObj = UploadDataModel(name: "image.jpeg", key: "rightImage", data: underGroundReportDetail.rightImage, extention: "jpeg", mimeType: "image/jpeg")
        let leftImageObj = UploadDataModel(name: "image.jpeg", key: "leftImage", data: underGroundReportDetail.leftImage, extention: "jpeg", mimeType: "image/jpeg")
        let rootImageObj = UploadDataModel(name: "image.jpeg", key: "roofImage", data: underGroundReportDetail.roofImage, extention: "jpeg", mimeType: "image/jpeg")
        
        let arrUploadDataModelForUGR : [UploadDataModel] = [faceImageObj,rightImageObj,leftImageObj,rootImageObj]
        
        let underGroundReportParam : [String:Any] = [
            "shift" : JSON(underGroundReportDetail.shift as Any).stringValue,
            "mappedBy" : JSON(underGroundReportDetail.mappedBy as Any).stringValue,
            "name" : JSON(underGroundReportDetail.name as Any).stringValue,
            "scale" : JSON(underGroundReportDetail.scale as Any).stringValue,
            "location" : JSON(underGroundReportDetail.location as Any).stringValue,
            "venieLoad" : JSON(underGroundReportDetail.veinOrLoad as Any).stringValue,
            "xCordinate" : JSON(underGroundReportDetail.xCoordinate as Any).stringValue,
            "yCordinate" : JSON(underGroundReportDetail.yCoordinate as Any).stringValue,
            "zCordinate" : JSON(underGroundReportDetail.zCoordinate as Any).stringValue,
            "mapSerialNo" : JSON(underGroundReportDetail.mapSerialNo as Any).stringValue,
            "ugDate" : GFunctions.shared.convertDateFormat(dt: JSON(underGroundReportDetail.ugDate as Any).stringValue, inputFormat: DateTimeFormaterEnum.ddmm_yyyy.rawValue, outputFormat: DateTimeFormaterEnum.ddMMMyyyy.rawValue, status: .NOCONVERSION).str,
            "comment" : JSON(underGroundReportDetail.comment as Any).stringValue,
            "faceImage" : faceImageObj.name,
            "rightImage" : rightImageObj.name,
            "leftImage" : leftImageObj.name,
            "roofImage" : rootImageObj.name,
            "userId" : JSON(UserModelClass.current.userId as Any).stringValue,
            "attribute" : arrOfDict.toJSON()!
        ]
        
        return (underGroundReportParam,arrUploadDataModelForUGR)
    }
    
    func getOpenCastReportDetailsParameters(openCastReportDetail : OpenCastMappingReportDataTable)-> (openCastParam : [String:Any],arrOpenCastImages : [UploadDataModel]){
        
        let drawImage = UploadDataModel(name: "image.jpeg", key: "image", data: openCastReportDetail.imagedrawn, extention: "jpeg", mimeType: "image/jpeg")
        let clientGeologistSignImage = UploadDataModel(name: "image.jpeg", key: "clientsGeologistSign", data: openCastReportDetail.clientsGeologistSign, extention: "jpeg", mimeType: "image/jpeg")
        let geologistSignImage = UploadDataModel(name: "image.jpeg", key: "geologistSign", data: openCastReportDetail.geologistSign, extention: "jpeg", mimeType: "image/jpeg")
        
        let arrUploadImagesForOCR : [UploadDataModel] = [drawImage,clientGeologistSignImage,geologistSignImage]
        
        let openCastReportParam : [String:Any] = [
            "userId" : JSON(UserModelClass.current.userId as Any).stringValue,
            "minesSiteName" : JSON(openCastReportDetail.minesSiteName as Any).stringValue,
            "mappingSheetNo" : JSON(openCastReportDetail.mappingSheetNo as Any).stringValue,
            "pitName" : JSON(openCastReportDetail.pitName as Any).stringValue,
            "pitLoaction" : JSON(openCastReportDetail.pitLocation as Any).stringValue,
            "shiftInchargeName" : JSON(openCastReportDetail.shiftInChargeName as Any).stringValue,
            "geologistName" : JSON(openCastReportDetail.geologistName as Any).stringValue,
            "faceLocation" : JSON(openCastReportDetail.faceLocation as Any).stringValue,
            "faceLength" : JSON(openCastReportDetail.faceLength as Any).stringValue,
            "faceArea" : JSON(openCastReportDetail.faceArea as Any).stringValue,
            "faceRockType" : JSON(openCastReportDetail.faceRockTypes as Any).stringValue,
            "benchRl" : JSON(openCastReportDetail.benchRL as Any).stringValue,
            "benchHeightWidth" : JSON(openCastReportDetail.benchHeightWidth as Any).stringValue,
            "benchAngle" : JSON(openCastReportDetail.benchAngle as Any).stringValue,
            "thicknessOfOre" : JSON(openCastReportDetail.thicknessOfOre as Any).stringValue,
            "thicknessOfOverburdan" : JSON(openCastReportDetail.thicknessOfOverburden as Any).stringValue,
            "thicknessOfInterburden" : JSON(openCastReportDetail.thicknessOfInterBurden as Any).stringValue,
            "observedGradeOfOre" : JSON(openCastReportDetail.observedGradeOfOre as Any).stringValue,
            "sampleColledted" : JSON(openCastReportDetail.sampleCollected as Any).stringValue,
            "actualGradeOfOre" : JSON(openCastReportDetail.actualGradOfOre as Any).stringValue,
            "weathring" : JSON(openCastReportDetail.weathering as Any).stringValue,
            "rockStregth" : JSON(openCastReportDetail.rockStrength as Any).stringValue,
            "waterCondition" : JSON(openCastReportDetail.waterCondition as Any).stringValue,
            "typeOfGeologist" : JSON(openCastReportDetail.typeOfGeologicalStructures as Any).stringValue,
            "dipDirectionAndAngle" : JSON(openCastReportDetail.dipdirectionandAngle as Any).stringValue,
            "typeOfFaults" : JSON(openCastReportDetail.typeOfFaults as Any).stringValue,
            "shift" : JSON(openCastReportDetail.shift as Any).stringValue,
            "ocDate" : GFunctions.shared.convertDateFormat(dt: JSON(openCastReportDetail.ocDate as Any).stringValue, inputFormat: DateTimeFormaterEnum.ddmm_yyyy.rawValue, outputFormat: DateTimeFormaterEnum.ddMMMyyyy.rawValue, status: .NOCONVERSION).str,
            "notes" : JSON(openCastReportDetail.notes as Any).stringValue,
            "image" : drawImage.name,
            "clientsGeologistSign" : clientGeologistSignImage.name,
            "geologistSign" : geologistSignImage.name
        ]
        
        return (openCastReportParam,arrUploadImagesForOCR)
    }
}

