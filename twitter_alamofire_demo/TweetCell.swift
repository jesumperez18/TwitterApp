//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import LBTAComponents
import Alamofire
import AlamofireImage




class TweetCell: UITableViewCell {
    
    @IBOutlet weak var created_at: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screen_name: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var favorited: UILabel!
    @IBOutlet weak var retweeted: UILabel!
  
    @IBOutlet weak var userImage: UIImageView!
    
    
    
    
    var tweet: Tweet! {
        didSet {
            
            let url = tweet.user.profile_url
            userImage.af_setImage(withURL: url)

            tweetTextLabel.text = tweet.text
            created_at.text = tweet.createdAtString
            username.text = tweet.user.name
            screen_name.text = tweet.user.screenName
            
            retweeted.text = "\(tweet.retweetCount)"
            favorited.text = "\(tweet.favoriteCount ?? 0)"
            //profileImageView.loadImage(urlString: tweet.user.profileImageUrl!)
            
        
            
        }
    }
    let profileImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.image = #imageLiteral(resourceName: "profile-Icon")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    @IBAction func didTapRe(_ sender: Any){
        
        if(tweet.retweeted == false){
            tweet.retweeted = true
            tweet.retweetCount += 1
        
            retweeted.text = "\(tweet.retweetCount)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        
        
        
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else
        {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            retweeted.text = "\(tweet.retweetCount)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            
            
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
            
    }
    
    @IBAction func didTapFav(_ sender: Any) {
        if(tweet.favorited == false){
            tweet.favorited = true
            tweet.favoriteCount! += 1
        
            favorited.text = "\(tweet.favoriteCount!)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else{
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            
            favorited.text = "\(tweet.favoriteCount!)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
            
            
        }
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
