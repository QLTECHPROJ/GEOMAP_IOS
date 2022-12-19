//
//  OpenCastMappingListDraftVC.swift


import UIKit
import DZNEmptyDataSet

class OpenCastMappingListDraftVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
    @IBOutlet weak var lblTitle : UILabel!
   
    @IBOutlet weak var tblView : UITableView!
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    private var emptyMessage : String = kNoOfflineReportFound
    private var viewModel : OpenCastMappingReportListDraftVM = OpenCastMappingReportListDraftVM()
    
    //----------------------------------------------------------------------------
    //MARK: - Memory management
    //----------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self.removeClassObservers()
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Custome Methods
    //----------------------------------------------------------------------------
    //Desc:- Centre method to call Of View Config.
    func setUpView(){
        self.addClassObservers()
        self.configureUI()
    }
    
    
    
    //Desc:- Set layout desing customize
    
    func configureUI(){
        self.view.backgroundColor = .colorBGSkyBlueLight
       
        self.lblTitle.applyLabelStyle(text: kOpenCastMappingReportDraft,fontSize :  16,fontName : .InterBold)
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.register(nibWithCellClass: UnderGroundMappingReportDraftTableviewCell.self)
        self.setReportData()
    }
    
    
    func setReportData(){

        self.viewModel.getOpenCastMappingReportList(with: { completion in
            if completion{
                self.tblView.reloadData()
            }
        })
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
extension OpenCastMappingListDraftVC : DZNEmptyDataSetDelegate, DZNEmptyDataSetSource{
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
extension OpenCastMappingListDraftVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSectionInTableviewList(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: UnderGroundMappingReportDraftTableviewCell.self)
        cell.configureCellOpenCastMappingReportData(self.viewModel.cellForRowAtInTableviewList(indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = AppStoryBoard.main.viewController(viewControllerClass:OpenCastReportOfflineDetailVC.self)
        vc.reportData = self.viewModel.cellForRowAtInTableviewList(indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//----------------------------------------------------------------------------
//MARK: - Class observers Methods
//----------------------------------------------------------------------------
extension OpenCastMappingListDraftVC {
    
    func addClassObservers() {
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.reploadPageData(_:)), name: NSNotification.Name.updateOCOfflineReport, object: nil)
    }
    
    func removeClassObservers() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.updateOCOfflineReport, object: nil)
       
    }

    
    @objc func reploadPageData(_ notification : NSNotification){
        self.setReportData()
    }
}
