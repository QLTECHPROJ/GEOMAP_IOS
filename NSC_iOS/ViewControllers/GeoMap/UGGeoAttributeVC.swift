//
//  PersonalDetailsVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 06/05/22.
//

import UIKit
import IQKeyboardManagerSwift

class UGGeoAttributeVC: ClearNaviagtionBarVC {
    
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
        
    // MARK: - VARIABLES
 
    private var arrAttributeNos : [JSON] = []
    
    
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
        
        self.lblAttributes.applyLabelStyle(text : kAttributes,fontSize : 16,fontName : .InterSemibol)
        self.lblNos.applyLabelStyle(text : kNos,fontSize : 16,fontName : .InterSemibol)
        self.lblProperties.applyLabelStyle(text : kProperties,fontSize : 16,fontName : .InterSemibol)
        
        self.lblMineralization.applyLabelStyle(fontSize : 16,fontName : .InterSemibol)
        self.lblMineralizationNos.applyLabelStyle(fontSize : 16,fontName : .InterSemibol)
        self.btnNextStep.setTitle(kNextStep, for: .normal)
        
        self.tvAddDescription.applyTextViewStyle(placeholderText : kAddDescripstion, fontSize : 16,fontName : .InterSemibol,placeholerColor : .colorTextPlaceHolderGray)
        
        DispatchQueue.main.async {
            
            self.btnAddAttributes.applystyle(fontname : .InterSemibol,fontsize : 16,titleText : kAddAttributes,titleColor : .colorSkyBlue)
        }
        
        self.otherActions()
        self.setupData()
        self.buttonEnableDisable()
    }
    
    func setupData() {
        
        self.lblMineralization.text = kSelectAttributes
        self.lblMineralizationNos.text = kSelectNos
    }
    
    
    func buttonEnableDisable(){
        
        var isEnable : Bool = Bool()
        
        if self.lblMineralization.text == kSelectAttributes || self.lblMineralizationNos.text == kSelectNos || self.tvAddDescription.text.isEmpty{
            isEnable = false
        }
        else{
            isEnable = true
        }
        self.btnNextStep.isSelect = isEnable
    }
    
   
    // MARK: - ACTIONS
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddAttributes(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnNextStepTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: UGGeoAttributeVC2.self)
        self.navigationController?.pushViewController(aVC, animated: true)
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
                self.lblMineralizationNos.text = kSelectNos
                print(selectedItem)
                self.arrAttributeNos = selectedItem["nos"].arrayValue
                self.buttonEnableDisable()
            }
        }
        
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
                self.buttonEnableDisable()
            }
        }
    }
}


// MARK: - UITextFieldDelegate
extension UGGeoAttributeVC : UITextViewDelegate {
 
    func textViewDidChangeSelection(_ textView: UITextView) {
        self.buttonEnableDisable()
    }
    
}



