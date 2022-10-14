//
//  ContactVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 13/05/22.
//

import Foundation
import ContactsUI
import MessageUI
import EVReflection

/**** Contact Model ****/

class ContactModel : EVObject {
    var contactName = ""
    var contactNumber = ""
    var contactImage : UIImage?
}

class ContactVC: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    
    
    // MARK: - VARIABLES
    var arrayContactList = [CNContact]()
    var arrayContacts = [ContactModel]()
    var arrayContactsSearch = [ContactModel]()
    
    var referCode = ""
    var referLink = ""
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchContacts()
        setupData()
    }
    
    
    // MARK: - FUNCTIONS
    override func setupUI() {
        tableView.register(nibWithCellClass: ContactCell.self)
        
      
        lblNoData.isHidden = true
        
        lblNoData.isHidden = true
        lblNoData.text = Theme.strings.no_contacts_to_display
        lblNoData.textColor = Theme.colors.textColor
        
       
        
        tableView.reloadData()
    }
    
    override func setupData() {
        
        tableView.reloadData()
        
    }
    
   
    
    func fetchContacts() {
        let keys = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactThumbnailImageDataKey
        ] as [Any]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        fetchRequest.sortOrder = CNContactSortOrder.givenName
        let store = CNContactStore()
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { ( contact, stop) -> Void in
                self.arrayContactList.append(contact)
            })
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        // arrayContactList = arrayContactList.sorted(by: { $0.givenName > $1.givenName })
        self.setupData()
    }
    
   
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ContactVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ContactCell.self)
       // cell.configureCell(data: arrayContactsSearch[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}
