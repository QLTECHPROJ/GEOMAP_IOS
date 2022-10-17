//
//  AddReportVC.swift
//  NSC_iOS
//
//  Created by Mac Mini on 13/10/22.
//

import UIKit

class AddReportVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - ACTION
    @IBAction func backClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ACTION
    @IBAction func undergroundClicked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: UGReportDetailVC.self)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    // MARK: - ACTION
    @IBAction func openCastClicked(_ sender: UIButton) {
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: OCReportDetailVC.self)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
