//
//  SceneDelegate.swift
//  Block1
//
//  Created by Сергей Золотухин on 19.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  var coordinator: AppCoordinator?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    let diContainer = AppDIContainer()
    let coordinator = AppCoordinator(window: window,
                                     diContainder: diContainer
    )
    coordinator.start()
    self.coordinator = coordinator
  }
}
