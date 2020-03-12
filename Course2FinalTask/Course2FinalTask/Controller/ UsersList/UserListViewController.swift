//
//  UserListViewController.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 07.03.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import UIKit
import DataProvider

class UserListViewController: UIViewController, NibInit {
    
    var usersList: [User]?
    var navigationItemTitle: String?
    
    @IBOutlet weak var userListTableView: UITableView! {
        willSet {
            newValue.register(nibCell: UserListTableViewCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let navigationItemTitle = navigationItemTitle {
            self.navigationItem.title = navigationItemTitle
        }
    }
}

//MARK: DataSource
extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectUsers(users: usersList).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return userListTableView.dequeue(reusable: UserListTableViewCell.self, for: indexPath)
    }
}

//MARK: Delegate
extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? UserListTableViewCell else {
            assertionFailure()
            return }
        
        let user = selectUsers(users: usersList)[indexPath.row]
        cell.avatarImage.image = user.avatar
        cell.userNameLabel.text = user.username

    }
}


