//
//  BusinessTableViewCellModel.swift
//  ios-code-challenge
//
//  Created by Patrick Pahl on 8/1/21.
//  Copyright © 2021 Dustin Lange. All rights reserved.
//

import Foundation

class BusinessTableViewCellModel {
    
    var business: Business
    
    var ratingText: String {
        return "Rating: \(business.rating)"
    }
    
    var reviewCountText: String {
        return "Review Count: \(business.review_count)"
    }
    
    var distanceText: String {
        let distance = Int(business.distance)
        return "Distance: \(distance)"
    }
    
    var categoriesText: String {
        var text = ""
        for category in business.categories {
            let title = category.title
            text = title + ","
        }
        
        if text.last == "," {
            text.removeLast()
        }
        
        return "Categories: \(text)"
    }
    
    var priceText: String {
        return "Price: \(business.price)"
    }
    
    init(business: Business) {
        self.business = business
    }
    
}
