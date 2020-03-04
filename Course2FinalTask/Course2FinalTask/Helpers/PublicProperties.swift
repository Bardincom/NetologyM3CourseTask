//
//  PublicProperties.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 04.03.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import UIKit
import DataProvider

//MARK: ViewController
let imageFeedViewController = UIImage(named: "feed")
let imageProfileViewController = UIImage(named: "profile")

enum ControllerSet {
    static let feedViewController = "Feed"
    static let profileViewController = "Profile"
}

//MARK: Provider
public let posts = DataProviders.shared.postsDataProvider
public let users = DataProviders.shared.usersDataProvider

/// текущий пользователь
public let user = users.currentUser()

/// посты по переданному ID
public let postsUser = posts.findPosts(by: user.id)

///Массив постов. Массив пустой если нет постов или текущий пользователь ни на кого не подписан.
public let postsFeed = posts.feed()


//func selectPosts(_ post: Post) -> [Post]? {
//    guard let postsProfile = posts.findPosts(by: user.id) else {
//    return nil
//    }
//    return postsProfile
//}

