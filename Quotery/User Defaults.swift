//
//  User Defaults.swift
//  Quotery
//
//  Created by Admin on 1/19/21.
//

import Foundation

extension UserDefaults {
    
    static func getDate() -> Date? {
        if let time = UserDefaults.standard.string(forKey: "notificationTime") {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            if let date = dateFormatter.date(from: time) {
                return date
            }
        }

        return nil
    }
    
}
