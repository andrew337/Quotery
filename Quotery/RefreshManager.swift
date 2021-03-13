//
//  RefreshManager.swift
//  Quotery
//
//  Created by Admin on 3/5/21.
//

import Foundation

class RefreshManager: NSObject {
    
    let quoteManager = QuoteManager()
    
    static let shared = RefreshManager()
    private let defaults = UserDefaults.standard
    private let defaultsKey = "Last Refresh"
    private let calender = Calendar.current
    
    func loadDataIfNeeded(completion: (Bool) -> Void) {
        if isRefreshRequired() {
            quoteManager.performRequest()
            defaults.set(Date(), forKey: defaultsKey)
            completion(true)
        } else {
            completion(false)
        }
    }
    
    private func isRefreshRequired() -> Bool {
        
        guard let lastRefreshDate = defaults.object(forKey: defaultsKey) as? Date else {
                return true
            }
        if let diff = calender.dateComponents([.hour], from: lastRefreshDate, to: Date()).hour, diff > 12 {
                return true
            } else {
                return false
            }
    }
    
}
