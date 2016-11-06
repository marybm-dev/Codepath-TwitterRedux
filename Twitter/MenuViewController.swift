//
//  MenuViewController.swift
//  Twitter
//
//  Created by Mary Martinez on 11/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var profileNavigationController: UIViewController!
    private var homeTimelineNavigationController: UIViewController!
    private var mentionsNavigationController: UIViewController!
    private var tweetsNavigationController: UIViewController!
    
    var viewControllers = [UIViewController]()
    var hamburgerViewController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController")
        homeTimelineNavigationController = storyboard.instantiateViewController(withIdentifier: "HomeTimelineNavigationController")
        mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationController")
        tweetsNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        
        viewControllers.append(profileNavigationController)
        viewControllers.append(homeTimelineNavigationController)
        viewControllers.append(mentionsNavigationController)
        viewControllers.append(tweetsNavigationController)
        
        hamburgerViewController.contentViewController = tweetsNavigationController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        
        let titles: [String] = ["Profile", "Home Timeline", "Mentions"]
        cell.detailTextLabel?.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }
}
