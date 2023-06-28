//
//  RegistrationPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

import Foundation

protocol RegistrationPresenterProtocol {
  func routeToAuthViewController()
}

final class RegistrationPresenter {
  weak var viewController: RegistrationViewControllerProtocol?
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

extension RegistrationPresenter: RegistrationPresenterProtocol {
  func routeToAuthViewController() {
    let vc = moduleBuilder.buildAuthViewController()
    viewController?.routeToAuthVC(to: vc)
  }
}

private extension RegistrationPresenter {}
