//
//  CircleView.swift
//  Social
//
//  Created by Shoenick on 7/24/17.
//  Copyright © 2017 Shoenick. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
    }

}
