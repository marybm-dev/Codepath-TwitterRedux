//
//  TweetCell.swift
//  Twitter
//
//  Created by Mary Martinez on 11/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

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

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = 3
        userImageView.clipsToBounds = true
    }
    
}
