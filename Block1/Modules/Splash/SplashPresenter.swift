//
//  SplashPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 26.05.2023.
//

import Foundation

protocol SplashPresenterProtocol {
  func present()
}

final class SplashPresenter {
  weak var viewController: SplashViewControllerProtocol?
  
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

extension SplashPresenter: SplashPresenterProtocol {
  func present() {
    routeAfterLoad()
  }
}

private extension SplashPresenter {
  func routeAfterLoad() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      guard let strongSelf = self else { return }
      let viewController = strongSelf.moduleBuilder.buildCategoriesViewController()
      strongSelf.router.push(viewController, animated: true)
    }
  }
}
