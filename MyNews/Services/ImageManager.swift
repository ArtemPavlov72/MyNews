//
//  ImageManager.swift
//  MyNews
//
//  Created by Artem Pavlov on 23.08.2023.
//

import Foundation

class ImageManager {

  static let shared = ImageManager()

  private init() {}

  func loadImageWithCache(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, let response = response else {
        return
      }
      guard url == response.url else {return}
      DispatchQueue.main.async {
        completion(data, response)
      }
    }.resume()
  }
}
