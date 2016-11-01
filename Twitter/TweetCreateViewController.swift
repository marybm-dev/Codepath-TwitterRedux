//
//  TweetCreateViewController.swift
//  Twitter
//
//  Created by Mary Martinez on 10/31/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetCreateViewController: UIViewController {

    @IBAction func onCancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTweetButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
        TwitterClient.sharedInstance?.createTweet(status: tweetTextView.text, success: {
            print("\n\nYay!!\n\n")
            
        }, failure: { (error) in
            print(error)
        })
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
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
