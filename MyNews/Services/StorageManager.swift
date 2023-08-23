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

  func fetchFavoritePhotos(completion: (Result<[FavoriteNews], Error>) -> Void) {
    let fetchRequest = FavoriteNews.fetchRequest()
    do {
      let news = try viewContext.fetch(fetchRequest)
      completion(.success(news))
    } catch let error {
      completion(.failure(error))
    }
  }

  func deleteFavoritePhotos() {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FavoriteNews.fetchRequest()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
      try viewContext.execute(deleteRequest)
    } catch let error {
      print(error)
    }
  }

  //MARK: - Private Methods

  func save(news: News.ResultOfNews) {
    let favoriteNews = FavoriteNews(context: viewContext)
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
