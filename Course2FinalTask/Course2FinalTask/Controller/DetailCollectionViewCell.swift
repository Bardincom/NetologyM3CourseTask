//
//  DetailCollectionViewCell.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 25.02.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import UIKit
import DataProvider

class DetailCollectionViewCell: UICollectionViewCell, NibInit {
  
  @IBOutlet weak var avatarImageView: UIImageView!
  
  @IBOutlet weak var userNameButton: UIButton!
  
  @IBOutlet weak var dataLable: UILabel!
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var likesButton: UIButton!
  
  @IBOutlet weak var descriptionLable: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
//    avatarImageView.contentMode = .scaleAspectFit
//    userNameButton.titleLabel?.text = "Antonio"
//    imageView.contentMode = .scaleAspectFit
//    descriptionLable.text = "Какой то пост"
  }
  
}
