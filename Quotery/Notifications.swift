//
//  Notifications.swift
//  Quotery
//
//  Created by Admin on 1/19/21.
//

import Foundation
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let center = UNUserNotificationCenter.current()
    let userDefaults = UserDefaults()
    let calender = Calendar.current
    
    func notificationsRequest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if !granted {
                print("User declined notifications")
            }
        }
    }
    
    func scheduleNotifications() {
        
        
        
        let content = UNMutableNotificationContent()
        content.title = "Quotery"
        content.body = "View your Quote of the Day"
        content.sound = .default
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)
        
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if error != nil {
                print(error!)
            }
        }
    }
    
    func removeNotifications() {
        center.removeAllPendingNotificationRequests()
    }
}
