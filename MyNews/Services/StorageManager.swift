//
//  StorageManager.swift
//  MyNews
//
//  Created by Artem Pavlov on 24.08.2023.
//

import CoreData

class StorageManager {

  static let shared = StorageManager()

  // MARK: - Core Data stack
  
  private let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "FavoriteNews")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  private let viewContext: NSManagedObjectContext

  init() {
    viewContext = persistentContainer.viewContext
  }

  func fetchFavoriteNews(completion: (Result<[FavoriteNews], Error>) -> Void) {
    let fetchRequest = FavoriteNews.fetchRequest()
    do {
      let news = try viewContext.fetch(fetchRequest)
      completion(.success(news))
    } catch let error {
      completion(.failure(error))
    }
  }

  //MARK: - Private Methods

  func save(news: News.ResultOfNews) {
    let favoriteNews = FavoriteNews(context: viewContext)
    favoriteNews.articleId = news.articleId
    favoriteNews.content = news.content
    favoriteNews.creator = news.creator?.first
    favoriteNews.descript = news.description
    favoriteNews.imageUrl = news.imageUrl
    favoriteNews.link = news.link
    favoriteNews.pubDate = news.pubDate
    favoriteNews.title = news.title
    saveContext()
  }

  func delete(favoriteNews: FavoriteNews?) {
    guard let news = favoriteNews else { return }
    viewContext.delete(news)
    saveContext()
  }

  func delete(news: News.ResultOfNews) {
    var favoriteNews: [FavoriteNews] = []

    fetchFavoriteNews { result in
      switch result {
      case .success(let news):
        favoriteNews = news
      case .failure(let error):
        print(error.localizedDescription)
      }
    }

    guard let newsId = news.articleId else { return }
    _ = favoriteNews.map { favoriteNews in
      guard newsId == favoriteNews.articleId else { return }
      delete(favoriteNews: favoriteNews)
      return
    }
  }

  // MARK: - Core Data Saving support

  func saveContext() {
    if viewContext.hasChanges {
      do {
        try viewContext.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
