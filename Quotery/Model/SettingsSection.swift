//
//  SettingsSection.swift
//  Quotery
//
//  Created by Admin on 12/18/20.
//

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    
    case Communications
    
    var description: String {
        switch self {
        case .Communications:
            return "Communication"
        }
    }
}

enum CommunicationsOptions: Int, CaseIterable, CustomStringConvertible {
    case notifications
   
    
    var description: String {
        switch self {
        case .notifications:
            return "Push Notifications"
        }
    }
}
