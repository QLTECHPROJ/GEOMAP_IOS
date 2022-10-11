//
//  SplashVC.swift
//  NSC_iOS
//
//  Created by Dhruvit on 26/04/22.
//

import UIKit

class SplashVC: BaseViewController {
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Wait 2 Seconds for FCM Token
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let appVersionVM = AppVersionViewModel()
            appVersionVM.callAppVersionAPI(completion: { success in
                if success {
                    self.handleAppUpdatePopup()
                }
            })
        }
    }
    
    
    // MARK: - FUNCTIONS
    func handleAppUpdatePopup() {
        if AppVersionDetails.IsForce == "1" {
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: AlertPopUpVC.self)
            aVC.titleText = Theme.strings.force_update_title
            aVC.detailText = Theme.strings.force_update_subtitle
            aVC.firstButtonTitle = Theme.strings.update
            aVC.hideSecondButton = true
            aVC.modalPresentationStyle = .overFullScreen
            aVC.delegate = self
            self.present(aVC, animated: false, completion: nil)
        } else if AppVersionDetails.IsForce == "0" {
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: AlertPopUpVC.self)
            aVC.titleText = Theme.strings.normal_update_title
            aVC.detailText = Theme.strings.normal_update_subtitle
            aVC.firstButtonTitle = Theme.strings.update
            aVC.secondButtonTitle = Theme.strings.not_now
            aVC.modalPresentationStyle = .overFullScreen
            aVC.delegate = self
            self.present(aVC, animated: false, completion: nil)
        } else {
            self.handleRedirection()
        }
    }
    
    func handleRedirection() {
        if LoginDataModel.currentUser != nil {
            if checkInternet() {
                let coachDetailVM = CoachDetailViewModel()
                coachDetailVM.callCoachDetailsAPI { success in
                    if success {
                        self.handleLoginUserRedirection()
                    } else {
                        APPDELEGATE.logout()
                    }
                }
            }
        } else {
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: LoginVC.self)
            self.navigationController?.pushViewController(aVC, animated: true)
        }
    }
    
}


// MARK: - AlertPopUpVCDelegate
extension SplashVC : AlertPopUpVCDelegate {
    
    func handleAction(sender: UIButton, popUpTag: Int) {
        if sender.tag == 0 {
            if AppVersionDetails.IsForce == "1" {
                self.openUrl(urlString: APP_APPSTORE_URL)
            } else {
                self.openUrl(urlString: APP_APPSTORE_URL)
                let aVC = AppStoryBoard.main.viewController(viewControllerClass: LoginVC.self)
                self.navigationController?.pushViewController(aVC, animated: true)
            }
        } else {
            let aVC = AppStoryBoard.main.viewController(viewControllerClass: LoginVC.self)
            self.navigationController?.pushViewController(aVC, animated: true)
        }
    }
    
}
