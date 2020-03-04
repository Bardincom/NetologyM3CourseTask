//
//  DetailCollectionViewCell.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 25.02.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import UIKit
import DataProvider

final class FeedCollectionViewCell: UICollectionViewCell, NibInit {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet private weak var cellConstraintsWidthConstraint: NSLayoutConstraint! {
        willSet {
            newValue.constant = UIScreen.main.bounds.width
        }
    }
    
    func setup(post: Post) {
        dateLabel.font = systemsFont
        dateLabel.text = post.createdTime.displayDate()
        avatarImageView.image = post.authorAvatar
        userNameLabel.font = systemsBoldFont
        userNameLabel.text = post.authorUsername
        imageView.image = post.image
        likesLabel.font = systemsBoldFont
        likesLabel.text = "Likes: " + "\(post.likedByCount)"
        descriptionLabel.font = systemsFont
        descriptionLabel.text = post.description
        likeButton.tintColor = .lightGray
    }
    

}



