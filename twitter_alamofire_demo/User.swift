//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    var name: String?
    var screenName: String?
    var profileImageUrl: String?
    var profileImage: UIImage?
    
    static var current: User?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url_https"] as? String
        profileImage = UIImage()
        
        // Initialize any other properties
    }
}
