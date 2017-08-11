//
//  PostCell.swift
//  Social
//
//  Created by Shoenick on 7/26/17.
//  Copyright © 2017 Shoenick. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
   
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likeslvl: UILabel!
    
    var post: Post!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likeslvl.text = "\(post.likes)"
        
        if img != nil {
            self.postImg.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Jess: unable to download image from firebase storage")
                } else  {
                    print("Jess: image downloaded from firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgdata) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl)
                        }
                    }
                }
            })
        }
    }

}
