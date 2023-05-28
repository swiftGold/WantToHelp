//
//  AppDelegate.swift
//  Block1
//
//  Created by Сергей Золотухин on 19.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      let navigationBarAppearace = UINavigationBar.appearance()
      navigationBarAppearace.tintColor = .white
//      navigationBarAppearace.backgroundColor = .specialNavBarBGColor
      application.statusBarStyle = UIStatusBarStyle.lightContent
      return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}
