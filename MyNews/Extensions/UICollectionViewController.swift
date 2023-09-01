//
//  UICollectionViewCell.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import UIKit

extension UICollectionViewController {
  func showSpinner(in view: UIView) -> UIActivityIndicatorView {
    let activityIndicator = UIActivityIndicatorView(frame: view.bounds)
    activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    view.addSubview(activityIndicator)
    return activityIndicator
  }
}
