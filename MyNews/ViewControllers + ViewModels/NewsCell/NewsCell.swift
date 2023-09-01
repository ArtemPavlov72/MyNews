//
//  NewsCell.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import UIKit

class NewsCell: UICollectionViewCell {

  //MARK: - Static Properties
  static let reuseId: String = "newsCell"

  //MARK: - Public Properties

  private lazy var backgroundColorView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 16
    view.backgroundColor = UIColor(red:0.14902,
                                   green:0.16471,
                                   blue:0.21961,
                                   alpha:1.00000)
    return view
  }()

  private lazy var imageBackgroundView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 10
    view.backgroundColor = UIColor(red:0.09804,
                                   green:0.10980,
                                   blue:0.16471,
                                   alpha:1.00000)
    return view
  }()

  private lazy var imageView: ImageView = {
    let image = ImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.layer.cornerRadius = 10
    image.tintColor = .gray
    return image
  }()

  private lazy var newsTitle: UILabel = {
    let label = UILabel()
    label.numberOfLines = 3
    label.textColor = .white
    label.font = UIFontMetrics.default.scaledFont(
      for: UIFont.systemFont(ofSize: 17, weight: .bold)
    )
    return label
  }()

  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = UIFontMetrics.default.scaledFont(
      for: UIFont.systemFont(ofSize: 15, weight: .light)
    )
    return label
  }()

  private lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = UIFontMetrics.default.scaledFont(
      for: UIFont.systemFont(ofSize: 16, weight: .medium)
    )
    return label
  }()

  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 5
    label.textColor = .white
    return label
  }()

  var viewModel: NewsCellViewModelProtocol? {
    didSet {
      newsTitle.text = viewModel?.newsName
      dateLabel.text = viewModel?.newsDate
      authorLabel.text = viewModel?.newsAuthor
      descriptionLabel.text = viewModel?.newsDescription
      imageView.fetchImage(from: viewModel?.newsImage ?? "")
    }
  }

  //MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupElements(backgroundColorView,
                  imageBackgroundView,
                  imageView,
                  newsTitle,
                  dateLabel,
                  authorLabel,
                  descriptionLabel)
    setupSubViews(backgroundColorView,
                  imageBackgroundView,
                  imageView,
                  newsTitle,
                  dateLabel,
                  authorLabel,
                  descriptionLabel)
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Setup Constraints

  private func setupConstraints() {
    let appearance = Appearance()

    NSLayoutConstraint.activate([
      backgroundColorView.topAnchor.constraint(equalTo: self.topAnchor),
      backgroundColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      backgroundColorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      backgroundColorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

      imageBackgroundView.topAnchor.constraint(equalTo: backgroundColorView.topAnchor,
                                               constant: appearance.topInsert),
      imageBackgroundView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor,
                                                   constant: appearance.minLeftInsert),
      imageBackgroundView.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor,
                                                  constant: appearance.bottomInsert),
      imageBackgroundView.widthAnchor.constraint(equalToConstant: appearance.imageLength),
      imageBackgroundView.heightAnchor.constraint(equalToConstant: appearance.imageLength),
      
      imageView.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
      imageView.topAnchor.constraint(equalTo: backgroundColorView.topAnchor,
                                     constant: appearance.topInsert),
      imageView.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor,
                                        constant: appearance.bottomInsert),
      imageView.widthAnchor.constraint(equalToConstant: appearance.imageLength),

      newsTitle.topAnchor.constraint(equalTo: backgroundColorView.topAnchor,
                                     constant: appearance.topInsert),
      newsTitle.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor,
                                         constant: appearance.maxLeftInsert),
      newsTitle.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor,
                                          constant: appearance.maxRightInsert),

      dateLabel.topAnchor.constraint(equalTo: newsTitle.bottomAnchor,
                                     constant: appearance.topInsert),
      dateLabel.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor,
                                         constant: appearance.maxLeftInsert),
      dateLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor,
                                          constant: appearance.maxRightInsert),

      authorLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,
                                       constant: appearance.topInsert),
      authorLabel.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor,
                                           constant: appearance.maxLeftInsert),
      authorLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor,
                                            constant: appearance.maxRightInsert),

      descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor,
                                            constant: appearance.topInsert),
      descriptionLabel.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor,
                                                constant: appearance.maxLeftInsert),
      descriptionLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor,
                                                 constant: appearance.maxRightInsert),
      descriptionLabel.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor,
                                               constant: appearance.bottomInsert)
    ])
  }
}

// MARK: - Private func

private extension NewsCell {
  func setupElements(_ subViews: UIView...) {
    subViews.forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }

  func setupSubViews(_ subViews: UIView...) {
    subViews.forEach {
      self.addSubview($0)
    }
  }
}

// MARK: - Appearance

private extension NewsCell {
  struct Appearance {
    let minLeftInsert: CGFloat = 8
    let maxLeftInsert: CGFloat = 16

    let minRightInsert: CGFloat = -8
    let maxRightInsert: CGFloat = -16

    let topInsert: CGFloat = 8
    let bottomInsert: CGFloat = -8
    let imageLength: CGFloat = 80
  }
}
