//
//  AppCoordinator.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
  private let window: UIWindow
  private let diContainder: AppDIContainer
  private var router: Router?
  
  init(window: UIWindow,
       navigationController: UINavigationController = UINavigationController(),
       diContainder: AppDIContainer
  ) {
    self.window = window
    self.window.rootViewController = navigationController
    self.router = NavigationRouter(navigationController: navigationController)
    self.diContainder = diContainder
  }
  
  override func start() {
    window.makeKeyAndVisible()
    startAuthCoordinator()
  }
}

private extension AppCoordinator {
  func startAuthCoordinator() {
    guard let router else { return }
    let authCoordinator = diContainder.makeAuthCoordinator(router: router)
    addChild(authCoordinator)
    authCoordinator.start()
    authCoordinator.onFinish = { [weak self] in
      self?.removeChild(authCoordinator)
      self?.startTabBarCoordinator()
    }
  }
  
  func startTabBarCoordinator() {
    guard let router else { return }
    let tabBarCoordinator = diContainder.makeTabBarCoordinator(router: router)
    addChild(tabBarCoordinator)
    tabBarCoordinator.start()
    tabBarCoordinator.onFinish = { [weak self] in
      self?.removeChild(tabBarCoordinator)
      self?.startCategoryCoordinator()
    }
  }
  
  func startCategoryCoordinator() {
    guard let router else { return }
    let categoriesCoordinator = diContainder.makeCategoryCoordinator(router: router)
    addChild(categoriesCoordinator)
    categoriesCoordinator.start()
    categoriesCoordinator.onFinish = { [weak self] in
      self?.removeChild(categoriesCoordinator)
      print("DELETED categoriesCoordinator")
    }
  }
}
