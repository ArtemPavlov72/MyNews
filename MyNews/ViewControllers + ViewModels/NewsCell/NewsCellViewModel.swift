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
    news: News.ResultOfNews?
  )
}

class NewsCellViewModel: NewsCellViewModelProtocol {

  // MARK: - Public Properties

  var newsName: String? {
    news?.title
  }

  var newsDate: String? {
    news?.pubDate
  }

  var newsAuthor: String? {
    news?.creator?.first
  }

  var newsDescription: String? {
    news?.description
  }

  var newsImage: String? {
    news?.imageUrl
  }

  // MARK: - Private Properties

  private var news: News.ResultOfNews?

  // MARK: - Init

  required init(
    news: News.ResultOfNews?
  ) {
    self.news = news
  }
}
