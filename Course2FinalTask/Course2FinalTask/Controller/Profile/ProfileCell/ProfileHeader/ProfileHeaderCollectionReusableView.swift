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
    
    @IBOutlet weak private var avatarImage: UIImageView!
    @IBOutlet weak private var fullNameLabel: UILabel!
    @IBOutlet weak private var followersLabel: UILabel!
    @IBOutlet weak private var followingLabel: UILabel!
    
    func setHeader(user: User) {
        avatarImage.image = user.avatar
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        fullNameLabel.font = systemsFont
        fullNameLabel.text = user.fullName
        followersLabel.font = systemsBoldFont
        followersLabel.text = "Followers: \(user.followsCount)"
        followingLabel.font = systemsBoldFont
        followingLabel.text = "Following: \(user.followedByCount)"
    }
}
