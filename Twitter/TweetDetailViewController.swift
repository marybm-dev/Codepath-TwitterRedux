//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Mary Martinez on 10/31/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    
    var tweet: Tweet!
    var retweeted = false
    var liked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetTextLabel.text = tweet.text!
        timestampLabel.text = tweet.display(date: tweet.timestamp!)
        retweetCountLabel.text = "\(tweet.retweetCount)"
        favoritesCountLabel.text = "\(tweet.favoritesCount)"
        
        userImageView.setImageWith((tweet.user?.profileURL)!)
        userNameLabel.text = tweet.user?.name
        userHandleLabel.text = "@\((tweet.user?.screenname)!)"
        
        userImageView.layer.cornerRadius = 3
        userImageView.clipsToBounds = true

    }
    
    @IBAction func onReplyButton(_ sender: AnyObject) {
        print("reply button")
    }
    
    @IBAction func onRetweetButton(_ sender: AnyObject) {
        if !retweeted {
            self.tweet.retweetCount += 1
            self.retweetCountLabel.text = "\(self.tweet.retweetCount)"
            self.retweetButton.setImage(UIImage(named: "retweetFilled"), for: .normal)
            
            retweeted = true
        }
    }
    
    @IBAction func onFavoriteButton(_ sender: AnyObject) {
        if !liked {
            self.tweet.favoritesCount += 1
            self.favoritesCountLabel.text = "\(self.tweet.favoritesCount)"
            self.likeButton.setImage(UIImage(named: "likeFilled"), for: .normal)
            
            liked = true
        }
    }
    
}
