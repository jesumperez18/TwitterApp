//
//  ProfileViewCell.swift
//  twitter_alamofire_demo
//
//  Created by Jesus perez on 3/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {
    
    
    
    var user : User! {
        didSet{
           
            profileImage.af_setImage(withURL: user.profile_url)
            profileImage.layer.cornerRadius = 34
            profileImage.clipsToBounds = true
          
            tweet.text = String(user.numberOfTweets)
            followers.text = "\(user.followersCount ?? -1)"
            following.text = "\(user.followingCount ?? -1)"
        }
    }
   
   
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweet: UILabel!
    
    @IBOutlet weak var followers: UILabel!
   
    @IBOutlet weak var following: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
