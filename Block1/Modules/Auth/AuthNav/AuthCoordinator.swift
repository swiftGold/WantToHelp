//
//  AuthCoordinator.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit
import RxSwift

final class AuthCoordinator: BaseCoordinator & CoordinatorOutput {
  var onFinish: (() -> Void)?
  
  private let router: Router1
  private let diContainer: AuthDIContainer
  
  init(router: Router1,
       diContainer: AuthDIContainer
  ) {
    self.router = router
    self.diContainer = diContainer
  }
  
  override func start() {
    let authViewController = diContainer.makeAuthViewController(router: self)
    router.setRoot(authViewController, embedNavBar: false, isNavigationBarHidden: false)
  }
}

extension AuthCoordinator: AuthRouterInput {
  func routeToRegistrationVC() {
    let regViewController = diContainer.makeRegViewController(router: self)
    router.push(regViewController, animated: false)
  }
  
  func routeToMainTabBarVC() {
    onFinish?()
  }
}

extension AuthCoordinator: RegistrationRouterInput {
  func routeToAuthVC() {
    let authViewController = diContainer.makeAuthViewController(router: self)
    router.push(authViewController, animated: false)
  }
}
