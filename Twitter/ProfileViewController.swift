//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Mary Martinez on 11/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "TweetCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TweetCellNib")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        self.fetchData()
    }
    
    // Mark: - App Logic
    func fetchData() {
        TwitterClient.sharedInstance?.userTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return tweets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserHeaderCell", for: indexPath) as! UserHeaderTableViewCell
            
            cell.user = self.user
            return cell
            
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCellNib", for: indexPath) as! TweetCell
            
            cell.tweet = self.tweets[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 200
        } else {
            return 150
        }
    }
}
