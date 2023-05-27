//
//  ModuleBuilder.swift
//  VKGallery
//
//  Created by Сергей Золотухин on 20.04.2023.
//

protocol ModuleBuilderProtocol {
  func buildSplashViewController() -> SplashViewController
  func buildCategoriesViewController() -> CategoriesViewController
}

final class ModuleBuilder {
  private var router: Router
  
  init(router: Router) {
    self.router = router
  }
}

extension ModuleBuilder: ModuleBuilderProtocol {
  func buildSplashViewController() -> SplashViewController {
    let viewController = SplashViewController()
    let presenter = SplashPresenter(router: router,
                                    moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildCategoriesViewController() -> CategoriesViewController {
    let viewController = CategoriesViewController()
    let presenter = CategoriesPresenter(router: router,
                                        moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
}
