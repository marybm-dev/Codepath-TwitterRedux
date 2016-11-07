//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Mary Martinez on 10/29/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCreateViewControllerDelegate {

    var tweets = [Tweet]()
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // init refresh control
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        self.fetchData(shouldRefresh: false)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 135
    }

    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
    }
    
    // Mark: - App Logic
    func fetchData(shouldRefresh: Bool) {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            
            }, failure: { (error: Error) in
                print(error.localizedDescription)
        })
        
        // if refreshing, stop
        if shouldRefresh {
            self.refreshControl.endRefreshing()
        }
    }
    
    // Mark: - TweetCreateViewControllerDelegate
    func didCreateTweet(tweet: Tweet) {
        tweets.insert(tweet, at: 0)
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTweetDetail" {
            let tweet = sender as! Tweet
            let tweetDetailVC = segue.destination as! TweetDetailViewController
            
            tweetDetailVC.tweet = tweet
        }
        else if segue.identifier == "CreateTweet" {
            let navigationController = segue.destination as! UINavigationController
            let tweetCreateVC = navigationController.topViewController as! TweetCreateViewController
            
            tweetCreateVC.user = User.currentUser
            tweetCreateVC.delegate = self
        }
        
    }
 
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
        cell.parentViewController = self
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweet = tweets[indexPath.row]
        
       self.performSegue(withIdentifier: "ShowTweetDetail", sender: tweet)
    }
    // Mark: - Refresh control
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.fetchData(shouldRefresh: true)
    }
}
