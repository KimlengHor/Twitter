//
//  UserInfoViewController.swift
//  Twitter
//
//  Created by hor kimleng on 2/28/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class UserInfoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var tweets: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var followers: UILabel!
    
    var userInfo = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadUserInfo { (dictionary) in
            self.userInfo = dictionary
            let user = self.userInfo[0]["user"] as! [String:Any]
            let taglineText = user["screen_name"] as! String
            let followersCount = user["followers_count"] as! Int
            let tweets = user["listed_count"] as! Int
            let following = user["friends_count"] as! Int
            let imageString = user["profile_image_url"] as! String
            self.imageView.af_setImage(withURL: URL(string: imageString)!)
            self.tagLine.text = taglineText
            self.followers.text = String("Followers: \(followersCount)")
            self.tweets.text = String("#Tweets: \(tweets)")
            self.following.text = String("Following: \(following)")
        }
    }
    
    fileprivate func loadUserInfo(success: @escaping ([NSDictionary]) -> ()) {
        let url = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        TwitterAPICaller.client?.get(url, parameters: ["screen_name": "hor_kimleng"], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            //print(response)
            success(response as! [NSDictionary])
           //print(user["screen_name"])
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error)
        })
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
