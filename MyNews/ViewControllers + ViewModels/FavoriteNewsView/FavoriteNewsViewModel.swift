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

  func cellViewModel(at indexPath: IndexPath) -> NewsCellViewModelProtocol {
    return NewsCellViewModel()
  }

  func numberOfRows() -> Int {
      10
  }

  func fetchNewsData(completion: @escaping () -> Void) {
    completion()
  }
}
