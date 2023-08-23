//
//  TabBarViewModel.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import Foundation

protocol TabBarViewModelProtocol {
    func newsListViewModel() -> NewsListViewModelProtocol
    func favoriteNewsViewModel() -> FavoriteNewsViewModelProtocol
}

class TabBarViewModel: TabBarViewModelProtocol {

  //MARK: - Public Methods

  func newsListViewModel() -> NewsListViewModelProtocol {
    NewsListViewModel()
  }

  func favoriteNewsViewModel() -> FavoriteNewsViewModelProtocol {
    FavoriteNewsViewModel()
  }
}
