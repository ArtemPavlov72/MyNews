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
  init(news: News.ResultOfNews, favoriteNews: FavoriteNews?)
  func favoriteButtonPressed()
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
  private var favoriteListOfNews: [FavoriteNews] = []


  //MARK: - Init

  required init(news: News.ResultOfNews, favoriteNews: FavoriteNews?) {
    self.news = news
    self.favoriteNews = favoriteNews
    self.isFavorte = Box(setStatus())
  }

  //MARK: - Public Methods
  func favoriteButtonPressed() {
    guard let news = news else { return }
    if !isFavorte.value {
      _ = favoriteListOfNews.map { favoriteNews in
        guard news.articleId != favoriteNews.articleId else {return}
      }
      StorageManager.shared.save(news: news)
      isFavorte.value = true
    } else {
      StorageManager.shared.delete(news: news)
      isFavorte.value = false
    }
  }

  //MARK: - Private Methods
  private func loadFavoriteNews() {
    StorageManager.shared.fetchFavoriteNews { [weak self] result in
      switch result {
      case .success(let favoriteNews):
        self?.favoriteListOfNews = favoriteNews
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }

//  private func loadNews() {
//        NetworkManager.shared.fetchData(
//            from: Link.pexelsPhotoById.rawValue,
//            usingId: Int(favoritePhoto?.id ?? 0),
//            completion: { [weak self] result in
//                switch result {
//                case .success(let photo):
//                    self?.photo = photo
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        )
//    }

    private func setStatus() -> Bool {
        var liked = false
      loadFavoriteNews()

        if favoriteNews != nil {
//            loadPhoto()
            liked.toggle()
        } else {
          guard let newsId = news?.articleId else { return liked }
            _ = favoriteListOfNews.map { favoriteNews in
              if newsId == news?.articleId {
                    liked.toggle()
                }
            }
        }
        return liked
    }
}
