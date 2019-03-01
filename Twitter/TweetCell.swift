//
//  TweetCell.swift
//  Twitter
//
//  Created by hor kimleng on 2/21/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var tweetLbl: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favourited = false
    var tweetId = -1
    var retweeted = false
    
    func setFavourite(_ isFavorited: Bool) {
        favourited = isFavorited
        if(favourited) {
            favButton.setImage(#imageLiteral(resourceName: "favor-icon-red").withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            favButton.setImage(#imageLiteral(resourceName: "favor-icon").withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        if (isRetweeted) {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green").withRenderingMode(.alwaysOriginal), for: .normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon").withRenderingMode(.alwaysOriginal), for: .normal)
            retweetButton.isEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(tweetArray: [NSDictionary], index: Int) {
        let user = tweetArray[index]["user"] as? NSDictionary
        let imageUrl = URL(string: user?["profile_image_url_https"] as? String ?? "")
        userNameLbl.text = user?["name"] as? String
        if let imageUrl = imageUrl {
            profileImageView.af_setImage(withURL: imageUrl)
        }
        tweetLbl.text = tweetArray[index]["text"] as? String
    }
    
    //Actions
    @IBAction func retweetButtonPressed(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print(error)
        })
    }
    
    @IBAction func favButtonPressed(_ sender: Any) {
        let tobeFavourited = !favourited
        if (tobeFavourited) {
            TwitterAPICaller.client?.favouriteTweet(tweetId: tweetId, success: {
                self.setFavourite(true)
            }, failure: { (error) in
                print(error)
            })
        } else {
            TwitterAPICaller.client?.unfavouriteTweet(tweetId: tweetId, success: {
                self.setFavourite(false)
            }, failure: { (error) in
                print(error)
            })
        }
    }
}

