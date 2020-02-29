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
  
  @IBOutlet weak var userNameLable: UILabel!
  
  @IBOutlet weak var dataLable: UILabel!
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var likesLable: UILabel!
  
  
  @IBOutlet weak var descriptionLable: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.contentMode = .scaleAspectFill
  }
}



