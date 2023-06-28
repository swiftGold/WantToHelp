//
//  AuthPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

import Foundation

protocol AuthPresenterProtocol {
  func registrationButtonDidTap()
  func enterButtonDidTap()
  func vkButtonDidTap()
}

final class AuthPresenter {
  weak var viewController: AuthViewControllerProtocol?
  private let router: Router
  private let moduleBuilder: ModuleBuilderProtocol
  
  init(
    router: Router,
    moduleBuilder: ModuleBuilderProtocol
  ) {
    self.router = router
    self.moduleBuilder = moduleBuilder
  }
}

extension AuthPresenter: AuthPresenterProtocol {
  func vkButtonDidTap() {
    let vc = moduleBuilder.buildWebViewViewController()
    viewController?.routeToVkWebViewVC(to: vc)
  }
  
  func enterButtonDidTap() {
    let tabBar = moduleBuilder.buildTabBarController()
    router.setRoot(tabBar, embedNavBar: false, isNavigationBarHidden: true)
  }
  
  func registrationButtonDidTap() {
    let vc = moduleBuilder.buildRegistrationViewController()
    viewController?.routeToRegistrationVC(to: vc)
  }
}

private extension AuthPresenter {}
