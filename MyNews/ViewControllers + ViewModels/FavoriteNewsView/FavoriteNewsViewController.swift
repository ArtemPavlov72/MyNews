//
//  FavoriteNewsViewController.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import UIKit

class FavoriteNewsViewController: UICollectionViewController {
  
  //MARK: - Public Properties
  
  var viewModel: FavoriteNewsViewModelProtocol?
  
  //MARK: - Private Properties
  
  private var activityIndicator: UIActivityIndicatorView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseId)
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
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailVC = NewsDetailsViewController()
    detailVC.viewModel = viewModel?.detailsViewModel(at: indexPath) as? NewsDetailsViewModel
    show(detailVC, sender: nil)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteNewsViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let appearance = Appearance()
    let paddingWidth = appearance.leftInsert * (appearance.numberOfItemsPerRow + 1)
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

private extension FavoriteNewsViewController {
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
