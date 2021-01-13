//
//  AppDelegate.swift
//  Customer0
//
//  Created by pprakash on 1/11/21.
//

// Step 3-a Import extensions
import UIKit
import UserNotifications
import AEPCore
import AEPEdge
import AEPIdentity
import AEPLifecycle
import AEPSignal
import AEPMessaging
import AEPAssurance
import ACPCore

// Step 3-b Add UNUserNotificationCenterDelegate to get the token
@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerForPushNotifications(application: application)
        
        // Mobile
        MobileCore.setLogLevel(.trace)
        AEPAssurance.registerExtension()
        
        // Step 3-c Register extension
        MobileCore.registerExtensions([Lifecycle.self, Identity.self, Messaging.self, Edge.self, Signal.self])
        ACPCore.start{
        }
        
        // Step 3-d Configure with the app id from launch
        MobileCore.configureWith(appId: "3149c49c3910/6b0bd5380287/launch-115be808dae9-development")
        
        // Step 3-e Update configuration with DCS url
        MobileCore.updateConfigurationWith(configDict: ["messaging.dccs": "https://dcs.adobedc.net/collection/ae09ee0087588c84e6318d9a4245a883dd2b003807a4b8072073ca7f1a41f091"])
        MobileCore.updateConfigurationWith(configDict: ["messaging.profileDataset": "5ffcc30cac9938194dd1eba3"])
        //MobileCore.updateConfigurationWith(configDict: ["messaging.useSandbox": true])
                
        AEPAssurance.startSession(URL(string: "griffon://?adb_validation_sessionid=404b04bd-d1d9-4e58-bc7c-8db2003b3d52")!)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // Function called when device token for the remote notification is obtained
    func application(_ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
      let token = tokenParts.joined()
      print("Device Token: \(token)")
        // Step 3-g Call set push identifier for updating profile with device token
      MobileCore.setPushIdentifier(deviceToken)
    }
    
    
    // Helper function for registering push notification. Calling this function will prompt the pop-up to receive push notification
    func registerForPushNotifications(application: UIApplication) {
      let center = UNUserNotificationCenter.current()
      center.requestAuthorization(options: [.badge, .sound, .alert]) {
        [weak self] granted, _ in
        guard granted else { return }
        
        center.delegate = self
        
        DispatchQueue.main.async {
        // Step 3-f Call register for remote notification
          application.registerForRemoteNotifications()
        }
      }
    }
    
    func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      willPresent notification: UNNotification,
      withCompletionHandler completionHandler:
      @escaping (UNNotificationPresentationOptions) -> Void) {
      
      completionHandler([.alert, .sound, .badge])
    }

    
    // 
    func application(_ application: UIApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Failed to register: \(error)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Step 3-h Handle the notification response for push tracking
        Messaging.handleNotificationResponse(response, applicationOpened: true, customActionId: nil)
    }

}

