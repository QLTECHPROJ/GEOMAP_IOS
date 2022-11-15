//
//  AppDelegate.swift
//  NSC_iOS
//
//  Created by Dhruvit on 26/04/22.
//

import UIKit

import Firebase
import IQKeyboardManagerSwift

@_exported import SwiftyJSON

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var appVersionDetails : JSON = .null
    
    static let shared = UIApplication.shared.delegate as! AppDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Set App Notification Count to "0" on App Launch
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        // IQKeyboardManager Setup
        self.basicSetUp()
        
        // Ask for Push Notification Permission
        self.openPushNotificationPermissionAlert()
        
        // Firebase Configuration
        FirebaseApp.configure()
        Messaging.messaging().delegate = self // Firebase Cloud Messaging
        
        // UIFont setup for
        UIFont.overrideInitialize()
        
        return true
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        let value = USERDEFAULTS.bool(forKey: UserDefaultsKeys.isUserLogin.rawValue)
        print(value)
    
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.onResumeApp()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
       
    }
    
    
    func onResumeApp(){
        
        let value = USERDEFAULTS.bool(forKey: UserDefaultsKeys.isUserLogin.rawValue)
        print(value)
        
        let loginVM = LoginViewModel()
        loginVM.callAPIVersionUpdate { responseJson, statusCode, message, completion in
            if completion, let _ = responseJson{
                debugPrint(responseJson)
                self.appVersionDetails = responseJson!["ResponseData"]
            }
        }
        
        if value , USERDEFAULTS.value(forKey: UserDefaultsKeys.kLoginUserData.rawValue) != nil{
            
            debugPrint("Logged In")
            let viewModelProfile = ProfileViewModel()
            viewModelProfile.callAPIGetUserProfile { responseJson, statusCode, message, completion in
                if completion, let data = responseJson{
                    debugPrint(data)
                }
            }
        }
    }
}




// MARK: - Push Notification SetUp
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func openPushNotificationPermissionAlert() {
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        GFunctions.shared.saveDeviceTokenIntoUserDefault(object: deviceToken.hexString  as AnyObject, key: UserDefaultsKeys.kDeviceToken.rawValue)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("didFailToRegisterForRemoteNotificationsWithError :- ",error.localizedDescription)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler(
        [UNNotificationPresentationOptions.alert,
         UNNotificationPresentationOptions.sound,
         UNNotificationPresentationOptions.badge])
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("Notification Payload :- ",userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        print("Notification Payload :- ",userInfo)
    }
    
}

extension AppDelegate : MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        FCM_TOKEN = fcmToken ?? ""
        print("FCM_TOKEN :- ",FCM_TOKEN)
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
    
}

extension AppDelegate {
    
    // Extract User Info from Push Notification
    func extractUserInfo(userInfo: [AnyHashable : Any]) -> (title: String, body: String) {
        var info = (title: "", body: "")
        guard let aps = userInfo["aps"] as? [String: Any] else { return info }
        guard let alert = aps["alert"] as? [String: Any] else { return info }
        let title = alert["title"] as? String ?? ""
        let body = alert["body"] as? String ?? ""
        info = (title: title, body: body)
        return info
    }
    
}



//----------------------------------------------------------------------------
//MARK: - Basic set up func
//----------------------------------------------------------------------------
extension AppDelegate{
    
    func basicSetUp() {
        self.setRootController()        //Set Root View Cotroller
        self.setUpIQKeyBoardManager()       //Keyboard Set-Up
        // Register for remote notification
//        self.configureGoogleMapKey()        // Set up google service
//                self.perform(#selector(self.networkRechability), with: nil, afterDelay: 3.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            LocationManager.shared.getLocation() // Ask to enable location service
//            self.registerForPushNotification()
        }
    }

    func configureGoogleMapKey(){
        
//        GMSServices.provideAPIKey(GoogleKeys.ServiceKey.rawValue)
//        GMSPlacesClient.provideAPIKey(GoogleKeys.iOSServiceKey.rawValue)
//        GMSPlacesClient.provideAPIKey(GoogleKeys.GoogleClientID.rawValue)
    }
    
    func setUpIQKeyBoardManager() {
        IQKeyboardManager.shared.enable                                        = true
        IQKeyboardManager.shared.enableAutoToolbar                              = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField                    = 5
        IQKeyboardManager.shared.shouldResignOnTouchOutside                       = true
    }
    
    func setRootController() {
        
        let value = USERDEFAULTS.bool(forKey: UserDefaultsKeys.isUserLogin.rawValue)
        print(value)
        
        if value /* USERDEFAULTS.value(forKey: UserDefaultsKeys.kLoginUserData.rawValue) != nil*/{
           
            self.updateWindow(.home)
            
        }else{

            self.updateWindow()
        }
    }
    
    func updateWindow(_ windowTag : openWindorTag = .login){
        
        if windowTag == .home{
            
            self.setHomePage()
        }
        else{
            self.setLoginPage()
        }
    }
    
    //MARK: - SetHome page
    func setHomePage(){
        UserModelClass.current.getUserDetailFromDefaults()
        USERDEFAULTS.set(true, forKey: UserDefaultsKeys.isUserLogin.rawValue)
        USERDEFAULTS.synchronize()
        let homeNavVC  = AUTHENTICATION.instantiateViewController(withIdentifier: "NavHome") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = homeNavVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
    //-----------------------------------------------------------
    //MARK: - SetLogin page
    
    func setLoginPage(){
      
        USERDEFAULTS.set(false, forKey: UserDefaultsKeys.isUserLogin.rawValue)
        USERDEFAULTS.synchronize()
        
        let loginNavVC = AUTHENTICATION.instantiateViewController(withIdentifier: "NavLogin") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = loginNavVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
}
