//
//  TwitterClient.swift
//  Twitter
//
//  Created by Mary Martinez on 10/29/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let twitterBaseURL = URL(string: "https://api.twitter.com")
    static let consumerKey = "NtI8Fez6H7V5dcWSULW7GXAMs"
    static let consumerSecret = "eroAV8Ro6Z2e1xQl4af4Cs2x1HsHIRZbho89aIwxe5dwZ0NU01"
    static let sharedInstance = TwitterClient(baseURL: twitterBaseURL, consumerKey: consumerKey, consumerSecret: consumerSecret)
    
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oath"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            
            print("I got a request token")
            
            guard let token = requestToken else {
                return
            }
            
            let authToken = token.token!
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(authToken)")!
            UIApplication.shared.openURL(url)
            
            }, failure: { (error: Error?) in
                self.loginFailure!(error!)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: User.didLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken!, success: { (accessToken: BDBOAuth1Credential?) in
            
                print("I got an access token")
                
                self.currentAccount(success: { (user: User) in
                    User.currentUser = user
                    self.loginSuccess?()
                    print("User logged in")
                    
                }, failure: { (error: Error) in
                    print("error: \(error.localizedDescription)")
                    self.loginFailure?(error)
                })
            
            }, failure: { (error: Error?) in
                print("error: \(error?.localizedDescription)")
                self.loginFailure?(error!)
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task :URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            print("\nI got tweets \nCount:\(tweets.count)\n")
            success(tweets)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        })
    }
    
    func userTimeline(screenName: String, success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/user_timeline.json", parameters: ["screen_name": screenName], progress: nil, success: { (task :URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            print("\nI got user tweets \nCount:\(tweets.count)\n")
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func mentionsTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/mentions_timeline.json", parameters: nil, progress: nil, success: { (task :URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            print("\nI got user mentions \nCount:\(tweets.count)\n")
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)

            success(user)
            
        }, failure: { (task: URLSessionTask?, error: Error) in
            failure(error)
        })
    }
    
    func favoriteTweet(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        
        let params: [String : AnyObject] = ["id": id as AnyObject]
        print(params)
        
        post("1.1/favorites/create.json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error)
            failure(error)
        })
    }
    
    func retweetTweet(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()) {

        let params: [String : AnyObject] = ["id": id as AnyObject]
        
        post("1.1/statuses/retweet/\(id).json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error)
            failure(error)
        })
    }
    
    // TODO: update the POST function to return the Tweet object
    func createTweet(status: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        
        let params: [String : AnyObject] = ["status": status as AnyObject]
        
        post("1.1/statuses/update.json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
    
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error)
            failure(error)
        })
    }
}
