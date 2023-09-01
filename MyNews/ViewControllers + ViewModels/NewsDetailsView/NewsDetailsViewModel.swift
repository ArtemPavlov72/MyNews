//
//  NewsDetailsViewModel.swift
//  MyNews
//
//  Created by Artem Pavlov on 24.08.2023.
//

import Foundation

protocol NewsDetailsViewModelProtocol {
  var newsNameLabel: String? { get }
  var autorLabel: String? { get }
  var descriptionLabel: String? { get }
  var imageURL: String? { get }
  var isFavorte: Box<Bool> { get }
  var newsLink: NSURL { get }
  init(news: News.ResultOfNews?, favoriteNews: FavoriteNews?)
  func favoriteButtonPressed()
  func checkFavoriteNewsForRemove()
}

class NewsDetailsViewModel: NewsDetailsViewModelProtocol {
  
  //MARK: - Public Properties
  
  var newsLink: NSURL {
    let link = news != nil
    ? NSURL(string: news?.link ?? "")
    : NSURL(string: favoriteNews?.link ?? "")
    return link ?? NSURL(fileURLWithPath: "")
  }
  
  var imageURL: String? {
    let url = news != nil
    ? news?.imageUrl
    : favoriteNews?.imageUrl
    return url
  }
  
  var newsNameLabel: String? {
    let newsNameLabel = news != nil
    ? news?.title
    : favoriteNews?.title
    return newsNameLabel
  }
  
  var autorLabel: String? {
    let autorLabel = news != nil
    ? news?.creator?.first
    : favoriteNews?.creator
    return autorLabel
  }
  
  var descriptionLabel: String? {
    let descriptionLabel = news != nil
    ? news?.description
    : favoriteNews?.descript
    return descriptionLabel
  }
  
  var isFavorte: Box<Bool> = Box(false)
  
  //MARK: - Private Properties
  
  private var news: News.ResultOfNews?
  private var favoriteNews: FavoriteNews?
  private var deleteFavoriteNews: Bool = false
  private var listOfFavoriteNews: [FavoriteNews] = []
  
  //MARK: - Init
  
  required init(news: News.ResultOfNews?, favoriteNews: FavoriteNews?) {
    self.news = news
    self.favoriteNews = favoriteNews
    self.isFavorte = Box(setStatus())
  }
  
  //MARK: - Public Methods
  
  func favoriteButtonPressed() {
    if isFavorte.value {
      if favoriteNews != nil {
        deleteFavoriteNews = true
        isFavorte.value = false
      } else {
        guard let news = news else { return }
        StorageManager.shared.delete(news: news)
        isFavorte.value = false
      }
    } else {
      if favoriteNews != nil {
        deleteFavoriteNews = false
        isFavorte.value = true
      } else {
        guard let news = news else { return }
        StorageManager.shared.save(news: news)
        isFavorte.value = true
      }
    }
  }
  
  func checkFavoriteNewsForRemove() {
    if deleteFavoriteNews {
      StorageManager.shared.delete(favoriteNews: favoriteNews)
    }
  }
  
  //MARK: - Private Methods
  
  private func setStatus() -> Bool {
    var liked = false
    
    if favoriteNews != nil {
      liked.toggle()
    } else {
      loadListOfFavoriteNews()
      guard let newsId = news?.articleId else { return liked }
      _ = listOfFavoriteNews.map { favoriteNews in
        if newsId == favoriteNews.articleId {
          liked.toggle()
        }
      }
    }
    return liked
  }
  
  private func loadListOfFavoriteNews() {
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
