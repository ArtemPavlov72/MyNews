//
//  UIViewController.swift
//  MyNews
//
//  Created by Artem Pavlov on 30.08.2023.
//

import UIKit

extension UIViewController {
  func setupElements(_ subViews: UIView...) {
    subViews.forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
}
