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

    feedCollectionView.register(UINib(nibName: String(describing: DetailCollectionViewCell.self), bundle: nil),forCellWithReuseIdentifier: "Cell")

    feedCollectionView.dataSource = self
    feedCollectionView.delegate = self
  }
  
}

extension FeedViewController: UICollectionViewDataSource {
//  func numberOfSections(in collectionView: UICollectionView) -> Int {
//    1
//  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    posts.feed().count
  }
  
  
  
 
  
  

  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DetailCollectionViewCell
    let post = posts.feed()[indexPath.row]
    cell.avatarImageView.image = post.authorAvatar
    cell.userNameLable.text = post.authorUsername
//    cell.dataLable.text = post.authorUsername
    cell.imageView.image = post.image
    cell.likesLable.text = "Likes:" //+ "\(post.likedByCount)"
    cell.descriptionLable.text = post.description

    
    return cell
  }
  
  
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSize = feedCollectionView.bounds.width
    return CGSize(width: itemSize, height: itemSize)
  }
}



//extension CollectionViewController: UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    let itemSize = (collectionView.bounds.width - 3 * cellIdent) / 2
//
//    return CGSize(width: itemSize, height: itemSize)
//  }
