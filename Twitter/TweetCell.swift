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

}
