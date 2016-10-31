//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Mary Martinez on 10/31/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text!
        }
    }
    
    @IBOutlet weak var retweetNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    
    @IBAction func onReplyButton(_ sender: AnyObject) {
        
    }
    
    @IBAction func onRetweetButton(_ sender: AnyObject) {
        
    }
    
    @IBAction func onLikeButton(_ sender: AnyObject) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
