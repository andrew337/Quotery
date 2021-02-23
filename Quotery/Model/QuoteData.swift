//
//  QuoteData.swift
//  Quotery
//
//  Created by Admin on 12/8/20.
//

import Foundation


struct QuoteData: Codable {
    
    let contents: Contents
}

struct Contents: Codable {
    let quotes: [Quotes]
}

struct Quotes: Codable {
    let author: String
    let quote: String
}


