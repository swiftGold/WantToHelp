//
//  MainTabBarDIContainer.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit

struct MainTabBarModuleDependencies {
  let mainTabBarNetworkService: Networkable
}

final class MainTabBarDIContainer {
  private let dependencies: MainTabBarModuleDependencies
  
  init(dependencies: MainTabBarModuleDependencies) {
    self.dependencies = dependencies
  }
}

extension MainTabBarDIContainer {
  func makeMainTabBarController(router: MainTabBarInputRouter) -> UIViewController {
    let viewController = MainTabBarController()
    viewController.router = router
    return viewController
  }
}
