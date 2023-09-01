//
//  NewsDetailsViewController.swift
//  MyNews
//
//  Created by Artem Pavlov on 24.08.2023.
//

import UIKit

class NewsDetailsViewController: UIViewController {

  //MARK: - Public Properties

  var viewModel: NewsDetailsViewModel?

  //MARK: - Private Properties

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 5
    label.textColor = UIColor(named: "DetailDescriptionColor")
    label.font = UIFontMetrics.default.scaledFont(
      for: UIFont.systemFont(ofSize: 24, weight: .bold)
    )
    return label
  }()

  private lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.backgroundColor = .systemYellow.withAlphaComponent(0.1)
    label.textColor = UIColor(named: "DetailDescriptionColor")?.withAlphaComponent(0.7)
    label.font = UIFontMetrics.default.scaledFont(
      for: UIFont.systemFont(ofSize: 18, weight: .medium)
    )
    return label
  }()

  private lazy var descriptionTextView: UITextView = {
    let textView = UITextView()
    textView.textColor = UIColor(named: "DetailDescriptionColor")
    textView.font = .systemFont(ofSize: 20)
    return textView
  }()

  private lazy var newsImage: ImageView = {
    let image = ImageView()
    image.layer.cornerRadius = 10
    image.contentMode = .scaleAspectFill
    image.tintColor = .gray
    image.layer.masksToBounds = true
    image.layer.maskedCorners = [.layerMaxXMinYCorner,
                                 .layerMinXMinYCorner]
    return image
  }()

  private lazy var imageBackgroundView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 10
    view.layer.maskedCorners = [.layerMaxXMinYCorner,
                                .layerMinXMinYCorner]
    view.backgroundColor = UIColor(red:0.09804,
                                   green:0.10980,
                                   blue:0.16471,
                                   alpha:1.00000)
    return view
  }()

  private lazy var separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGray
    return view
  }()

  private lazy var linkButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 15
    button.layer.maskedCorners = [.layerMinXMaxYCorner]
    button.setTitle("Share link", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitleColor(.gray, for: .highlighted)
    button.backgroundColor = UIColor(red:0.14902,
                                     green:0.16471,
                                     blue:0.21961,
                                     alpha:1.00000)
    button.addTarget(self,
                     action: #selector(shareData),
                     for: .touchUpInside)
    return button
  }()

  private lazy var likeButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 15
    button.layer.maskedCorners = [.layerMaxXMaxYCorner]
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    button.tintColor = .white
    button.backgroundColor = UIColor(red:0.14902,
                                     green:0.16471,
                                     blue:0.21961,
                                     alpha:1.00000)
    button.addTarget(self,
                     action: #selector(addToFavorite),
                     for: .touchUpInside)
    return button
  }()

  private lazy var horizontalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = NSLayoutConstraint.Axis.horizontal
    stackView.addArrangedSubview(linkButton)
    stackView.addArrangedSubview(separatorView)
    stackView.addArrangedSubview(likeButton)
    return stackView
  }()


  //MARK: - Life Cycles Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    setupNavigationBar()
    installLike(viewModel?.isFavorte.value ?? false)
    setupUI()
    setupElements(imageBackgroundView,
                  newsImage,
                  horizontalStackView,
                  titleLabel,
                  authorLabel,
                  descriptionTextView)
    setupSubViews(imageBackgroundView,
                  newsImage,
                  horizontalStackView,
                  titleLabel, authorLabel,
                  descriptionTextView)
    setupConstraints()
  }


  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    viewModel?.checkFavoriteNewsForRemove()
  }
  //MARK: - Private Methods

  private func setupUI() {
    viewModel?.isFavorte.bind(
      listener: { [weak self] value in
        self?.installLike(value)
      }
    )
    titleLabel.text = viewModel?.newsNameLabel
    authorLabel.text = "Autor: \(viewModel?.autorLabel ?? "- Unknow -")"
    descriptionTextView.text = viewModel?.descriptionLabel
    newsImage.fetchImage(from: viewModel?.imageURL ?? "")
  }

  private func installLike(_ status: Bool) {
    status ? addLike() : removeLike()
  }

  private func addLike() {
    likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    likeButton.tintColor = .systemYellow
  }

  private func removeLike() {
    likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    likeButton.tintColor = .white
  }

  @objc private func addToFavorite() {
    viewModel?.favoriteButtonPressed()
  }

  @objc private func shareData() {
    let activityViewController = UIActivityViewController(
      activityItems: [viewModel?.newsLink ?? ""],
      applicationActivities: nil
    )
    self.present(activityViewController, animated: true, completion: nil)
  }

  private func setupNavigationBar() {
    navigationItem.largeTitleDisplayMode = .never
  }

  private func setupSubViews(_ subViews: UIView...) {
    subViews.forEach { view.addSubview($0) }
  }

  private func setupElements(_ subViews: UIView...) {
    subViews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
  }

  //MARK: - Setup Constraints

  private func setupConstraints() {
    let appearance = Appearance()

    NSLayoutConstraint.activate([
      imageBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: appearance.topInsert),
      imageBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: appearance.minLeftInsert),
      imageBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: appearance.minRightInsert),
      imageBackgroundView.heightAnchor.constraint(equalToConstant: view.layer.frame.height * 0.3),
      
      newsImage.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor),
      newsImage.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor),
      newsImage.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor),
      newsImage.heightAnchor.constraint(equalToConstant: view.layer.frame.height * 0.3),

      linkButton.heightAnchor.constraint(equalToConstant: appearance.buttonLength),

      separatorView.widthAnchor.constraint(equalToConstant: appearance.separatorWidth),
      separatorView.heightAnchor.constraint(equalToConstant: appearance.separatorHeight),

      likeButton.heightAnchor.constraint(equalToConstant: appearance.buttonLength),
      likeButton.widthAnchor.constraint(equalToConstant: appearance.buttonLength),

      horizontalStackView.topAnchor.constraint(equalTo: newsImage.bottomAnchor),
      horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: appearance.minLeftInsert),
      horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: appearance.minRightInsert),

      titleLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor,
                                      constant: appearance.maxTopInsert),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                          constant: appearance.maxLeftInsert),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                           constant: appearance.maxRightInsert),

      authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                       constant: appearance.topInsert),
      authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: appearance.maxLeftInsert),
      authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: appearance.maxRightInsert),

      descriptionTextView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor,
                                               constant: appearance.maxTopInsert),
      descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: appearance.midlLeftInsert),
      descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: appearance.midlRightInsert),
      descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: appearance.bottomInsert)
    ])
  }
}

// MARK: - Appearance

private extension NewsDetailsViewController {
  struct Appearance {
    let minLeftInsert: CGFloat = 8
    let midlLeftInsert: CGFloat = 10
    let maxLeftInsert: CGFloat = 16

    let minRightInsert: CGFloat = -8
    let midlRightInsert: CGFloat = -10
    let maxRightInsert: CGFloat = -16

    let topInsert: CGFloat = 8
    let maxTopInsert: CGFloat = 16

    let bottomInsert: CGFloat = -8

    let buttonLength: CGFloat = 45

    let separatorWidth: CGFloat = 1
    let separatorHeight: CGFloat = 45
  }
}
