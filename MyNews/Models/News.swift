//
//  News.swift
//  MyNews
//
//  Created by Artem Pavlov on 23.08.2023.
//

import Foundation

struct News: Decodable {
  let results: [ResultOfNews]?
  let nextPage: Int?

  struct ResultOfNews: Decodable {
    let title: String?
    let link: String?
    let creator: [String]?
    let description: String?
    let content: String?
    let pubDate: String?
    let imageUrl: String?
  }
}

enum ApiKey: String {
  case pexelsKey = "pub_280461e1beaf7370bee9fc09733925d85d44b"
}

enum Link: String {
  case baseURL = "https://newsdata.io/api/1/news?apikey="
  case page = "&page="
  case languageEn = "&language=en"
}
