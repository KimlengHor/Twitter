//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by hor kimleng on 2/21/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    //Variables
    let key = "userLoggedIn"
    var tweetArray = [NSDictionary]()
    var numberOfTweet = 0
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet(load: true)
        myRefreshControl.addTarget(self, action: #selector(loadTweet(load:)), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }

    @objc func loadTweet(load: Bool) {
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        if load {
            numberOfTweet = numberOfTweet + 10
        } else {
            numberOfTweet = 10
        }
        
        let paramerters = ["count": numberOfTweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: paramerters, success: { (tweets) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }, failure: { (error) in
            print(error)
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadTweet(load: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        cell.setupCell(tweetArray: tweetArray, index: indexPath.row)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    //Actions
    @IBAction func logout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: key)
        self.dismiss(animated: true, completion: nil)
    }
    
}
