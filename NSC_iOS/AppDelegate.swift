//
//  AppDelegate.swift
//  NSC_iOS
//
//  Created by Dhruvit on 26/04/22.
//

import UIKit
import CoreData
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
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
        
//        window?.makeKeyAndVisible()
//        window?.rootViewController = AppStoryBoard.main.intialViewController()
        
        return true
    }
    
    func logout() {
        LoginDataModel.currentUser = nil
        
        let aVC = AppStoryBoard.main.viewController(viewControllerClass: LoginVC.self)
        aVC.makeRootController()
    }
    
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
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "NSC_iOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


// MARK: - UIApplication Life Cycle Events
extension AppDelegate {
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Set App Notification Count to "0" on App Launch
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        if AppVersionDetails.IsForce == "1" {
            window?.rootViewController = AppStoryBoard.main.intialViewController()
        }
    }
    
}


// MARK: - Push Notification SetUp
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        DEVICE_TOKEN = deviceToken.hexString
        print("DEVICE_TOKEN :- ",DEVICE_TOKEN)
        Messaging.messaging().apnsToken = deviceToken
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
//        USERMODEL.current.getUserDetailFromDefaults()
        USERDEFAULTS.set(true, forKey: UserDefaultsKeys.isUserLogin.rawValue)
        USERDEFAULTS.synchronize()
        let homeNavVC  = AUTHENTICATION.instantiateViewController(withIdentifier: "NavHome") as! UINavigationController
        //let navigationVC = UINavigationController(rootViewController: tabBarVC)
        //UIApplication.shared.windows.first?.rootViewController = navigationVC
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
