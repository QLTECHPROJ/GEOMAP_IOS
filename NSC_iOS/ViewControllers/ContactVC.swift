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
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    
    
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
        
        btnClear.isHidden = true
        lblNoData.isHidden = true
        
        lblNoData.isHidden = true
        lblNoData.text = Theme.strings.no_contacts_to_display
        lblNoData.textColor = Theme.colors.textColor
        
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(textFieldValueChanged(textField:)), for: UIControl.Event.editingChanged)
        
        tableView.reloadData()
    }
    
    override func setupData() {
        arrayContacts = [ContactModel]()
        for contact in arrayContactList {
            let contactData = ContactModel()
            contactData.contactName = contact.givenName + " " + contact.familyName
            
            if let phoneNumber = contact.phoneNumbers.first?.value {
                contactData.contactNumber = phoneNumber.stringValue
            }
            
            if let imageData = contact.thumbnailImageData, let contactImage = UIImage(data: imageData) {
                contactData.contactImage = contactImage
            } else {
                contactData.contactImage = UIImage(named: "userIcon")
            }
            
            arrayContacts.append(contactData)
        }
        
        arrayContacts = arrayContacts.filter { $0.contactNumber.trim.count > 0 }
        
        arrayContactsSearch = arrayContacts
        tableView.reloadData()
        lblNoData.isHidden = arrayContactsSearch.count != 0
        tableView.isHidden = arrayContactsSearch.count == 0
    }
    
    @objc func textFieldValueChanged(textField : UITextField ) {
        btnClear.isHidden = textField.text?.count == 0
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
    
    func sendSMS(contact : ContactModel) {
        self.view.endEditing(true)
        
        let inviteVM = InviteViewModel()
        inviteVM.callInviteUserAPI(contact: contact) { success in
            if success {
                self.sendReferralMessage(contact: contact)
            }
        }
    }
    
    func sendReferralMessage(contact : ContactModel) {
        if (MFMessageComposeViewController.canSendText()) {
            
            let shareText = "You’re invited  for the position of coach in our sports camp. Apply Now!! \n\nDownload the NSC app now and use referral code \(referCode)!! \n\nGet the app now \(referLink)"
            
            let controller = MFMessageComposeViewController()
            controller.body = shareText
            controller.recipients = [contact.contactNumber]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        } else {
            showAlertToast(message: Theme.strings.alert_cannot_send_message)
        }
    }
    
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearSearchClicked(_ sender: UIButton) {
        txtSearch.text = ""
        arrayContactsSearch = arrayContacts
        btnClear.isHidden = true
        lblNoData.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
}


// MARK: - UITextFieldDelegate
extension ContactVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            print("Search text :- ",updatedText)
            
            arrayContactsSearch = arrayContacts.filter({ (model:ContactModel) -> Bool in
                return model.contactName.lowercased().contains(updatedText.lowercased())
            })
            
            if updatedText.trim.count == 0 {
                arrayContactsSearch = arrayContacts
            }
            
            if arrayContactsSearch.count > 0 {
                lblNoData.isHidden = true
            } else {
                lblNoData.isHidden = false
                lblNoData.text = Theme.strings.alert_search_term_not_found
            }
            
            lblNoData.isHidden = arrayContactsSearch.count != 0
            tableView.isHidden = arrayContactsSearch.count == 0
            tableView.reloadData()
        }
        
        return true
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ContactVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayContactsSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ContactCell.self)
        cell.configureCell(data: arrayContactsSearch[indexPath.row])
        cell.inviteClicked = {
            self.sendSMS(contact: self.arrayContactsSearch[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}


// MARK: - MFMessageComposeViewControllerDelegate
extension ContactVC : MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            showAlertToast(message: "Message Sending Cancelled")
        case .sent:
            print("Message Sent")
        case .failed:
            showAlertToast(message: "Message Sening Failed")
        default:
            showAlertToast(message: "Message Sening Failed")
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
}
