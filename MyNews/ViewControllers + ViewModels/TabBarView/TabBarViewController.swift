//
//  TabBarViewController.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

  //MARK: - Public Properties

  var viewModel: TabBarViewModelProtocol? {
    didSet {
      newsVC.viewModel = viewModel?.newsListViewModel()
      favoriteNewsVC.viewModel = viewModel?.favoriteNewsViewModel()
    }
  }

  //MARK: - Private Properties

  private let newsVC = NewsListViewController(
    collectionViewLayout: UICollectionViewFlowLayout()
  )
  private let favoriteNewsVC = FavoriteNewsViewController(
    collectionViewLayout: UICollectionViewFlowLayout()
  )

  //MARK: - Life Cycles Methods

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = TabBarViewModel()
    setupTabBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationBar()
  }

  //MARK: - TabBar Setup

  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    navigationItem.title = item.title
  }

  //MARK: - Private Methods

  private func setupTabBar() {
    addTabBarItem(for: newsVC, title: "News", image: "newspaper", tag: 1)
    addTabBarItem(for: favoriteNewsVC, title: "Favorite News", image: "heart", tag: 2)
    viewControllers = [newsVC, favoriteNewsVC]
  }

  private func addTabBarItem(
    for viewController: UIViewController,
    title: String,
    image: String,
    tag: Int
  ) {
    viewController.tabBarItem = UITabBarItem(
      title: title,
      image: UIImage(systemName: image),
      tag: tag
    )
  }

  private func setupNavigationBar() {
    title = tabBar.selectedItem?.title
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}
