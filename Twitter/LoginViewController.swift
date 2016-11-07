//
//  LoginViewController.swift
//  Twitter
//
//  Created by Mary Martinez on 10/28/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onLoginButton(_ sender: AnyObject) {
        
        TwitterClient.sharedInstance?.login(success: {
            if let myDelegate = UIApplication.shared.delegate as? AppDelegate {
                myDelegate.loginSucces()
            }
            
            
        }) { (error: Error) in
                print("error: \(error.localizedDescription)")
        }
    }

}
