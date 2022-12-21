//
//  EditAttributeUGGeoAttributeVC.swift
//  Geo_Map
//
//  Created by vishal parmar on 12/12/22.
//

import UIKit

class EditAttributeUGGeoAttributeVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    
    //UIButtons
    @IBOutlet weak var btnAddAttributes: UIButton!
    @IBOutlet weak var btnNextStep: AppThemeBlueButton!
    
    // UILabels
    
    @IBOutlet weak var lblAttributes: UILabel!
    @IBOutlet weak var lblNos: UILabel!
    
    @IBOutlet weak var lblMineralization: UILabel!
    @IBOutlet weak var lblMineralizationNos: UILabel!
    @IBOutlet weak var lblProperties: UILabel!
    
    // UIViews
    @IBOutlet weak var vwMineralization: AppShadowViewClass!
    @IBOutlet weak var vwMineralizationNos: AppShadowViewClass!
    
    @IBOutlet weak var tvAddDescription: IQTextView!
    
    @IBOutlet weak var lblAttributesTitle: UILabel!
    
    @IBOutlet weak var tblAttributes: UITableView!
    
    @IBOutlet weak var tblAttributesHeight: NSLayoutConstraint!
    
    @IBOutlet weak var vwAttributes: UIView!
    
    @IBOutlet weak var lblInstruction: UILabel!
        
    // MARK: - VARIABLES
 
    private var arrAttributeNos : [JSON] = []
    
    private var arrAddedAttributes : [JSON] = []
    
    var ugReportDetail : JSON = .null
    
    var isOfflineDataUpdate : Bool = false
    
    var faceImage = UIImage()
    var roofImage = UIImage()
    var leftImage = UIImage()
    var rightImage = UIImage()
    
    
    
    deinit {
        if let _ = self.tblAttributes {
            self.tblAttributes.removeObserver(self, forKeyPath: "contentSize")
        }
    }
       
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.view.backgroundColor = .colorBGSkyBlueLight
       
        self.title = kGeologicalAttributes
        
        let attributedScale: NSMutableAttributedString = NSMutableAttributedString(string: "\(kNoteColmn) \(kAddMultipleAttributesInMappingReportInstrcution)")
        attributedScale.setAttributes(color: UIColor.colorTextBlack, forText: kNoteColmn, font: 10, fontname: .InterBold)
        attributedScale.setAttributes(color: UIColor.colorTextBlack, forText: kAddMultipleAttributesInMappingReportInstrcution, font: 10, fontname: .InterItalic)
        self.lblInstruction.attributedText = attributedScale
        
        self.lblAttributes.applyLabelStyle(text : kAttributes,fontSize : 14,fontName : .InterSemibol)
        
        self.lblNos.applyLabelStyle(text : kNos,fontSize : 14,fontName : .InterSemibol)
        self.lblProperties.applyLabelStyle(text : kProperties,fontSize : 14,fontName : .InterSemibol)
        
        self.lblMineralization.applyLabelStyle(fontSize : 14,fontName : .InterSemibol)
        self.lblMineralizationNos.applyLabelStyle(fontSize : 14,fontName : .InterSemibol)
        self.btnNextStep.setTitle(kNextStep, for: .normal)
        
        self.tvAddDescription.applyTextViewStyle(placeholderText : kAddDescripstion, fontSize : 14,fontName : .InterSemibol,placeholerColor : .colorTextPlaceHolderGray)
        
        self.lblAttributesTitle.applyLabelStyle(text : kAttributesColn,fontSize : 14,fontName : .InterSemibol)
        
        DispatchQueue.main.async {
            
            self.btnAddAttributes.applystyle(fontname : .InterSemibol,fontsize : 14,titleText : kAddAttributes,titleColor : .colorSkyBlue)
        }
        self.setAttributesData()
        self.otherActions()
        self.setEmptyField()
        self.buttonEnableDisable()
        self.setDataOnTableView()
        self.tblAttributes.register(nibWithCellClass: AttributeNewListTblCell.self)
        self.tblAttributes.addObserver(self, forKeyPath: "contentSize", options: [.new ], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let newSize = change?[.newKey] as? CGSize {
            
            self.tblAttributesHeight.constant = newSize.height
        }
    }
    
    private func setAttributesData(){
        guard self.ugReportDetail != .null else {return}
        self.arrAddedAttributes = []
        
        debugPrint(self.ugReportDetail)
        
        for data in self.ugReportDetail["attribute"].arrayValue{
            self.arrAddedAttributes.append(["name" : data["name"].stringValue, "nose" : data["nose"].stringValue, "properties" : data["properties"].stringValue])
        }
    }
    
    func setEmptyField(){
        
        self.lblMineralization.text = kSelectAttributes
        self.lblMineralizationNos.text = kSelectNos
        self.lblMineralization.textColor = self.lblMineralization.text != kSelectAttributes ? UIColor.colorTextBlack : .colorTextPlaceHolderGray
        self.lblMineralizationNos.textColor = self.lblMineralizationNos.text != kSelectNos ? UIColor.colorTextBlack : .colorTextPlaceHolderGray
        self.tvAddDescription.text = ""
    }
    
    func setDataOnTableView(){
        self.tblAttributes.reloadData()
        self.vwAttributes.isHidden = self.arrAddedAttributes.isEmpty
        
    }
    
    func buttonEnableDisable(){
        
        var isEnable : Bool = Bool()
        
        if self.lblMineralization.text == kSelectAttributes || self.lblMineralizationNos.text == kSelectNos || self.tvAddDescription.text.isEmpty{
            isEnable = false
        }
        else{
            isEnable = true
        }
        self.btnNextStep.isSelect = true//!self.arrAddedAttributes.isEmpty || isEnable
    }
    
   
    // MARK: - ACTIONS
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddAttributes(_ sender: UIButton) {
        self.view.endEditing(true)
        
        guard self.lblMineralization.text != kSelectAttributes,self.lblMineralizationNos.text != kSelectNos, !self.tvAddDescription.text.trim.isEmpty else {return}
        
        self.arrAddedAttributes.append(["name" : JSON(self.lblMineralization.text as Any).stringValue, "nose" : JSON(self.lblMineralizationNos.text as Any).stringValue, "properties" : JSON(self.tvAddDescription.text as Any).stringValue])
        
        self.setEmptyField()
        self.buttonEnableDisable()
        self.setDataOnTableView()
    }

    
    @IBAction func btnNextStepTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if self.lblMineralization.text != kSelectAttributes && self.lblMineralizationNos.text != kSelectNos && !self.tvAddDescription.text.isEmpty{
            self.arrAddedAttributes.append(["name" : JSON(self.lblMineralization.text as Any).stringValue, "nose" : JSON(self.lblMineralizationNos.text as Any).stringValue, "properties" : JSON(self.tvAddDescription.text as Any).stringValue])
        }
        self.setEmptyField()
        self.setDataOnTableView()
        self.buttonEnableDisable()
        
        let vc = AppStoryBoard.main.viewController(viewControllerClass: EditUGMappingDataVC.self)
        vc.arrAddedAttributes = self.arrAddedAttributes
        vc.ugReportDetail = self.ugReportDetail
        vc.isOfflineDataUpdate = self.isOfflineDataUpdate
        vc.faceImage = self.faceImage
        vc.roofImage = self.roofImage
        vc.leftImage = self.leftImage
        vc.rightImage = self.rightImage
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func otherActions(){
        
        self.vwMineralization.handleTapToAction {
            // Fix code
            self.view.endEditing(true)
            self.lblMineralizationNos.text = kSelectNos
            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .attributes
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                
                self.lblMineralization.text = selectedItem["name"].stringValue
                self.lblMineralization.textColor = .colorTextBlack
                self.lblMineralizationNos.text = kSelectNos
                self.lblMineralizationNos.textColor = .colorTextPlaceHolderGray
                print(selectedItem)
                self.arrAttributeNos = selectedItem["nos"].arrayValue
                self.buttonEnableDisable()
            }
        }
//        APIParametersModel
        
        self.vwMineralizationNos.handleTapToAction {
            self.view.endEditing(true)
            guard self.lblMineralization.text != kSelectAttributes else {return}
            
            let vc = AppStoryBoard.main.viewController(viewControllerClass: ListItemVC.self)
            vc.listType = .Nos
            vc.arrList = self.arrAttributeNos
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion :{
                vc.openPopUpVisiable()
            })
            vc.didSelectItem = { selectedItem in
                
                print(selectedItem)
                self.lblMineralizationNos.text = selectedItem["name"].stringValue
                self.lblMineralizationNos.textColor = .colorTextBlack
                self.buttonEnableDisable()
            }
        }
    }
}


// MARK: - UITextFieldDelegate
extension EditAttributeUGGeoAttributeVC : UITextViewDelegate {
 
    func textViewDidChangeSelection(_ textView: UITextView) {
        self.buttonEnableDisable()
    }
    
}




// MARK: - UITableViewDelegate, UITableViewDataSource
extension EditAttributeUGGeoAttributeVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAddedAttributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: AttributeNewListTblCell.self)
        
        cell.configuredCell(with:self.arrAddedAttributes[indexPath.row])
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(self.btnDeleteTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func btnDeleteTapped(_ sender : UIButton){
        self.setDataOnTableView()
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: AlertPopUpVC.self)
        aVC.titleText = kLogout
        aVC.detailText = kDeleteAttributesPermissionAlert
        aVC.firstButtonTitle = kYes
        aVC.secondButtonTitle = kNo
        aVC.modalPresentationStyle = .overFullScreen
        
        
        self.present(aVC, animated: false, completion :{
            aVC.openPopUpVisiable()
        })
        
        aVC.didCompletion = { isOK in
            if isOK{
                
                self.arrAddedAttributes.remove(at: sender.tag)
                self.setDataOnTableView()
                self.buttonEnableDisable()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
