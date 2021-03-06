//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate {
    func did(post: Tweet) {
        fetch()
    }
    
    
    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl : UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.didPullToReFresh(_:)), for: .valueChanged)
       // refreshControl.addTarget(self, action: #selector(LogoutViewController.didPullToReFresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        fetch()
        
        
    }
    
    @IBAction func didTapCompose(_ sender: Any) {
         self.performSegue(withIdentifier: "composeSegue", sender: nil)
        
        
    }
    
    @IBAction func onProfileClick(_ sender: Any) {
        self.performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
//        let imagePath = URL(string: cell.tweet.user.profileImageUrl!)
//        cell.userImage.af_setImage(withURL: imagePath!)
       // cell.userImage.af_setImage(withUrl: tweet.user.profileImageUrl)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController{
            let senderCell = sender as! TweetCell
            let indexPath = tableView.indexPath(for: senderCell)
            vc.tweet = tweets[(indexPath?.row)!]
        }

        
    }
    
  
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    @objc func didPullToReFresh(_ refreshControl: UIRefreshControl){
        fetch()
    }
    func fetch(){
       print("Reloading Data")
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        
        
        
        
        
    }
    
   
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
