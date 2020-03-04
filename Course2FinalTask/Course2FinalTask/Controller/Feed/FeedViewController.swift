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
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
            {
            willSet {
                newValue.register(nibCell: FeedCollectionViewCell.self)
            }
        }
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width
            let post = posts.feed()[indexPath.row]
            let estimatedFrame = NSString(string: post.description).boundingRect(with: CGSize(width: width - 8, height: width - 8), options: .usesLineFragmentOrigin, attributes: nil, context: nil)
            return CGSize(width: width, height: estimatedFrame.height + UIScreen.main.bounds.width + 50 + 80)
        }
}

