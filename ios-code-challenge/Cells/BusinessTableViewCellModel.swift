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
        return "Rating: TEST" //todo
    }
    
    var reviewCountText: String {
        return "Review Count: TEST" //todo
    }
    
    var distanceText: String {
        return "Distance: TEST" //todo
    }
    
    var categoriesText: String {
        return "Categories: TEST" //todo
    }
    
    init(business: Business) {
        self.business = business
    }
    
}
