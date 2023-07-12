//
//  MainTabBarCoordinator.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit

final class MainTabBarCoordinator: BaseCoordinator & CoordinatorOutput {
  var onFinish: (() -> Void)?
  
  private let router: Router1
  private let diContainer: MainTabBarDIContainer
  
  init(router: Router1,
       diContainer: MainTabBarDIContainer
  ) {
    self.router = router
    self.diContainer = diContainer
  }
  
  override func start() {
    let mainTabBarViewController = diContainer.makeMainTabBarController(router: self)
    router.setRoot(mainTabBarViewController, embedNavBar: true, isNavigationBarHidden: true)
  }
}

extension MainTabBarCoordinator: MainTabBarInputRouter {
  func routeCategoriesVC() {
    onFinish?()
  }
}
