//
//  BaseViewController.swift
//  NSC_iOS
//
//  Created by Dhruvit on 12/08/20.
//  Copyright © 2020 Dhruvit. All rights reserved.
//

import UIKit
import MediaPlayer
import TTTAttributedLabel


class BaseViewController: UIViewController {
    
    static var shared = BaseViewController()
    
    // MARK: - VARIABLES
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Theme.colors.theme_dark
        return refreshControl
    }()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - FUNCTIONS
    
    /**
     SetUp UI elements
     */
    func setupUI() {
        // SetUp UI elements
    }
    
    /**
     SetUp data to UI elements
     */
    func setupData() {
        // SetUp data to UI elements
    }
    
    /**
    Redirect To Next Screen
    */
    func goNext() {
        // Redirect To Next Screen
    }
    
    /**
     Redirect Logged In User
    */
    func handleLoginUserRedirection() {
        // Redirect Logged In User
        guard let userData = LoginDataModel.currentUser else {
            return
        }
        
//        if userData.PersonalDetailFilled == "0" {
//            let aVC = AppStoryBoard.main.viewController(viewControllerClass: UGGeoAttributeVC.self)
//            self.navigationController?.pushViewController(aVC, animated: true)
//        } else if userData.BankDetailFilled == "0" {
//           
//        } else if userData.Status == CoachStatus.Pending.rawValue || userData.Status == CoachStatus.Rejected.rawValue {
////            let aVC = AppStoryBoard.main.viewController(viewControllerClass: ProfileStatusVC.self)
////            self.navigationController?.pushViewController(aVC, animated: true)
//        } else {
//           
//        }
    }
    
    /**
    Enable / Disable Buttons
    */
    func buttonEnableDisable() {
        // Enable / Disable Buttons
    }
    
    /**
     Refresh data
     */
    func refreshData() {
        // Refresh data
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
    
    /**
     Fetch Coach Details
     */
    func fetchCoachDetails(completion : (() -> Void)? = nil) {
        let coachDetailVM = CoachDetailViewModel()
        coachDetailVM.callCoachDetailsAPI { success in
            self.setupData()
        }
    }
    
    
    /**
     Setup Support Label
     */
    func setupSupportLabel(lblSupport : TTTAttributedLabel) {
        let strSupport = "Contact Support"
        let string = "\(strSupport)"
        
        let nsString = string as NSString
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        
        let fullAttributedString = NSAttributedString(string:string, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor: Theme.colors.gray_999999.cgColor,
            //NSAttributedString.Key.font: Theme.fonts.appFont(ofSize: 12, weight: .regular),
        ])
        
        lblSupport.textAlignment = .center
        lblSupport.attributedText = fullAttributedString
        
        let rangeSupport = nsString.range(of: strSupport)
        
        let ppLinkAttributes: [String: Any] = [
            NSAttributedString.Key.foregroundColor.rawValue: Theme.colors.gray_999999,
            NSAttributedString.Key.underlineStyle.rawValue: NSUnderlineStyle.single.rawValue,
        ]
        
        lblSupport.activeLinkAttributes = [:]
        lblSupport.linkAttributes = ppLinkAttributes
        
        let urlSupport = URL(string: "action://Support")!
        lblSupport.addLink(to: urlSupport, with: rangeSupport)
        
        lblSupport.textColor = UIColor.black
        lblSupport.delegate = self
    }
    
    func setupPrivacyLabel(lblPrivacy : TTTAttributedLabel) {
        lblPrivacy.numberOfLines = 0
        
        // By signing in you agree to our T&Cs, Privacy Policy and Disclaimer
        
        let strTC = "T&Cs"
        let strPrivacy = "Privacy Policy"
        let strDisclaimer = "Disclaimer"
        
        // By clicking on Register or Sign up you agree to our T&Cs, Privacy Policy & Disclaimer
        // let string = "By clicking on Register or Sign up you \nagree to our \(strTC), \(strPrivacy) and \(strDisclaimer)"
        let string = "By clicking on Register or Sign up you \nagree to our \(strTC) and \(strPrivacy)"
        
        let nsString = string as NSString
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        
        let fullAttributedString = NSAttributedString(string:string, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor: Theme.colors.gray_999999.cgColor,
            //NSAttributedString.Key.font: Theme.fonts.appFont(ofSize: 12, weight: .regular),
        ])
        
        lblPrivacy.textAlignment = .center
        lblPrivacy.attributedText = fullAttributedString
        
        let rangeTC = nsString.range(of: strTC)
        let rangePrivacy = nsString.range(of: strPrivacy)
        let rangeDisclaimer = nsString.range(of: strDisclaimer)
        
        let ppLinkAttributes: [String: Any] = [
            NSAttributedString.Key.foregroundColor.rawValue: Theme.colors.gray_999999,
            NSAttributedString.Key.underlineStyle.rawValue: NSUnderlineStyle.single.rawValue,
        ]
        
        lblPrivacy.activeLinkAttributes = [:]
        lblPrivacy.linkAttributes = ppLinkAttributes
        
        let urlTC = URL(string: "action://TC")!
        let urlPrivacy = URL(string: "action://Policy")!
        let urlDisclaimer = URL(string: "action://Disclaimer")!
        lblPrivacy.addLink(to: urlTC, with: rangeTC)
        lblPrivacy.addLink(to: urlPrivacy, with: rangePrivacy)
        lblPrivacy.addLink(to: urlDisclaimer, with: rangeDisclaimer)
        
        lblPrivacy.textColor = UIColor.black
        lblPrivacy.delegate = self
    }
    
}


// MARK: - TTTAttributedLabelDelegate
extension BaseViewController : TTTAttributedLabelDelegate {
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        print("link clicked")
        if url.absoluteString == "action://SupportEmail" {
            // self.openUrl(urlString: "mailto:\(supportEmail)")
        } else if url.absoluteString == "action://SupportChat" {
            // Present Chat Screen
        } else if url.absoluteString == "action://Support" {
            // Present Support Popup Screen
        } else if url.absoluteString == "action://TC" {
            self.openUrl(urlString: TERMS_AND_CONDITION_URL)
        } else if url.absoluteString == "action://Policy" {
            self.openUrl(urlString: PRIVACY_POLICY_URL)
        } else if url.absoluteString == "action://Disclaimer" {
            // Present Disclaimer Screen
        }
    }
    
    //    func attributedLabel(_ label: TTTAttributedLabel!, didLongPressLinkWith url: URL!, at point: CGPoint) {
    //        print("link long clicked")
    //    }
    
}
