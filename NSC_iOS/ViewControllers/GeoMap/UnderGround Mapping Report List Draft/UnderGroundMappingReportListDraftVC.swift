//
//  UnderGroundMappingReportListDraftVC.swift

import UIKit
import DZNEmptyDataSet

class UnderGroundMappingReportListDraftVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    @IBOutlet weak var lblTitle : UILabel!
   
    @IBOutlet weak var tblView : UITableView!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    private var emptyMessage : String = kNoOfflineReportFound
    private var viewModel : UnderGroundMappingReportListDraftVM = UnderGroundMappingReportListDraftVM()
    
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
       
        self.lblTitle.applyLabelStyle(text: kUnderGroundReportDraft,fontSize :  16,fontName : .InterBold)
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.register(nibWithCellClass: UnderGroundMappingReportDraftTableviewCell.self)
        self.setReportData()
    }
    
    
    func setReportData(){

        self.viewModel.getUnderGroundMappingReportList { completion in
            if completion{
                self.tblView.reloadData()
            }
        }
    }
    
   
    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
   
    
    //----------------------------------------------------------------------------
    //MARK: - View life cycle
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

//-------------------------------------------------------------------
//MARK: - Empty TableView Methods
//-------------------------------------------------------------------
extension UnderGroundMappingReportListDraftVC : DZNEmptyDataSetDelegate, DZNEmptyDataSetSource{
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString {
        
        let text = self.emptyMessage
        let attributes = [NSAttributedString.Key.font: UIFont.applyCustomFont(fontName: .InterMedium, fontSize: 13), NSAttributedString.Key.foregroundColor: UIColor.colorTextBlack]
        return NSAttributedString(string: text, attributes: attributes)
    }
}

//----------------------------------------------------------------------------
//MARK: - UITableView Methods
//----------------------------------------------------------------------------
extension UnderGroundMappingReportListDraftVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSectionInTableviewList(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: UnderGroundMappingReportDraftTableviewCell.self)
        cell.configureCellUnderGroundMappingReportData(self.viewModel.cellForRowAtInTableviewList(indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*
         self.viewModel.deleteUnderGroundMappingReportDataFromTable(JSON(self.viewModel.cellForRowAtInTableviewList(indexPath).iD as Any).stringValue) { completion in
            
            if completion{
                
            }
            self.viewModel.getUnderGroundMappingReportList { completion in
                self.tblView.reloadData()
            }
        }*/
    }
    
}
