//
//  NewsCellViewModel.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import Foundation

protocol NewsCellViewModelProtocol {
    var newsCellName: String? { get }
//    init(
//        photo: Photo?
//    )
}

class NewsCellViewModel: NewsCellViewModelProtocol {


    //MARK: - Public Properties
  var newsCellName: String?

    //MARK: - Private Properties
//    private var news: News?


    //MARK: - Init
//    required init(
//        news: News?,
//    ) {
//        self.news = news
//    }
}
