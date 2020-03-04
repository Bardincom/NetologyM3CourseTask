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

/// Текущий пользователь
public let user = users.currentUser()

/// Массив постов. Массив пустой если нет постов или текущий пользователь ни на кого не подписан.
public let postsFeed = posts.feed()

/// Публикации по переданному ID полльзователя
func selectPosts() -> [Post] {
    guard let postsProfile = posts.findPosts(by: user.id) else {
        return [Post]()
    }
    return postsProfile
}

//MARK: Font Labels

/*
 Likes
 Font: Systems semibold 14, color: black
 Description
 Font: Systems 14, color: black
 AutorName
 Font: Systems semibold 14, color: black
 Date
 Font: Systems 14, color: black
 FullName
 Font: Systems 14, color: black
 Followers, Following
 Font: Systems semibold 14, color: black
 */

let systemsBoldFont: UIFont = .systemFont(ofSize: 14, weight: .semibold)
let systemsFont: UIFont = .systemFont(ofSize: 14)
