//
//  NavigationRouter.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit

final class NavigationRouter {
  private let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
}

extension NavigationRouter: Router1 {
  //  func setRoot(_ viewController: UIViewController) {
  //    navigationController.viewControllers = [viewController]
  //  }
  
  func setRoot(_ viewController: UIViewController, embedNavBar: Bool, isNavigationBarHidden: Bool) {
    if embedNavBar {
      navigationController.isNavigationBarHidden = isNavigationBarHidden
      navigationController.viewControllers = [viewController]
    } else {
      navigationController.viewControllers = [viewController]
    }
  }
  
  func push(_ viewController: UIViewController, animated: Bool) {
    navigationController.pushViewController(viewController, animated: animated)
  }
  
  func popToRoot(animated: Bool) {
    navigationController.popToRootViewController(animated: animated)
  }
}
