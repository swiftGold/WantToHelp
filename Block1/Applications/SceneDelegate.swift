//
//  SceneDelegate.swift
//  Block1
//
//  Created by Сергей Золотухин on 19.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    setupWindow(windowScene: windowScene)
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {}
  func sceneDidBecomeActive(_ scene: UIScene) {}
  func sceneWillResignActive(_ scene: UIScene) {}
  func sceneWillEnterForeground(_ scene: UIScene) {}
  func sceneDidEnterBackground(_ scene: UIScene) {}
}

// MARK: - Private methods
private extension SceneDelegate {
  func setupWindow(windowScene: UIWindowScene) {
    let window = UIWindow(windowScene: windowScene)
    self.window = window
    makeRootViewController(window: window)
    window.makeKeyAndVisible()
  }
  
  func makeRootViewController(window: UIWindow) {
    let router = AppRouter(window: window, navigationController: UINavigationController())
    let moduleBuilder: ModuleBuilderProtocol = ModuleBuilder(router: router)
    let viewController = moduleBuilder.buildSplashViewController()
    window.rootViewController = viewController
  }
}
