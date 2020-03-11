//
//  DataProvider Properties.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 11.03.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import DataProvider


public let posts = DataProviders.shared.postsDataProvider
public let users = DataProviders.shared.usersDataProvider


/// Текущий пользователь
public let currentUser = users.currentUser()
public let currentUserID = users.user(with: currentUser.id)

/// Массив постов. Массив пустой если нет постов или текущий пользователь ни на кого не подписан.
public var postsFeed = posts.feed()



/// Развертывание опционала для публикаций
func selectPosts(posts: [Post]?) -> [Post] {
    guard let posts = posts else { return [Post]() }
    return posts
}

/// Развертывание опционала для пользователя
func selectUser(user: User?) -> User {
    guard let user = user else { return currentUser }
    return user
}
