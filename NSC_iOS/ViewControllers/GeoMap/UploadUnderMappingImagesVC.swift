//
//  UploadUnderMappingImagesVC.swift
//  NSC_iOS
//
//  Created by vishal parmar on 27/10/22.
//

import UIKit

class UploadUnderMappingImagesVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    
    @IBOutlet weak var imgRoof : UIImageView!
    @IBOutlet weak var imgFace : UIImageView!
    @IBOutlet weak var imgLeft : UIImageView!
    @IBOutlet weak var imgRight : UIImageView!
    
   
    @IBOutlet weak var btnSubmit : AppThemeBlueButton!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    
   
    
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
        
        self.imgRoof.backgroundColor = .colorSkyBlue
        self.imgLeft.backgroundColor = .colorSkyBlue
        self.imgRight.backgroundColor = .colorSkyBlue
        self.imgFace.backgroundColor = .colorSkyBlue
        
        self.imgRoof.layer.cornerRadius = 30
        self.imgLeft.layer.cornerRadius = 30
        self.imgRight.layer.cornerRadius = 30
        self.imgFace.layer.cornerRadius = 30
        
        self.btnSubmit.setTitle(kSubmit, for: .normal)
        self.btnSubmit.isSelect = true
    }
 
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitTapped(_ sender : UIButton){
        self.view.endEditing(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            AppDelegate.shared.updateWindow(.home)
        }
    }
    
    
    
    
    //----------------------------------------------------------------------------
    //MARK:- View life cycle
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
