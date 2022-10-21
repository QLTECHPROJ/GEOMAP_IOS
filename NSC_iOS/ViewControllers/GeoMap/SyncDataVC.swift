//
//  SyncDataVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 14/10/22.
//

import UIKit

class SyncDataVC: ClearNaviagtionBarVC {
    
    
    @IBOutlet weak var lblData : UILabel!
    @IBOutlet weak var lblInstruction : UILabel!
    @IBOutlet weak var vwPdf : UIView!
    
    @IBOutlet weak var btnSyncData  : AppThemeBlueButton!

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
        self.vwPdf.cornerRadius = 30
        self.vwPdf.backgroundColor = .colorSkyBlue
        
        self.lblData.applyLabelStyle(text : kDATA,fontSize : 40,fontName : .InterBold,textColor : .white)
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
        
    }
}
