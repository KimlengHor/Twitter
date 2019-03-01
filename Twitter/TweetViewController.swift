//
//  TweetViewController.swift
//  Twitter
//
//  Created by hor kimleng on 2/28/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    //IBOulets
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    
    
    fileprivate func setUpView() {
        tweetTextView.becomeFirstResponder()
        tweetTextView.layer.cornerRadius = 5
        tweetTextView.layer.borderWidth = 2
        tweetTextView.layer.borderColor = #colorLiteral(red: 0.1148131862, green: 0.6330112815, blue: 0.9487846494, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        tweetTextView.delegate = self
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 140
        let newText = NSString(string: tweetTextView.text).replacingCharacters(in: range, with: text)
        countLabel.text = String(140 - newText.count)
        return newText.count < characterLimit
    }
    
    //Actions
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet ", error)
            })
        }
    }
    
}
