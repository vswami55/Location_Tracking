//
//  AppDelegate.swift
//  AssignmentApp
//
//  Created by Virender Swami on 06/04/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    let notificationCenter = UNUserNotificationCenter.current()
   
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Confirm Delegete and request for permission
               notificationCenter.delegate = self
               let options: UNAuthorizationOptions = [.alert, .sound, .badge]
               notificationCenter.requestAuthorization(options: options) {
                   (didAllow, error) in
                   if !didAllow {
                       print("User has declined notifications")
                   }
               }
        
        return true
    }
    // MARK: - Core Data stack

    func applicationWillTerminate(_ application: UIApplication) {
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
            // Saves changes in the application's managed object context before the application terminates.
            CoreDatabase.sharedManager.saveContext()
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    // Local notifications
    //Handle Notification Center Delegate methods
       func userNotificationCenter(_ center: UNUserNotificationCenter,
                                   willPresent notification: UNNotification,
                                   withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
           completionHandler([.alert, .badge, .sound])
       }

       func userNotificationCenter(_ center: UNUserNotificationCenter,
                                   didReceive response: UNNotificationResponse,
                                   withCompletionHandler completionHandler: @escaping () -> Void) {
           UIApplication.shared.applicationIconBadgeNumber = 0
           let userInfo = response.notification.request.content.userInfo
           print(userInfo)
           if response.notification.request.identifier == "Local Notification" {
               NotificationCenter.default.post(name: Notification.Name("ReceivedLocalNotification"), object: nil)
               print("Handling notifications with the Local Notification Identifier")
           }
           completionHandler()
       }
    
    //MARK: Local Notification Methods Starts here
        //Prepare New Notificaion with deatils and trigger
        func scheduleNotification(notificationType: String) {

            //Compose New Notificaion
            let content = UNMutableNotificationContent()
            let categoryIdentifire = "Delete Notification Type"
            content.sound = UNNotificationSound.default
            content.body =  notificationType
            content.badge = 1
            content.categoryIdentifier = categoryIdentifire

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let identifier = "Local Notification"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

            notificationCenter.add(request) { (error) in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                }
            }
        }
}

