//
//  Business.swift
//  ios-code-challenge
//
//  Created by Patrick Pahl on 8/1/21.
//  Copyright © 2021 Dustin Lange. All rights reserved.
//

import Foundation

struct BusinessesTotal: Codable {
    let businesses: [Business]
}

struct Business: Codable {
    let name: String
    let rating: Double
    let review_count: Int
    let distance: Double
    let image_url: String
    let categories: [Categories]
}

struct Categories: Codable {
    let title: String
}

extension Data {
    func printJSON() {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            print(JSONString)
        }
    }
}
