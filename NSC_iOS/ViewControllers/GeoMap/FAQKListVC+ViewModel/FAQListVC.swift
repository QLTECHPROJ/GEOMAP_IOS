//
//  FAQListVC.swift
//  BWS_iOS_2
//
//  Created by Mac Mini on 28/04/21.
//  Copyright © 2021 Dhruvit. All rights reserved.
//

import UIKit

class FAQListVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - VARIABLES
   
    
    let vmFAQList = FAQListVM()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Segment Tracking
       
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.title = kFAQs
        
        self.tableView.register(nibWithCellClass: FAQCell.self)
        self.view.backgroundColor = .colorBGSkyBlueLight
      
        self.apiCallingForFAQ()
    }
    
    func apiCallingForFAQ(){
        
        self.vmFAQList.callAPIFAQList{ responseJson, statusCode, message, completion in
            if completion{
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - ACTIONS
    @IBAction func backClicked(sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension FAQListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vmFAQList.numberOfRowsInSectionInTableviewList(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: FAQCell.self)
        cell.configureDataInCell(self.vmFAQList.cellForRowAtInTableviewList(indexPath))
        
        cell.btnArrow.handleTapToAction {
            self.vmFAQList.didExpandAnswer(indexPath) { completion in
                self.tableView.reloadData()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
