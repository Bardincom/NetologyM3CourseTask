//
//  ProfileHeaderCollectionReusableView.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 01.03.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import UIKit
import DataProvider

final class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    func setHeader(user: User) {
           avatarImage.image = user.avatar
           avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
           fullNameLabel.text = user.fullName
           followersLabel.text = "Followers: \(user.followsCount)"
           followingLabel.text = "Following: \(user.followedByCount)"
       }
}
