//
//  NewsCellViewModel.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import Foundation

protocol NewsCellViewModelProtocol {
  var newsName: String? { get }
  var newsDate: String? { get }
  var newsAuthor: String? { get }
  var newsDescription: String? { get }
  var newsImage: String? { get }
  init(
    news: News.ResultOfNews?,
    favoriteNews: FavoriteNews?
  )
}

class NewsCellViewModel: NewsCellViewModelProtocol {

  // MARK: - Public Properties

  var newsName: String? {
    let name = news != nil
    ? news?.title
    : favoriteNews?.title
    return name
  }

  var newsDate: String? {
    let date = news != nil
    ? news?.pubDate
    : favoriteNews?.pubDate
    return date
  }

  var newsAuthor: String? {
    let creator = news != nil
    ? news?.creator?.first
    : favoriteNews?.creator
    return creator
  }

  var newsDescription: String? {
    let description = news != nil
    ? news?.description
    : favoriteNews?.descript
    return description
  }

  var newsImage: String? {
    let image = news != nil
    ? news?.imageUrl
    : favoriteNews?.imageUrl
    return image
  }

  // MARK: - Private Properties

  private var news: News.ResultOfNews?
  private var favoriteNews: FavoriteNews?

  // MARK: - Init

  required init(
    news: News.ResultOfNews?,
    favoriteNews: FavoriteNews?
  ) {
    self.news = news
    self.favoriteNews = favoriteNews
  }
}
