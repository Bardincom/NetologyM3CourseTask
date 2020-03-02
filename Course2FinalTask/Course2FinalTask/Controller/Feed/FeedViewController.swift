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

class FeedViewController: UIViewController, NibInit {
  private let reuseIdentifier = "FeedCell"
  
  @IBOutlet weak var feedCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    feedCollectionView.register(UINib(nibName: String(describing: FeedCollectionViewCell.self), bundle: nil),forCellWithReuseIdentifier: reuseIdentifier)

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
    let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCollectionViewCell
    let post = posts.feed()[indexPath.row]
    cell.avatarImageView.image = post.authorAvatar
    cell.userNameLabel.text = post.authorUsername
    cell.dataLabel.text = "\(post.createdTime)"
    displayDate(cell.dataLabel)
    cell.imageView.image = post.image
    cell.likesLabel.text = "Likes: " + "\(post.likedByCount)"
    cell.descriptionLabel.text = post.description
    
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

