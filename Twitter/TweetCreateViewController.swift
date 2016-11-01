//
//  TweetCreateViewController.swift
//  Twitter
//
//  Created by Mary Martinez on 10/31/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol TweetCreateViewControllerDelegate {
    @objc optional func didCreateTweet(tweet: Tweet)
}

class TweetCreateViewController: UIViewController {

    @IBAction func onCancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTweetButton(_ sender: AnyObject) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        let tweetDictionary: NSDictionary = [
            "id"   : Int(arc4random()),
            "user" : user.dictionary,
            "text" : tweetTextView.text,
            "created_at" : formatter.string(from: date)
        ]
        
        let tweet = Tweet(dictionary: tweetDictionary)
        
        delegate?.didCreateTweet!(tweet: tweet)
        dismiss(animated: true, completion: nil)
        
//        TwitterClient.sharedInstance?.createTweet(status: tweetTextView.text, success: {
//            print("\n\nYay!!\n\n")
//            
//        }, failure: { (error) in
//            print(error)
//        })
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
    weak var delegate: TweetCreateViewControllerDelegate?
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImageView.setImageWith(user.profileURL!)
        userNameLabel.text = user.name!
        userHandleLabel.text = "@\(user.screenname!)"
        
        userImageView.layer.cornerRadius = 3
        userImageView.clipsToBounds = true
    }

}
