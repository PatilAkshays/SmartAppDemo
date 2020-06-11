//
//  NowPlayingCell.swift
//  SmartApp
//
//  Created by Akshay Patil on 11/06/20.
//  Copyright © 2020 Treel. All rights reserved.
//

import UIKit
import SDWebImage

class NowPlayingCell: UICollectionViewCell {
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var movieDescLabel: UILabel!
    @IBOutlet weak var imageView: SDAnimatedImageView!
}
