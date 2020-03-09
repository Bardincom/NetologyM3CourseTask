//
//  DetailCollectionViewCell.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 25.02.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import UIKit
import DataProvider

protocol FeedCollectionViewProtocol {
    func openUserProfile(cell: FeedCollectionViewCell)
}

final class FeedCollectionViewCell: UICollectionViewCell, NibInit {
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var bigLike: UIImageView! {
        willSet {
            newValue.alpha = 0
        }
    }
    
    @IBOutlet private weak var cellConstraintsWidthConstraint: NSLayoutConstraint! {
        willSet {
            newValue.constant = UIScreen.main.bounds.width
        }
    }
    
    var delegate: FeedCollectionViewProtocol?
    
    /// настройка ленты
    func setup(post: Post) {
        dateLabel.text = post.createdTime.displayDate()
        avatarImageView.image = post.authorAvatar
        userNameLabel.text = post.authorUsername
        imageView.image = post.image
        likesLabel.text = "Likes: " + "\(post.likedByCount)"
        descriptionLabel.text = post.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupFonts()
        setupUserInteraction()
        
        /// жест для лайка по картинке
        let gestureImageTap = UITapGestureRecognizer(target: self, action: #selector(doudleTap))
        gestureImageTap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(gestureImageTap)
        
        /// жест для перехода по аватару
        let gestureAvatarTap = UITapGestureRecognizer(target: self, action: #selector(goToProfile))
        avatarImageView.addGestureRecognizer(gestureAvatarTap)
    }
}

//MARK: Selector
extension FeedCollectionViewCell {
    
    @objc func goToProfile() {
        print("avatarImageView")
        delegate?.openUserProfile(cell: self)
    }
}

//MARK: Animation
extension FeedCollectionViewCell {
    @objc private func doudleTap() {
        let animation = CATransition()
        animation.delegate = self
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        likeButton.tintColor = nil
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

//MARK: FeedCollectionViewCell Helper
private extension FeedCollectionViewCell {
    
    func setupFonts() {
        dateLabel.font = systemsFont
        userNameLabel.font = systemsBoldFont
        likesLabel.font = systemsBoldFont
        descriptionLabel.font = systemsFont
        likeButton.tintColor = .lightGray
    }
    
    func setupUserInteraction() {
        avatarImageView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
    }
}
