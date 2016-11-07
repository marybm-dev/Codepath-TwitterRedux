//
//  ProfileTableViewCell.swift
//  Twitter
//
//  Created by Mary Martinez on 11/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class UserHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var userTweetsCountLabel: UILabel!
    @IBOutlet weak var userFollowingCountLabel: UILabel!
    @IBOutlet weak var userFollowersCountLabel: UILabel!
    
    var user: User! {
        didSet {
            userImageView.setImageWith((user.profileURL)!)
            userNameLabel.text = user.name
            userHandleLabel.text = "@\((user.screenname)!)"
            
            userTweetsCountLabel.text = "\(user.tweetsCount!)"
            userFollowersCountLabel.text = "\(user.followersCount!)"
            userFollowingCountLabel.text = "\(user.followingCount!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = 3
        userImageView.clipsToBounds = true
    }

}
