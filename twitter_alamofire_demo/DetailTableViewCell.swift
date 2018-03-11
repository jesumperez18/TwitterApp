//
//  DetailTableViewCell.swift
//  twitter_alamofire_demo
//
//  Created by Jesus perez on 3/8/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet! {
        didSet{
            tweetLabel.text = tweet.text
            detailImage.layer.cornerRadius = 34
            detailImage.clipsToBounds = true
            detailImage.af_setImage(withURL: tweet.user.profile_url)
            nameLabel.text = tweet.user.name
            dateLabel.text = tweet.createdAtString
            
            userLabel.text = tweet.user.screenName

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
