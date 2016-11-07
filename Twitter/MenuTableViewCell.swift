//
//  MenuTableViewCell.swift
//  Twitter
//
//  Created by Mary Martinez on 11/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemLabel: UILabel!
    @IBOutlet weak var menuIconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
