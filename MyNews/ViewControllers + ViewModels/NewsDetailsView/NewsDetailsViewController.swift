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
    label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 24, weight: .bold))
    label.numberOfLines = 0
    label.textColor = UIColor(named: "DetailDescriptionColor")
    return label
  }()

  private lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .medium))
    label.numberOfLines = 0
    label.backgroundColor = .systemYellow.withAlphaComponent(0.1)
    label.textColor = UIColor(named: "DetailDescriptionColor")?.withAlphaComponent(0.7)
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
    image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    return image
  }()

  private lazy var imageBackgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red:0.09804, green:0.10980, blue:0.16471, alpha:1.00000)
    view.layer.cornerRadius = 10
    view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
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
    button.backgroundColor = UIColor(red:0.14902, green:0.16471, blue:0.21961, alpha:1.00000)
    button.addTarget(self, action: #selector(shareData), for: .touchUpInside)
    return button
  }()

  private lazy var likeButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 15
    button.layer.maskedCorners = [.layerMaxXMaxYCorner]
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    button.tintColor = .white
    button.backgroundColor = UIColor(red:0.14902, green:0.16471, blue:0.21961, alpha:1.00000)
    button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
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
    setupElements(imageBackgroundView, newsImage, horizontalStackView, titleLabel, authorLabel, descriptionTextView)
    setupSubViews(imageBackgroundView, newsImage, horizontalStackView, titleLabel, authorLabel, descriptionTextView)
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

  //MARK: - Setup Constraints

  private func setupConstraints() {
    NSLayoutConstraint.activate([

      imageBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
      imageBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      imageBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      imageBackgroundView.heightAnchor.constraint(equalToConstant: view.layer.frame.height * 0.3),
      
      newsImage.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor),
      newsImage.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor),
      newsImage.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor),
      newsImage.heightAnchor.constraint(equalToConstant: view.layer.frame.height * 0.3),

      linkButton.heightAnchor.constraint(equalToConstant: 45),

      separatorView.widthAnchor.constraint(equalToConstant: 1),
      separatorView.heightAnchor.constraint(equalToConstant: 40),

      likeButton.heightAnchor.constraint(equalToConstant: 45),
      likeButton.widthAnchor.constraint(equalToConstant: 45),

      horizontalStackView.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 0),
      horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

      titleLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 16),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

      authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

      descriptionTextView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
      descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
    ])
  }
}
