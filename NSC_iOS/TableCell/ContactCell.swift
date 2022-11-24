//
//  ContactCell.swift
//  NSC_iOS
//
//  Created by Dhruvit on 13/05/22.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblSubtitle : UILabel!
    
    
    @IBOutlet weak var tblView : UITableView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    var inviteClicked : (() -> Void)?
    
    var arrAddedAttributes : [JSON] = []
    
    deinit {
        if let _ = self.tblView {
            self.tblView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTitle.applyLabelStyle(fontSize :  12,fontName : .InterMedium, textColor: .colorTextPlaceHolderGray)
        self.lblSubtitle.applyLabelStyle(fontSize :  14,fontName : .InterMedium)
        self.lblSubtitle.numberOfLines = 0
        
        self.tblView.dataSource = self
        self.tblView.delegate = self
        
        self.tblView.register(nibWithCellClass: AttributesDataTblCell.self)
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: [.new ], context: nil)
        self.tblView.clipsToBounds = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let newSize = change?[.newKey] as? CGSize {
            
            self.tblViewHeight.constant = newSize.height
            if !self.arrAddedAttributes.isEmpty{
                debugPrint(newSize.height)
            }
        }
    }
    
    // Configure Cell
    
    func configureDataInCell(_ reportDetail : JSON){
        
        self.lblTitle.text = reportDetail["key"].stringValue
        self.lblSubtitle.isHidden = true
        self.tblView.isHidden = true
        
        if !reportDetail["value"].stringValue.isEmpty{
            self.lblSubtitle.text = reportDetail["value"].stringValue
            self.lblSubtitle.isHidden = false
        }
        
        if !reportDetail["value"].arrayValue.isEmpty{
            arrAddedAttributes = reportDetail["value"].arrayValue
            self.tblView.isScrollEnabled = false
            self.tblView.reloadData()
            
            self.tblView.isHidden = false
            
            debugPrint(arrAddedAttributes.count)
        }
        
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ContactCell : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAddedAttributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: AttributesDataTblCell.self)
        cell.configuredCell(with:self.arrAddedAttributes[indexPath.row])
        cell.leftLeadingConstraint.constant = 15
        cell.rightTraillingConstraint.constant = 15
        cell.btnDelete.isHidden = true
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
