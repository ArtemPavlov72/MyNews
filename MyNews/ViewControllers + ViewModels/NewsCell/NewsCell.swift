//
//  NewsCell.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import UIKit

class NewsCell: UICollectionViewCell {

  //MARK: - Public Properties
  let label = UILabel()
  
  var viewModel: NewsCellViewModelProtocol? {
    didSet {

    }
  }

  //MARK: - Cell Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .brown
    setupItem()

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Private Methods
  private func setupItem() {
    setupElements(label)
    setupSubViews(label)
  }

  //MARK: - Setup Constraints

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: self.topAnchor),
      label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
  }
}
