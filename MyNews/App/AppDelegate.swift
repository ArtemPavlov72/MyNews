//
//  AppDelegate.swift
//  MyNews
//
//  Created by Artem Pavlov on 22.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.rootViewController = UINavigationController(rootViewController: TabBarViewController())
    return true
  }

  func applicationWillTerminate(_ application: UIApplication) {
      StorageManager.shared.saveContext()
  }
}
