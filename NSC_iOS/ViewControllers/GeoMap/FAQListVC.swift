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
    var strCategory = ""
    var arrayFilter = [FAQDataModel]()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Segment Tracking
       
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        tableView.register(nibWithCellClass: FAQCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.reloadData()
    }
    
    func setupData() {
        
    }
    
    
    // MARK: - ACTIONS
    @IBAction func backClicked(sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension FAQListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: FAQCell.self)
        //cell.configureCell(data: arrayFilter[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var isSelected = arrayFilter[indexPath.row].isSelected
//        
//        for question in arrayFilter {
//            question.isSelected = false
//        }
//        
//        isSelected.toggle()
//        arrayFilter[indexPath.row].isSelected = isSelected
//        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
