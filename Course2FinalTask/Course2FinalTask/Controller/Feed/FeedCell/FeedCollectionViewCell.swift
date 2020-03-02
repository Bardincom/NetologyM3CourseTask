//
//  DetailCollectionViewCell.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 25.02.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import UIKit
import DataProvider

class FeedCollectionViewCell: UICollectionViewCell, NibInit {
  
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var dataLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var likesLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    //    imageView.contentMode = .scaleAspectFit
  }
}



