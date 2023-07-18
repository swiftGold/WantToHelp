//
//  MainTabBarCoordinator.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit

final class MainTabBarCoordinator: BaseCoordinator & CoordinatorOutput {
  var onFinish: (() -> Void)?
  
  private let router: Router
  private let diContainer: MainTabBarDIContainer
  private var vc: UIViewController?
  
  func initScene() -> UIViewController? {
    return vc
  }
  
  init(router: Router,
       diContainer: MainTabBarDIContainer
  ) {
    self.router = router
    self.diContainer = diContainer
  }
  
  override func start() {
    guard let mainTabBarViewController = diContainer.makeMainTabBarController(router: self) else { return }
    // TODO: - razobrat'
//    vc = mainTabBarViewController
    router.setRoot(mainTabBarViewController, embedNavBar: true, isNavigationBarHidden: true)
  }
}

extension MainTabBarCoordinator: MainTabBarInputRouter {
  func routeCategoriesVC() {
    onFinish?()
  }
}
