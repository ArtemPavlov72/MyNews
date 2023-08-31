//
//  FavoriteNewsViewModel.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import Foundation

protocol FavoriteNewsViewModelProtocol {
  func numberOfRows() -> Int
  func cellViewModel(at indexPath: IndexPath) -> NewsCellViewModelProtocol
  func detailsViewModel(at indexPath: IndexPath) -> NewsDetailsViewModelProtocol
}

class FavoriteNewsViewModel: FavoriteNewsViewModelProtocol {

  //MARK: - Private Properties

  private var favoriteNews: FavoriteNews?
  private var listOfFavoriteNews: [FavoriteNews] = []

  //MARK: - Public Methods
  
  func cellViewModel(at indexPath: IndexPath) -> NewsCellViewModelProtocol {
    NewsCellViewModel(news: nil, favoriteNews: getFavoriteNews(at: indexPath))
  }

  func detailsViewModel(at indexPath: IndexPath) -> NewsDetailsViewModelProtocol {
    NewsDetailsViewModel(news: nil, favoriteNews: getFavoriteNews(at: indexPath))
  }

  func numberOfRows() -> Int {
    fetchFavoriteNewsData()
    return listOfFavoriteNews.count
  }

  //MARK: - Private Methods

  private func getFavoriteNews(at indexPath: IndexPath) -> FavoriteNews {
    listOfFavoriteNews[indexPath.item]
  }

  private func fetchFavoriteNewsData() {
    StorageManager.shared.fetchFavoriteNews { [weak self] result in
      switch result {
      case .success(let favoriteNews):
        self?.listOfFavoriteNews = favoriteNews

      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
