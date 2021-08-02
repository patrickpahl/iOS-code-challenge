//
//  ImageViewExtension.swift
//  ios-code-challenge
//
//  Created by Patrick Pahl on 8/1/21.
//  Copyright © 2021 Dustin Lange. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func imageFromServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                guard let data = data else { return }
                
                let image = UIImage(data: data)
                self.image = image
            })
            
        }).resume()
    }
}
