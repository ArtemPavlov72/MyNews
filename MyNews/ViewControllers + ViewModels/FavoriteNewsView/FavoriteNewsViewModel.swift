//
//  FavoriteNewsViewModel.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import Foundation

protocol FavoriteNewsViewModelProtocol {
  func numberOfRows() -> Int
  func fetchNewsData(completion: @escaping() -> Void)
  func cellViewModel(at indexPath: IndexPath) -> NewsCellViewModelProtocol
}

class FavoriteNewsViewModel: FavoriteNewsViewModelProtocol {

  //MARK: - Private Properties

  private var newsData: News?
  private var listOfNews: [News.ResultOfNews] = []

  func cellViewModel(at indexPath: IndexPath) -> NewsCellViewModelProtocol {
    NewsCellViewModel(news: getNews(at: indexPath))
  }

  func numberOfRows() -> Int {
      10
  }

  func fetchNewsData(completion: @escaping () -> Void) {
    completion()
  }

  //MARK: - Private Methods

  private func getNews(at indexPath: IndexPath) -> News.ResultOfNews {
    listOfNews[indexPath.item]
  }
}
