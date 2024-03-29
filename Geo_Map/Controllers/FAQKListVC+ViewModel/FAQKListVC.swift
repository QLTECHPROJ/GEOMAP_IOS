//
//  FAQListVC.swift


import UIKit
import DZNEmptyDataSet

class FAQListVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - VARIABLES
    private var emptyMessage : String = ""
    
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
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.register(nibWithCellClass: FAQCell.self)
        self.view.backgroundColor = .colorBGSkyBlueLight
      
        self.apiCallingForFAQ()
    }
    
    func apiCallingForFAQ(){
        
        self.vmFAQList.callAPIFAQList{ responseJson, statusCode, message, completion in
            if completion{
                self.tableView.reloadData()
            }
            else if let _ = message{
                self.emptyMessage = message!
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - ACTIONS
    @IBAction func backClicked(sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//-------------------------------------------------------------------
//MARK: - Empty TableView Methods
//-------------------------------------------------------------------
extension FAQListVC : DZNEmptyDataSetDelegate, DZNEmptyDataSetSource{
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString {
        
        let text = self.emptyMessage
        let attributes = [NSAttributedString.Key.font: UIFont.applyCustomFont(fontName: .InterMedium, fontSize: 13), NSAttributedString.Key.foregroundColor: UIColor.colorTextBlack]
        return NSAttributedString(string: text, attributes: attributes)
    }
}

//-------------------------------------------------------------------
//MARK: - UITableView Methods
//-------------------------------------------------------------------
extension FAQListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vmFAQList.numberOfRowsInSectionInTableviewList(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: FAQCell.self)
        cell.configureDataInCell(self.vmFAQList.cellForRowAtInTableviewList(indexPath))
        
        cell.viewQuestion.handleTapToAction {
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
