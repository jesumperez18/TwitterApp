//
//  LimitTableViewCell.swift
//  twitter_alamofire_demo
//
//  Created by Jesus perez on 3/8/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class LimitTableViewCell: UITableViewCell {

    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favLabel: UILabel!
    
    var tweet: Tweet! {
        didSet{
            
            retweetLabel.text = formatCounter(count: tweet.retweetCount)
            favLabel.text = formatCounter(count: tweet.favoriteCount!)
        }
    }
    func formatCounter(count: Int) -> String{
        var formattedCount = ""
        // Billion, just in case
        if(count >= 1000000000){
            formattedCount = String(format: "%.1fb", Double(count) / 1000000000.0)
        }
        else if(count >= 1000000){
            formattedCount = String(format: "%.1fm", Double(count) / 1000000.0)
        }
        else if(count >= 10000){
            formattedCount = String(format: "%.1fk", Double(count) / 1000.0)
        }
        else{
            formattedCount = "\(count)"
        }
        
        return formattedCount
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
