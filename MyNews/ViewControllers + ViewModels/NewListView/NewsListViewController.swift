//
//  NewsListViewController.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import UIKit

class NewsListViewController: UICollectionViewController {
  
  //MARK: - Public Properties
  
  var viewModel: NewsListViewModelProtocol? {
    didSet {
      viewModel?.fetchNewsData() { [weak self] in
        self?.activityIndicator?.stopAnimating()
        self?.collectionView.reloadData()
      }
    }
  }
  
  //MARK: - Private Properties
  
  private var activityIndicator: UIActivityIndicatorView?
  
  //MARK: - Life Cycles Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseId)
    activityIndicator = showSpinner(in: view)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    collectionView.reloadData()
  }
    
  // MARK: - UICollectionViewDataSource
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    viewModel?.numberOfRows() ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: NewsCell.reuseId,
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
    if indexPath.item == (viewModel?.numberOfRows() ?? 0) - 2 {
      viewModel?.fetchNewsData() { [weak self] in
        self?.collectionView.reloadData()
      }
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    let detailVC = NewsDetailsViewController()
    detailVC.viewModel = viewModel?.detailsViewModel(at: indexPath) as? NewsDetailsViewModel
    show(detailVC, sender: nil)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NewsListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let appearance = Appearance()
    let paddingWidth = appearance.minimumLineSpacing * (appearance.numberOfItemsPerRow + 1)
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
    let leftInsert: CGFloat = 20
    let rightInsert: CGFloat = 20
    let topInsert: CGFloat = 20
    let bottonInsert: CGFloat = 20
    let numberOfItemsPerRow: CGFloat = 1
    let minimumLineSpacing: CGFloat = 20
    let minimumInterItemSpacing: CGFloat = 20
  }
}
