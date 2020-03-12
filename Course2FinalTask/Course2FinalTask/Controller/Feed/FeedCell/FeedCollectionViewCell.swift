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
    func likePost(cell: FeedCollectionViewCell)
    func userList(cell: FeedCollectionViewCell)
}

final class FeedCollectionViewCell: UICollectionViewCell, NibInit {
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var containerStackView: UIStackView!
    
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
        
        /// отображение лайка на публикации текущего пользователя
        guard post.currentUserLikesThisPost else {
            likeButton.tintColor = lightGrayColor
            return
        }
        likeButton.tintColor = defaultTintColor
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupFonts()
        setupUserInteraction()
        
        /// жест по картинке для лайка
        let gestureImageTap = UITapGestureRecognizer(target: self, action: #selector(doudleLikeTap))
        gestureImageTap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(gestureImageTap)
        
        /// жест кнопке лайк
        let gestureLikeButtonTap = UITapGestureRecognizer(target: self, action: #selector(likeTap))
        likeButton.addGestureRecognizer(gestureLikeButtonTap)
        
        /// жест для перехода по аватару
        let gestureAvatarTap = UITapGestureRecognizer(target: self, action: #selector(goToProfile))
        avatarImageView.addGestureRecognizer(gestureAvatarTap)
        
        /// жест для перехода по имени и дате(использовал SteakView)
        let gestureNameTap = UITapGestureRecognizer(target: self, action: #selector(goToProfile))
        containerStackView.addGestureRecognizer(gestureNameTap)

        /// жест по надписи количество лайков
        let gestureLikeLabelTap = UITapGestureRecognizer(target: self, action: #selector(openLikeList))
        likesLabel.addGestureRecognizer(gestureLikeLabelTap)
    }
}

//MARK: Selector
extension FeedCollectionViewCell {
    
    @objc private func goToProfile() {
        delegate?.openUserProfile(cell: self)
    }
    
    @objc private func likeTap() {
        delegate?.likePost(cell: self)
    }
    
    @objc private func openLikeList() {
        delegate?.userList(cell: self)
    }
    
    @objc private func doudleLikeTap() {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveLinear], animations: {
            self.bigLike.alpha = 1.0
        }, completion: {_ in
            UIView.animate(withDuration: 0.3, delay: 0.2, options: [.curveEaseOut], animations: {
                self.bigLike.alpha = 0
            }, completion: nil)
        })
        
        if likeButton.tintColor == lightGrayColor {
            delegate?.likePost(cell: self)
        }
    }
}

//MARK: FeedCollectionViewCell Helper
private extension FeedCollectionViewCell {
    
    func setupFonts() {
        dateLabel.font = systemsFont
        userNameLabel.font = systemsBoldFont
        likesLabel.font = systemsBoldFont
        descriptionLabel.font = systemsFont
        likeButton.tintColor = defaultTintColor
    }
    
    func setupUserInteraction() {
        avatarImageView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        likesLabel.isUserInteractionEnabled = true
    }
}
