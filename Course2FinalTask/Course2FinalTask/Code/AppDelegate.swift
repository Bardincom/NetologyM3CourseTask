//
//  AppDelegate.swift
//  Course2FinalTask
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      window = UIWindow(frame: UIScreen.main.bounds)
      
      let feedViewController = FeedViewController(nibName: nil, bundle: nil)
      feedViewController.title = "Feed"
      feedViewController.tabBarItem.image = UIImage(named: "feed")
      let profileViewController = ProfileViewController(nibName: nil, bundle: nil)
      profileViewController.title = "Profile"
      profileViewController.tabBarItem.image = UIImage(named: "profile")
      let tabBarController = UITabBarController()
      tabBarController.tabBar.backgroundColor = .white
      tabBarController.setViewControllers([feedViewController, profileViewController], animated: true)
      
      window?.rootViewController = tabBarController
      
      window?.makeKeyAndVisible()
        return true
    }
}
