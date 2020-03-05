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
    
    @IBOutlet weak var bigLike: UIImageView!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bigLike.alpha = 0
        imageView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(doudleTap))
        gesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(gesture)
    }
    
}

extension FeedCollectionViewCell {
    @objc private func doudleTap() {
        let animation = CATransition()
        animation.delegate = self
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        bigLike.alpha = 1
        bigLike.layer.add(animation, forKey: nil)
    }
}

extension FeedCollectionViewCell: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let animation = CATransition()
        animation.duration = 0.6
        animation.type = .moveIn
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        bigLike.alpha = 0
        bigLike.layer.add(animation, forKey: nil)
    }
}
