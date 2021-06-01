//
//  AppDelegate.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import CoreData
import SnapKit
import IQKeyboardManager
import SwiftyJSON
import Firebase
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static var deviceToken: String = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared().isEnabled = true
        AppCenter.shared.createWindow(window!)
        AppCenter.shared.start()
        FirebaseApp.configure()
        registerForRemoteNotification(application: application)
        Messaging.messaging().delegate = self
        Messaging.messaging().subscribe(toTopic: "dauletten")

//        Messaging.messaging().subscribe(toTopic: "newCourse")


        // Override point for customization after application launch.
        return true
    }

    func registerForRemoteNotification(application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

        Messaging.messaging().shouldEstablishDirectChannel = false

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

        Messaging.messaging().shouldEstablishDirectChannel = false

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        Messaging.messaging().shouldEstablishDirectChannel = true

    }

    func applicationWillTerminate(_ application: UIApplication) {

        Messaging.messaging().shouldEstablishDirectChannel = false

    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
                AppDelegate.deviceToken = fcmToken
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        print("ios10 willPresent notification: ", userInfo)
        completionHandler([.alert, .badge, .sound])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let notifyInfo = response.notification.request.content.userInfo
        
        let json = JSON(notifyInfo)
        let jsonModel =  PushModel(json: json)
        let pushOpen = PushOpenType(rawValue: jsonModel.type)
        pushOpen?.openType(id: jsonModel.id)
        completionHandler()
    }
    
}

extension AppDelegate: MessagingDelegate {
    
}

