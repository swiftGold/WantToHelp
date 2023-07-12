//
//  AuthDIContainer.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit

struct AuthModuleDependencies {
  let authNetworkService: Networkable
}

final class AuthDIContainer {
  private let dependencies: AuthModuleDependencies
  
  init(dependencies: AuthModuleDependencies) {
    self.dependencies = dependencies
  }
}

extension AuthDIContainer {
  func makeAuthViewController(router: AuthRouterInput) -> UIViewController {
    let viewController = AuthViewController()
    let viewModel = AuthViewModel()
    viewController.viewModel = viewModel
    viewController.router = router
    return viewController
  }
  
  func makeRegViewController(router: RegistrationRouterInput) -> UIViewController {
    let viewController = RegistrationViewController()
    let viewModel = RegistrationViewModel()
    viewController.viewModel = viewModel
    viewController.router = router
    return viewController
  }
}
