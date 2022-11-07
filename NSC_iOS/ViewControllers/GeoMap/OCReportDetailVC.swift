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

class OCReportDetailVC : ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnViewPDF: AppThemeBlueButton!
    
    // MARK: - VARIABLES
   
    
    var reportListType : ReportListType = .opneCastReport
    
    var arrReportDetails : [[String:Any]] = [
        [
            "title" : kMapSerialNo,
            "subtitle" : "1253DFSDF15235"
        ],
        [
            "title" : kDateColn,
            "subtitle" : "14 July 2022"
        ],
        [
            "title" : kMineSitenameColn,
            "subtitle" : "KGF"
        ],
        [
            "title" : kPitnameColn,
            "subtitle" : "XYZ Pit"
        ],
        [
            "title" : kPitLocationColn,
            "subtitle" : "Lauram ipsum, address here"
        ],
        [
            "title" : kShiftInchargeNameColn,
            "subtitle" : "Robert Downey"
        ],
        [
            "title" : kGeologistNameColn,
            "subtitle" : "Amazon"
        ],
        [
            "title" : kMappingParametersColn,
            "subtitle" : "HSKFJSK"
        ],
        [
            "title" : kFaceLocationColn,
            "subtitle" : "sdsdterkerk"
        ],
        [
            "title" : kFaceLenghtMColn,
            "subtitle" : "45 mtr"
        ],
        [
            "title" : kFaceAreaM2Coln,
            "subtitle" : "32238423"
        ],
        [
            "title" : kFaceRockTypeColn,
            "subtitle" : "Black"
        ],
        [
            "title" : kBenchRL,
            "subtitle" : "WKRWERK"
        ],
        [
            "title" : kBenchHeightWidthM,
            "subtitle" : "110 x 500"
        ],
        [
            "title" : kBenchAngleColn,
            "subtitle" : "434"
        ],
        [
            "title" : kDipDirectionAndAngleColn,
            "subtitle" : "East 3454"
        ],
        [
            "title" : kThicknessOfOreCoalSeam,
            "subtitle" : "DF SDS FK"
        ],
        [
            "title" : kThicknessOfOverburdenMColn,
            "subtitle" : "3434"
        ],
        [
            "title" : kThicknessOfInterburdenMColn,
            "subtitle" : "343"
        ],
        [
            "title" : kObservedGradeOfOreColn,
            "subtitle" : "B Grade"
        ],
        [
            "title" : kSampleCollectedColn,
            "subtitle" : "HKHHJHJH"
        ],
        [
            "title" : kActualGradeOfOreLabGradeColn,
            "subtitle" : "AB Grade"
        ],
        [
            "title" : kWeatheringColn,
            "subtitle" : "Warm"
        ],
        [
            "title" : kRockStrengthColn,
            "subtitle" : "Solid"
        ],
        [
            "title" : kWaterConditionColn,
            "subtitle" : "Average"
        ],
        [
            "title" : kTypeOfGeologicalStructuresColn,
            "subtitle" : "WKRWERK"
        ],
        [
            "title" : kTypeOfFaultsColn,
            "subtitle" : "WKRWERK"
        ]
    ]
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    // MARK: - FUNCTIONS
    func setupUI() {
        self.tableView.register(nibWithCellClass: ContactCell.self)
        
      
        self.tableView.reloadData()
        self.lblTitle.applyLabelStyle(text: kOpenCastMappingReportDetails,fontSize :  20,fontName : .InterBold)
        self.lblTitle.adjustsFontSizeToFitWidth = true
        self.view.backgroundColor = .colorBGSkyBlueLight
        
        self.btnViewPDF.isSelect = true
        self.btnViewPDF.setTitle(kViewPDF, for: .normal)
    }
    
  
    
    // MARK: - ACTIONS
    @IBAction func backClicked(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnViewPDF(_ sender : UIButton) {
        let vc = AppStoryBoard.main.viewController(viewControllerClass: ViewPDFVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OCReportDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrReportDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withClass: ContactCell.self)
        cell.configureDataInCell(self.arrReportDetails[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
