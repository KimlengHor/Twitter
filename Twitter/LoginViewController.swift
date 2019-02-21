//
//  LoginViewController.swift
//  Twitter
//
//  Created by hor kimleng on 2/15/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var loginButton: UIButton!
    
    //Variables
    let key = "userLoggedIn"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loginButton.layer.cornerRadius = 24
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: key) {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    
    //Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        let url = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: url, success: {
            UserDefaults.standard.set(true, forKey: self.key)
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (error) in
            print("Can not log in")
        })
    }
    

}
