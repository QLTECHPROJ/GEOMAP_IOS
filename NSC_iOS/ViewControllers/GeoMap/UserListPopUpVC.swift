//
//  UserListPopUpVC.swift
//  BWS_iOS_2
//
//  Created by Dhruvit on 03/04/21.
//  Copyright © 2021 Dhruvit. All rights reserved.
//

import UIKit

class UserListPopUpVC: ClearNaviagtionBarVC {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var imgUser: ImageThemeBorderClass!
    
    @IBOutlet weak var imgCamara: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - VARIABLES
   
    var arrMenu : [[String:Any]] = [
        ["type" : kUnderGroundReportList],
        ["type" : kOpenCastReportlist],
        ["type" : kEditProfile],
        ["type" : kSyncData],
        ["type" : kFAQs],
        ["type" : kAboutUs],
        ["type" : kSupport],
        ["type" : kContantUs],
        ["type" : kLogout]
    ]
    

    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        
    }
    
    
    //MARK: - FUNCTIONS
    
    func setUpUI(){
        self.view.backgroundColor = .colorBGSkyBlueLight
        self.tableView.register(nibWithCellClass: UserListCell.self)
        /*
        let tapGestureToChooseProfile1 = UITapGestureRecognizer(target: self, action: #selector(self.selectProfilePicture(_:)))
        self.imgUser.isUserInteractionEnabled = true
        self.imgUser.addGestureRecognizer(tapGestureToChooseProfile1)
        
        let tapGestureToChooseProfile2 = UITapGestureRecognizer(target: self, action: #selector(self.selectProfilePicture(_:)))
        self.imgCamara.isUserInteractionEnabled = true
        self.imgCamara.addGestureRecognizer(tapGestureToChooseProfile2)
        */
        self.setupData()
    }
    
    func setupData() {
        self.imgUser.image = UIImage(named: "profile1")
        
    }
    
    // MARK: - ACTIONS
    @IBAction func onTappedBack(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension UserListPopUpVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: UserListCell.self)
        cell.lblName.text = (self.arrMenu[indexPath.row]["type"] as? String)?.description
        //cell.imgView.image = UIImage(named: arrImage[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let title = (self.arrMenu[indexPath.row]["type"] as? String)?.description
        
        switch title {
            
        case kUnderGroundReportList:
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:UGListVC.self)
            aVC.titleHeader = kUndergroundsMappingReport
            self.navigationController?.pushViewController(aVC, animated: true)
            
            break
            
        case kOpenCastReportlist:
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:UGListVC.self)
            aVC.titleHeader = kOpenCastMappingReport
            self.navigationController?.pushViewController(aVC, animated: true)
            
            break
            
        case kEditProfile:
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: ProfileVC.self)
            self.navigationController?.pushViewController(aVC, animated: true)
            
            break
            
        case kSyncData:
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: SyncDataVC.self)
            self.navigationController?.pushViewController(aVC, animated: true)
            
            break
            
        case kFAQs:
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: FAQListVC.self)
            self.navigationController?.pushViewController(aVC, animated: true)
            
            break
            
//        case kAboutUs:
//            
//            //            openUrl(urlString:"https://nationalsportscamps.in/about-nsc")
//            let aVC = AppStoryBoard.main.viewController(viewControllerClass: WebViewVC.self)
//            self.navigationController?.pushViewController(aVC, animated: true)
//            
//            break
            
        case kSupport:
            
            if checkInternet(showToast: true) == false {
                return
            }
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:SupportPopupVC.self)
            aVC.modalPresentationStyle = .overFullScreen
            self.present(aVC, animated: false, completion :{
                aVC.openPopUpVisiable()
            })
            
            break
            
        case kContantUs,kAboutUs:
            
            //            openUrl(urlString:"https://nationalsportscamps.in/about-nsc")
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: WebViewVC.self)
            aVC.titleString = title!
            self.navigationController?.pushViewController(aVC, animated: true)
            
            break
            
        default:
            
            if checkInternet(showToast: true) == false {
                return
            }
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: AlertPopUpVC.self)
            aVC.titleText = kLogout
            aVC.detailText = kLogoutPermissionAlertMsg
            aVC.firstButtonTitle = kOK
            aVC.secondButtonTitle = kClose
            aVC.modalPresentationStyle = .overFullScreen
            aVC.delegate = self
            //            self.present(aVC, animated: false, completion: nil)
            self.present(aVC, animated: false, completion :{
                aVC.openPopUpVisiable()
            })
            
            
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


// MARK: - AlertPopUpVCDelegate
extension UserListPopUpVC : AlertPopUpVCDelegate {
    
    func handleAction(sender: UIButton, popUpTag: Int) {
        if sender.tag == 0 {
            if checkInternet(showToast: true) == false {
                return
            }
            
            AppDelegate.shared.updateWindow()
            /*
            let logoutVM = LogoutViewModel()
            logoutVM.callLogoutAPI(completion: { success in
//                APPDELEGATE.logout()
            })
         */
        }
    }
    
}
