//
//  UIController+Helepr.swift
//  Course2FinalTask
//
//  Created by Aleksey Bardin on 01.03.2020.
//  Copyright © 2020 Bardincom. All rights reserved.
//

import UIKit


extension UIViewController {
  func displayDate(_ label: UILabel) {
    let displayDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    label.text = "\(dateFormatter.string(from: displayDate))"
  }
}
