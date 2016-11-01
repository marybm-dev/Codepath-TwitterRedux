//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Mary Martinez on 10/31/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking

class TweetTableViewCell: UITableViewCell {

    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text!
            timestampLabel.text = tweet.display(date: tweet.timestamp!)
            retweetCountLabel.text = "\(tweet.retweetCount)"
            favoritesCountLabel.text = "\(tweet.favoritesCount)"
            
            userImageView.setImageWith((tweet.user?.profileURL)!)
            userNameLabel.text = tweet.user?.name
            userHandleLabel.text = "@\((tweet.user?.screenname)!)"
        }
    }
    
    var retweeted = false
    var liked = false
    
    @IBOutlet weak var retweetNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func onReplyButton(_ sender: AnyObject) {
        print("reply button")
    }
    
    @IBAction func onRetweetButton(_ sender: AnyObject) {

        if !retweeted {
            // post via Twitter API - POST
            TwitterClient.sharedInstance?.retweetTweet(id: tweet.id, success: {_ in
                
                // update count label
                self.tweet.retweetCount += 1
                self.retweetCountLabel.text = "\(self.tweet.retweetCount)"
                
                // update image
                self.retweetButton.setImage(UIImage(named: "retweetFilled"), for: .normal)
                self.retweeted = true
                
            }) { (error: Error) in
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func onLikeButton(_ sender: AnyObject) {

        if !liked {
            // post via Twitter API - POST
            TwitterClient.sharedInstance?.favoriteTweet(id: tweet.id, success: {_ in
                
                // update count label
                self.tweet.favoritesCount += 1
                self.favoritesCountLabel.text = "\(self.tweet.favoritesCount)"
                
                // update image
                self.likeButton.setImage(UIImage(named: "likeFilled"), for: .normal)
                self.liked = true
                
            }) { (error: Error) in
                print("error: \(error.localizedDescription)")
            }
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = 3
        userImageView.clipsToBounds = true
    }

}
