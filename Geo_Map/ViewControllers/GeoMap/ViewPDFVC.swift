//
//  ViewPDFVC.swift
//  Geo_Map
//
//  Created by vishal parmar on 28/10/22.
//

import UIKit

class ViewPDFVC: ClearNaviagtionBarVC {
    
    
    @IBOutlet weak var lblInstruction : UILabel!
    @IBOutlet weak var btnViewPDF  : AppThemeBlueButton!

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
      
        self.lblInstruction.applyLabelStyle(text : kProjectMainingPDF,fontSize : 16,fontName : .InterSemibol)
        
        self.btnViewPDF.isSelect = true
        self.btnViewPDF.setTitle(kViewPDF, for: .normal)
        self.btnViewPDF.setContentEdges(ImageEngesLeft : -20)
    }
    
    
    
    // MARK: - ACTION
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnViewPDFTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}
