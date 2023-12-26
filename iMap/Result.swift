//
//  Result.swift
//  iMap
//
//  Created by A.f. Adib on 12/26/23.
//

import Foundation

struct Result : Codable {
    let query: Query
}

struct Query: Codable {
    let pages : [Int : Page]
}

struct Page : Codable, Comparable {
    let pageId : Int
    let title : String
    let terms : [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No Description"
    }
    
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
