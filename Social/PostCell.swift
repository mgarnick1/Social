//
//  PostCell.swift
//  Social
//
//  Created by Shoenick on 7/26/17.
//  Copyright © 2017 Shoenick. All rights reserved.
//

import UIKit

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
    
    func configureCell(post: Post) {
        self.post = post
        self.caption.text = post.caption
        self.likeslvl.text = "\(post.likes)"
    }

}
