//
//  SettingsSection.swift
//  Quotery
//
//  Created by Admin on 12/18/20.
//

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Social
    case Communications
    
    var description: String {
        switch self {
        case .Social:
            return "Social"
        case .Communications:
            return "Communication"
        }
    }
}

enum SocialOptions: Int, CaseIterable, CustomStringConvertible {
    case editProfile
    case logout
    
    var description: String {
        switch self {
        case .editProfile:
            return "Edit Profile"
        case .logout:
            return "Logout"
        }
    }
}

enum CommunicationsOptions: Int, CaseIterable, CustomStringConvertible {
    case notifications
    case email
    case reportCrashes
    
    var description: String {
        switch self {
        case .notifications:
            return "Notifications"
        case .email:
            return "Email"
        case .reportCrashes:
            return "Report Crashes"
        }
    }
}
