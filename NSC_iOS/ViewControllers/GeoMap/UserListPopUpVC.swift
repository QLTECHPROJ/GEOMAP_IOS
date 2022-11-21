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
    
    @IBOutlet weak var lblName: UILabel!
        
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - VARIABLES
   
    var arrMenu : [JSON] = [
        ["type" : kUnderGroundReportList],
        ["type" : kOpenCastReportlist],
        ["type" : kUnderGroundReportDraft],
        ["type" : kOpenCastReportDraft],
        ["type" : kEditProfile],
        ["type" : kSyncData],
        ["type" : kFAQs],
        ["type" : kAboutUs],
        ["type" : kSupport],
        ["type" : kContantUs],
        ["type" : kLogout]
    ]
    
    private let vwProfileModel : ProfileViewModel = ProfileViewModel()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        
    }
    
    
    //MARK: - FUNCTIONS
    
    func setUpUI(){
        self.view.backgroundColor = .colorBGSkyBlueLight
        self.tableView.register(nibWithCellClass: UserListCell.self)
        
        self.lblName.applyLabelStyle(fontSize : 16,fontName : .InterBold)
        self.setupData()
    }
    
    func setupData() {

        self.lblName.text = JSON(UserModelClass.current.name as Any).stringValue
        
        self.imgUser.sd_setImage(with: JSON(UserModelClass.current.profileImage as Any).stringValue.url()) { (image, error, sdchahe, returnUrl) in
            if error != nil {
                self.imgUser.image = UIImage()
                self.imgUser.image = GFunctions.shared.setDefaultTextInProfile(text: JSON(UserModelClass.current.name as Any).stringValue)
               // self.imgUser.isView = false
            }
        }
        self.apiCalling()
    }
    
    func apiCalling(){
        self.vwProfileModel.callAPIGetUserProfile { reponseData, statusCode, message, completion in
            
            if completion , let data = reponseData{
                debugPrint(data)
                self.lblName.text = JSON(UserModelClass.current.name as Any).stringValue
                
                self.imgUser.sd_setImage(with: JSON(UserModelClass.current.profileImage as Any).stringValue.url()) { (image, error, sdchahe, returnUrl) in
                    if error != nil {
                        self.imgUser.image = UIImage()
                        self.imgUser.image = GFunctions.shared.setDefaultTextInProfile(text: JSON(UserModelClass.current.name as Any).stringValue)
                       // self.imgUser.isView = false
                    }
                }
            }
            else{
                GFunctions.shared.showSnackBar(message: message ?? "Error occuered ..!")
            }
        }
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
        cell.lblName.text = self.arrMenu[indexPath.row]["type"].stringValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let title = self.arrMenu[indexPath.row]["type"].stringValue
        
        switch title {
            
        case kUnderGroundReportList:
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:UGListVC.self)
            aVC.reportListType = .underGroundReport
            self.navigationController?.pushViewController(aVC, animated: true)
            
            break
            
        case kOpenCastReportlist:
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:UGListVC.self)
            aVC.reportListType = .opneCastReport
            self.navigationController?.pushViewController(aVC, animated: true)
            
            break
            
        case kUnderGroundReportDraft:
           
            let vc = AppStoryBoard.main.viewController(viewControllerClass:UnderGroundMappingReportListDraftVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case kOpenCastReportDraft :
            
            let vc = AppStoryBoard.main.viewController(viewControllerClass:OpenCastMappingListDraftVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case kEditProfile:
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: ProfileVC.self)
            aVC.didCompletion = { completion in
                
                self.apiCalling()
            }
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
            
        case kAboutUs:
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: WebViewVC.self)
            aVC.titleString = title
            self.navigationController?.pushViewController(aVC, animated: true)
            
            break
            
        case kSupport:
            
            if checkInternet(true) == false {
                return
            }
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:SupportPopupVC.self)
            aVC.modalPresentationStyle = .overFullScreen
            self.present(aVC, animated: false, completion :{
                aVC.openPopUpVisiable()
            })
            
            break
            
        case kContantUs:
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass:ContactUSVC.self)
            self.navigationController?.pushViewController(aVC, animated: true)

            break
            
        default:
            
            if checkInternet(true) == false {
                return
            }
            
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: AlertPopUpVC.self)
            aVC.titleText = kLogout
            aVC.detailText = kLogoutPermissionAlertMsg
            aVC.firstButtonTitle = kYes
            aVC.secondButtonTitle = kNo
            aVC.modalPresentationStyle = .overFullScreen
            aVC.delegate = self
            
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
            if checkInternet(true) == false {
                return
            }
                        
            let logoutVM = LogoutViewModel()
            logoutVM.callLogoutAPI(completion: { success in
//                APPDELEGATE.logout()
            })
         
        }
    }
    
}
