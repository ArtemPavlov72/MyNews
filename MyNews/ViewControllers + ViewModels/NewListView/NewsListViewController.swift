//
//  NewsListViewController.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import UIKit

class NewsListViewController: UICollectionViewController {

  //MARK: - Public Properties

  var viewModel: NewsListViewModelProtocol?

  //MARK: - Private Properties

  private let cellID = "cell"
  private var activityIndicator: UIActivityIndicatorView?

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(NewsCell.self, forCellWithReuseIdentifier: cellID)
    loadFirstData()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    collectionView.reloadData()
  }

  //MARK: - Private Methods

  private func loadFirstData() {
    activityIndicator = showSpinner(in: view)
    viewModel?.fetchNewsData() { [weak self] in
      self?.activityIndicator?.stopAnimating()
      self?.collectionView.reloadData()
    }
  }

  private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
    let activityIndicator = UIActivityIndicatorView(frame: view.bounds)
    activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    view.addSubview(activityIndicator)
    return activityIndicator
  }

  // MARK: - UICollectionViewDataSource

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    viewModel?.numberOfRows() ?? 0
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellID,
      for: indexPath
    ) as? NewsCell else {
      return NewsCell()
    }
    cell.viewModel = viewModel?.cellViewModel(at: indexPath)
    return cell
  }

  // MARK: - UICollectionViewDelegate

  override func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
    if indexPath.item == (viewModel?.numberOfRows() ?? 0) - 5 {
      viewModel?.fetchNewsData() { [weak self] in
        self?.collectionView.reloadData()
      }
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NewsListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let appearance = Appearance()
    let paddingWidth = 20 * (appearance.numberOfItemsPerRow + 1)
    let avaibleWidth = collectionView.frame.width - paddingWidth
    let widthPerItem = avaibleWidth / appearance.numberOfItemsPerRow
    let heightPerItem = widthPerItem * 0.7
    return CGSize(width: widthPerItem, height: heightPerItem)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    let appearance = Appearance()
    return UIEdgeInsets(top: appearance.topInsert,
                        left: appearance.leftInsert,
                        bottom: appearance.bottonInsert,
                        right: appearance.rightInsert)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    let appearance = Appearance()
    return appearance.minimumLineSpacing
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    let appearance = Appearance()
    return appearance.minimumInterItemSpacing
  }
}

// MARK: - Appearance

private extension NewsListViewController {
  struct Appearance {
//    let navigationBarTitle = "Characters"
    let backGroundColor: UIColor = .blue
    let leftInsert: CGFloat = 20
    let rightInsert: CGFloat = 20
    let topInsert: CGFloat = 20
    let bottonInsert: CGFloat = 20
    let numberOfItemsPerRow: CGFloat = 1
    let minimumLineSpacing: CGFloat = 20
    let minimumInterItemSpacing: CGFloat = 20
  }
}



