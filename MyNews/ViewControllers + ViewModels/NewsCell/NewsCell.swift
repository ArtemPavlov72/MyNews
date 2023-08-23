//
//  NewsCell.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import UIKit

class NewsCell: UICollectionViewCell {

  //MARK: - Public Properties

  private lazy var backgroundColorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red:0.14902, green:0.16471, blue:0.21961, alpha:1.00000)
    view.layer.cornerRadius = 16
    return view
  }()

  private lazy var imageBackgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red:0.09804, green:0.10980, blue:0.16471, alpha:1.00000)
    view.layer.cornerRadius = 10
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
    label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 17, weight: .bold))
    label.textColor = .white
    return label
  }()

  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 15, weight: .light))
    label.textColor = .systemGray4
    return label
  }()

  private lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .medium))
    label.textColor = .gray
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

  //MARK: - Cell Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupItem()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Private Methods
  
  private func setupItem() {
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
  }

  //MARK: - Setup Constraints

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      backgroundColorView.topAnchor.constraint(equalTo: self.topAnchor),
      backgroundColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      backgroundColorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      backgroundColorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

      imageBackgroundView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 8),
      imageBackgroundView.topAnchor.constraint(equalTo: backgroundColorView.topAnchor, constant: 8),
      imageBackgroundView.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -8),
      imageBackgroundView.widthAnchor.constraint(equalToConstant: 80),
      imageBackgroundView.heightAnchor.constraint(equalToConstant: 80),

      imageView.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
      imageView.topAnchor.constraint(equalTo: backgroundColorView.topAnchor, constant: 8),
      imageView.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -8),
      imageView.widthAnchor.constraint(equalToConstant: 80),


      newsTitle.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: 16),
      newsTitle.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -16),
      newsTitle.topAnchor.constraint(equalTo: backgroundColorView.topAnchor, constant: 8),

      dateLabel.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: 16),
      authorLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -16),
      dateLabel.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 8),

      authorLabel.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: 16),
      authorLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -16),
      authorLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),

      descriptionLabel.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: 16),
      descriptionLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -16),
      descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
      descriptionLabel.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -8)
    ])
  }
}
