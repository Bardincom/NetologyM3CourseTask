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
let imageFeedViewController = #imageLiteral(resourceName: "feed")
let imageProfileViewController = #imageLiteral(resourceName: "profile")

enum ControllerSet {
    static let feedViewController = "Feed"
    static let profileViewController = "Profile"
}

//MARK: Provider
public let posts = DataProviders.shared.postsDataProvider
public let users = DataProviders.shared.usersDataProvider

public var user: User?
public var post: Post?

/// ID автора поста
func postAuthor() -> User.Identifier? {
    guard let userID: User.Identifier = post?.author else { return nil }
    return userID
}



/// Текущий пользователь
public let currentUser = users.currentUser()
public let currentUserID = users.user(with: currentUser.id)

/// Массив постов. Массив пустой если нет постов или текущий пользователь ни на кого не подписан.
public let postsFeed = posts.feed()

//func selectUsersFollowing() -> [User] {
//
//    guard let usersFollowing = users.usersFollowingUser(with: user?.id) else { return <#return value#> }
//}
public let usersList = users.usersFollowingUser(with: currentUserID!.id)

/// Публикации по переданному ID полльзователя
func selectPosts() -> [Post] {
    guard let postsProfile = posts.findPosts(by: currentUser.id) else {
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



/*
 /// Модель публикации
 public struct Post {

     public typealias Identifier = DataProvider.GenericIdentifier<DataProvider.Post>

     /// Идентификатор публикации
     public var id: DataProvider.Post.Identifier

     /// Идентификатор автора публикации
     public var author: DataProvider.User.Identifier

     /// Описание публикации
     public var description: String

     /// Изображение
     public var image: UIImage

     /// Дата создания публикации
     public var createdTime: Date

     /// Свойство, отображающее ставил ли текущий пользователь лайк на эту публикацию
     public var currentUserLikesThisPost: Bool

     /// Количество лайков на этой публикации
     public var likedByCount: Int

     /// Имя аккаунта автора публикации
     public var authorUsername: String

     /// Аватар автора публикации
     public var authorAvatar: UIImage?
 }

 /// Протокол, описывающий поставщика публикаций
 public protocol PostsDataProviderProtocol : AnyObject {

     /// Возвращает публикации пользователей на которых подписан текущий пользователь
     ///
     /// - Returns: Массив постов. Массив пустой если нет постов или текущий пользователь
     /// ни на кого не подписан.
     func feed() -> [DataProvider.Post]

     /// Возвращает публикацию с переданным ID.
     ///
     /// - Parameter postID: ID публикации которую нужно вернуть.
     /// - Returns: Публикация если она была найдена.
     /// nil если такой публикации нет.
     func post(with postID: DataProvider.Post.Identifier) -> DataProvider.Post?

     /// Возвращает все публикации пользователя с переданным ID.
     ///
     /// - Parameter authorID: ID пользователя публикации которого нужно вернуть.
     /// - Returns: Массив публикаций.
     /// Пустой массив если пользователь еще ничего не опубликовал.
     /// nil если такого пользователя нет.
     func findPosts(by authorID: DataProvider.User.Identifier) -> [DataProvider.Post]?

     /// Ставит лайк от текущего пользователя на публикацию с переданным ID.
     ///
     /// - Parameter postID: ID публикации на которую нужно поставить лайк.
     /// - Returns: true если операция выполнена упешно или пользователь уже поставил лайк
     /// на эту публикацию.
     /// false в случае если такой публикации нет.
     func likePost(with postID: DataProvider.Post.Identifier) -> Bool

     /// Удаляет лайк текущего пользователя у публикации с переданным ID.
     ///
     /// - Parameter postID: ID публикации у которой нужно удалить лайк.
     /// - Returns: true если операция выполнена успешно или пользователь и так не ставил лайк
     /// на эту публикацию.
     /// false в случае если такой публикации нет.
     func unlikePost(with postID: DataProvider.Post.Identifier) -> Bool

     /// Возвращает ID пользователей поставивших лайк на публикацию.
     ///
     /// - Parameter postID: ID публикации лайки на которой нужно искать.
     /// - Returns: Массив ID пользователей.
     /// Пустой массив если никто еще не поставил лайк на эту публикацию.
     /// nil если такой публикации нет в хранилище.
     func usersLikedPost(with postID: DataProvider.Post.Identifier) -> [DataProvider.User.Identifier]?
 }

 /// Модель пользователя
 public struct User {

     public typealias Identifier = DataProvider.GenericIdentifier<DataProvider.User>

     /// Идентификатор пользователя
     public var id: DataProvider.User.Identifier

     /// Имя аккаунта пользователя
     public var username: String

     /// Полное имя пользователя пользователя
     public var fullName: String

     /// Аватар пользователя
     public var avatar: UIImage?

     /// Свойство, отображающее подписан ли текущий пользователь на этого пользователя
     public var currentUserFollowsThisUser: Bool

     /// Свойство, отображающее подписан ли этот пользователь на текущего пользователя
     public var currentUserIsFollowedByThisUser: Bool

     /// Количество подписок этого пользователя
     public var followsCount: Int

     /// Количество подписчиков этого пользователя
     public var followedByCount: Int
 }

 /// Протокол, описывающий поставщика пользователей
 public protocol UsersDataProviderProtocol : AnyObject {

     /// Возвращает текущего пользователя.
     ///
     /// - Returns: Текущий пользователь.
     func currentUser() -> DataProvider.User

     /// Возвращает пользователя с переданным ID.
     ///
     /// - Parameter userID: ID пользователя которого нужно вернуть.
     /// - Returns: Пользователь если он был найден.
     /// nil если такого пользователя нет.
     func user(with userID: DataProvider.User.Identifier) -> DataProvider.User?

     /// Добавляет текущего пользователя в подписчики.
     ///
     /// - Parameter userIDToFollow: ID пользователя на которого должен подписаться текущий пользователь.
     /// - Returns: true если текущий пользователь стал подписчиком пользователя с переданным ID
     /// или уже являлся им.
     /// false в случае если нет пользователя с переданным ID.
     /// false если userIDToFollow равен идентификатору текущего пользователя
     func follow(_ userIDToFollow: DataProvider.User.Identifier) -> Bool

     /// Удаляет текущего пользователя из подписчиков.
     ///
     /// - Parameter userIDToUnfollow: ID пользователя от которого должен отписаться текущий пользователь.
     /// - Returns: true если текущий пользователь перестал быть подписчиком пользователя с
     /// переданным ID или и так не являлся им.
     /// false в случае если нет пользователя с переданным ID.
     /// false если userIDToUnfollow равен идентификатору текущего пользователя
     func unfollow(_ userIDToUnfollow: DataProvider.User.Identifier) -> Bool

     /// Возвращает всех подписчиков пользователя.
     ///
     /// - Parameter userID: ID пользователя подписчиков которого нужно вернуть.
     /// - Returns: Массив пользователей.
     /// Пустой массив если на пользователя никто не подписан.
     /// nil если такого пользователя нет.
     func usersFollowingUser(with userID: DataProvider.User.Identifier) -> [DataProvider.User]?

     /// Возвращает все подписки пользователя.
     ///
     /// - Parameter userID: ID пользователя подписки которого нужно вернуть.
     /// - Returns: Массив пользователей.
     /// Пустой массив если он ни на кого не подписан.
     /// nil если такого пользователя нет.
     func usersFollowedByUser(with userID: DataProvider.User.Identifier) -> [DataProvider.User]?
 }


 */
