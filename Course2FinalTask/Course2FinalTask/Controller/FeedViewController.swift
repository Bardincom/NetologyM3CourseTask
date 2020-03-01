//
//  FeedViewController.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 24.02.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import UIKit
import DataProvider

var posts = DataProviders.shared.postsDataProvider
var users = DataProviders.shared.usersDataProvider

class FeedViewController: UIViewController, NibInit {
  
  @IBOutlet weak var feedCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    feedCollectionView.register(UINib(nibName: String(describing: FeedCollectionViewCell.self), bundle: nil),forCellWithReuseIdentifier: "Cell")

    feedCollectionView.dataSource = self
    feedCollectionView.delegate = self
  }
}

//MARK: DataSource
extension FeedViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    posts.feed().count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FeedCollectionViewCell
    let post = posts.feed()[indexPath.row]
    cell.avatarImageView.image = post.authorAvatar
    cell.userNameLable.text = post.authorUsername
    cell.dataLable.text = "\(post.createdTime)"
    displayDate(cell.dataLable)
    cell.imageView.image = post.image
    cell.likesLable.text = "Likes: " + "\(post.likedByCount)"
    cell.descriptionLable.text = post.description
    
    return cell
  }
}

//MARK: DelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let widthSize = feedCollectionView.bounds.width
    let heightSize = feedCollectionView.bounds.height
    return CGSize(width: widthSize, height: heightSize)
  }
}

