//
//  FeedViewController.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 24.02.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import UIKit
import DataProvider

final class FeedViewController: UIViewController, NibInit {
    
    @IBOutlet weak private var feedCollectionView: UICollectionView!
        {
        willSet {
            newValue.register(nibCell: FeedCollectionViewCell.self)
        }
    }
    
    @IBOutlet weak private var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFeedViewController()
    }
}

extension FeedViewController {
    private func setFeedViewController() {
        title = ControllerSet.feedViewController
    }
}

//MARK: DataSource
extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        postsFeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return feedCollectionView.dequeue(cell: FeedCollectionViewCell.self, for: indexPath)
    }
}

//MARK: DelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FeedCollectionViewCell else {
            assertionFailure()
            return
        }
        let post = postsFeed[indexPath.row]
        cell.setup(post: post)
        cell.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let post = posts.feed()[indexPath.row]
        let estimatedFrame = NSString(string: post.description).boundingRect(with: CGSize(width: width - 8, height: width - 8), options: .usesLineFragmentOrigin, attributes: nil, context: nil)
        return CGSize(width: width, height: estimatedFrame.height + UIScreen.main.bounds.width + 130)
    }
}



// MARK: FeedCollectionViewProtocol
extension FeedViewController: FeedCollectionViewProtocol {
    
    /// открывает профиль пользователя
    func openUserProfile(cell: FeedCollectionViewCell) {
        guard let indexPath = feedCollectionView.indexPath(for: cell) else { return }
        
        let currentPost = postsFeed[indexPath.row]
        
        guard let author = users.user(with: currentPost.author) else { return }
        
        let authorPosts = posts.findPosts(by: author.id)
        
        let profileViewController = ProfileViewController.initFromNib()
        profileViewController.userProfile = author
        profileViewController.postsProfile = authorPosts
        
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    /// ставит лайк на публикацию
    func likePost(cell: FeedCollectionViewCell) {
        guard let indexPath = feedCollectionView.indexPath(for: cell) else { return }
        
        let postID = postsFeed[indexPath.row].id
        
        guard cell.likeButton.tintColor == lightGrayColor else {
            if posts.unlikePost(with: postID) {
                postsFeed[indexPath.row].currentUserLikesThisPost = false
                postsFeed[indexPath.row].likedByCount -= 1
                cell.tintColor = lightGrayColor
                feedCollectionView.reloadData()
            }
            return
        }
        if posts.likePost(with: postID) {
            postsFeed[indexPath.row].currentUserLikesThisPost = true
            postsFeed[indexPath.row].likedByCount += 1
            cell.tintColor = defaultTintColor
            feedCollectionView.reloadData()
        }
    }
    
    /// открывает список пользователей поставивших лайк
    func userList(cell: FeedCollectionViewCell) {
        
        
        
        
        var userMarkerPost = [User]()
        
        guard let indexPath = feedCollectionView.indexPath(for: cell) else { return }
        
        let currentPost = postsFeed[indexPath.row].id
        
        guard let usersID = posts.usersLikedPost(with: currentPost) else { return }
        
        userMarkerPost = usersID.compactMap{ currentUserID in
            users.user(with: currentUserID) }
        
        guard !userMarkerPost.isEmpty else { return }
        
        let userListViewController = UserListViewController.initFromNib()
        userListViewController.usersList = userMarkerPost
        userListViewController.navigationItemTitle = "Likes"
        self.navigationController?.pushViewController(userListViewController, animated: true)
        
        
    }
}


//extension FeedViewController: CustomFlowLayoutDelegate {
//    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
////        let itemSize = postsFeed[indexPath.item].description.heightWithConstrainedWidth(width: 290, font: systemsFont)
//         let width = collectionView.frame.width
//                let post = posts.feed()[indexPath.row]
//                let estimatedFrame = NSString(string: post.description).boundingRect(with: CGSize(width: width - 8, height: width - 8), options: .usesLineFragmentOrigin, attributes: nil, context: nil)
////                CGSize(width: width, height: estimatedFrame.height + UIScreen.main.bounds.width + 130)
//
//        return 415//+ itemSize + 15
////      return  collectionView.bounds.width
//    }
//}


//        let width = collectionView.frame.width
//        let post = posts.feed()[indexPath.row]
//        let estimatedFrame = NSString(string: post.description).boundingRect(with: CGSize(width: width - 8, height: width - 8), options: .usesLineFragmentOrigin, attributes: nil, context: nil)
//        return CGSize(width: width, height: estimatedFrame.height + UIScreen.main.bounds.width + 130)

//extension String {
//    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
//        return boundingBox.height
//    }
//}
//func collectionView(
//    _ collectionView: UICollectionView,
//    heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
//    let r = feed[indexPath.item].description.heightWithConstrainedWidth(width: 290, font: UIFont.systemFont(ofSize: 14))
//
//    return 415 + r
//}
