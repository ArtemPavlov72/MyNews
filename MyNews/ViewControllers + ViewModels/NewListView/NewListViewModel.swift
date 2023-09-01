//
//  NewListViewModel.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import Foundation

protocol NewsListViewModelProtocol {
  func numberOfRows() -> Int
  func cellViewModel(at indexPath: IndexPath) -> NewsCellViewModelProtocol
  func detailsViewModel(at indexPath: IndexPath) -> NewsDetailsViewModelProtocol
  func fetchNewsData(_ completion: @escaping() -> Void)
}

class NewsListViewModel: NewsListViewModelProtocol {

  //MARK: - Private Properties

  private var newsData: News?
  private var listOfNews: [News.ResultOfNews] = []

  //MARK: - Public Methods

  func numberOfRows() -> Int {
    listOfNews.count
  }

  func cellViewModel(at indexPath: IndexPath) -> NewsCellViewModelProtocol {
    NewsCellViewModel(news: getNews(at: indexPath), favoriteNews: nil)
  }

  func detailsViewModel(at indexPath: IndexPath) -> NewsDetailsViewModelProtocol {
    NewsDetailsViewModel(news: getNews(at: indexPath), favoriteNews: nil)
  }

  func fetchNewsData(_ completion: @escaping () -> Void) {
    let link = newsData == nil
    ? "\(Link.baseURL.rawValue)\(ApiKey.pexelsKey.rawValue)\(Link.languageEn.rawValue)"
    : "\(Link.baseURL.rawValue)\(ApiKey.pexelsKey.rawValue)\(Link.languageEn.rawValue)\(Link.page.rawValue)\(newsData?.nextPage ?? 0)"

    NetworkManager.shared.fetchData(dataType: News.self, from: link) { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let news):
        self.newsData = news
        if self.listOfNews.isEmpty {
          self.listOfNews = news.results ?? []
        } else {
          self.listOfNews += news.results ?? []
        }
        completion()
      case .failure(let error):
        print(error)
      }
    }
  }

  //MARK: - Private Methods

  private func getNews(at indexPath: IndexPath) -> News.ResultOfNews {
    listOfNews[indexPath.item]
  }
}
