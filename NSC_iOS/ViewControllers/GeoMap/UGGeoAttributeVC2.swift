//
//  BankDetailsVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 06/05/22.
//

import UIKit

class BankDetailsVC: BaseViewController {
    
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

}


// MARK: - UITextFieldDelegate
extension BankDetailsVC : UITextFieldDelegate {
    
    
}
