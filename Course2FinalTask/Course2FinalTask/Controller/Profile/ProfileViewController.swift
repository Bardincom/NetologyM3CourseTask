//
//  ProfileViewController.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 24.02.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import UIKit
import DataProvider

var users = DataProviders.shared.usersDataProvider

class ProfileViewController: UIViewController, NibInit {
  private let user = users.currentUser()
  private let reuseIdentifier = "ProfileCell"
  private let headerIdentifire = "HeaderProfile"
  
  @IBOutlet weak var profileCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    profileCollectionView.register(UINib(nibName: String(describing: ProfileCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

    /// регистрирую Header
    profileCollectionView.register(UINib(nibName: String(describing: ProfileHeaderCollectionReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifire)

    profileCollectionView.delegate = self
    profileCollectionView.dataSource = self
  }
}

//MARK: DataSourse
extension ProfileViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.findPosts(by: user.id)!.count

  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = profileCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCollectionViewCell
    let post = posts.findPosts(by: user.id)![indexPath.row].image
    cell.image.image = post
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {

    let view = profileCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifire, for: indexPath) as! ProfileHeaderCollectionReusableView

    view.avatarImage.image = user.avatar
    view.fullNameLabel.text = user.fullName
    view.followersLabel.text = "Followers: \(user.followsCount)"
    view.followingLabel.text = "Following: \(user.followedByCount)"

    return view
  }
  
  /// задаю размеры Header
/// TO DO:  разобрать как задать высоту
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 84)
  }
}
  
//MARK: Delegate
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = profileCollectionView.bounds.width / 3
    return CGSize(width: size, height: size)
  }
}
