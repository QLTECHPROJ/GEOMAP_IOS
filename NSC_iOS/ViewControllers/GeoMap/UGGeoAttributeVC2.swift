//
//  BankDetailsVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 06/05/22.
//

import UIKit

class UGGeoAttributeVC2: BaseViewController {
    
    // MARK: - OUTLETS
   
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    
    // MARK: - VARIABLES
    var isFromEdit = false
    var arrayErrorLabels = [UILabel]()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
      
    }
    
    // MARK: - ACTION
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }

}


// MARK: - UITextFieldDelegate
extension UGGeoAttributeVC2 : UITextFieldDelegate {
    
    
}
