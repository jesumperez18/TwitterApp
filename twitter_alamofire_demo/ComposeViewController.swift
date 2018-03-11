//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Jesus perez on 3/5/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
//import RSKPlaceholderTextView
import UITextView_Placeholder

protocol ComposeViewControllerDelegate : NSObjectProtocol {
    
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate{
     
    

    @IBOutlet weak var composeMsg: UITextView!
    var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var composeImage: UIImageView!
    
    
    @IBOutlet weak var charCount: UILabel!
    
    @IBOutlet weak var tweetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetButton.isUserInteractionEnabled = false
        tweetButton.setTitleColor(UIColor.gray, for: .normal)
        composeImage.af_setImage(withURL: (User.current?.profile_url)!)
        composeImage.layer.cornerRadius = 35
        composeImage.clipsToBounds = true
        composeMsg.placeholder = "what's good?"
        composeMsg.placeholderColor = UIColor.lightGray
        
       
        
        composeMsg.becomeFirstResponder()
        composeMsg.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onBack(_ sender: Any) {
        print("Reached the back")
        self.performSegue(withIdentifier: "backToTimeline", sender: nil)
    }
    
    
    @IBAction func onTweet(_ sender: Any) {
        APIManager.shared.composeTweet(with: composeMsg.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onPost(_ sender: Any) {
        //print("Reached the post")
        //self.performSegue(withIdentifier: "backToTimeline", sender: nil)
        
//        APIManager.shared.composeTweet(with: composeMsg.text) { (tweet, error) in
//            if let error = error {
//                print("Error composing Tweet: \(error.localizedDescription)")
//            } else if let tweet = tweet {
//                self.delegate?.did(post: tweet)
//                print("Compose Tweet Success!")
//            }
//        }
//        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if(textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
            tweetButton.isUserInteractionEnabled = false
            tweetButton.setTitleColor(UIColor.gray, for: .normal)
        }
        else{
            tweetButton.isUserInteractionEnabled = true
            tweetButton.setTitleColor(UIColor.blue, for: .normal)
        }
    }
   
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        charCount.text = "\(characterLimit - newText.count)"
        // The new text should be allowed? True/False
        return newText.count < characterLimit
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

