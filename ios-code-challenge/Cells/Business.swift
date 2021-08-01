//
//  Business.swift
//  ios-code-challenge
//
//  Created by Patrick Pahl on 8/1/21.
//  Copyright © 2021 Dustin Lange. All rights reserved.
//

import Foundation

struct Business: Codable {
    let name: String
    let rating: String
    let reviewCount: Int
    let distance: Double
    let thumbnailString: String
    let categories: [String]
}
