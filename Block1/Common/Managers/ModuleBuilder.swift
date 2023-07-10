//
//  ModuleBuilder.swift
//  VKGallery
//
//  Created by Сергей Золотухин on 20.04.2023.
//

import Foundation

protocol ModuleBuilderProtocol {
  func buildWebViewViewController() -> WebViewViewController
//  func buildRegistrationViewController() -> RegistrationViewController
//  func buildAuthViewController() -> AuthViewController
  func buildSplashViewController() -> SplashViewController
//  func buildTabBarController() -> MainTabBarController
//  func buildNewsViewController() -> NewsViewController
//  func buildSearchViewController() -> SearchViewController
//  func buildCategoriesViewController() -> CategoriesViewController
//  func buildHistoryViewController() -> HistoryViewController
//  func buildProfileViewController() -> ProfileViewController
//  func buildHelpCategoryViewController(with model: HelpCategoryModel) -> HelpCategoryViewController
  func buildFullEventDescriptionViewController(with viewModel: FullEventDescriptionViewModel) -> FullEventDescriptionVC
  
  func buildRegistrationMVVMVC() -> RegistrationViewController
  func buildAuthMVVMVC() -> AuthViewController
}

final class ModuleBuilder {
  private var router: Router
  private let alertManager: AlertManagerProtocol

  init(router: Router,
       alertManager: AlertManagerProtocol
  ) {
    self.router = router
    self.alertManager = alertManager
  }
}

extension ModuleBuilder: ModuleBuilderProtocol {
  func buildWebViewViewController() -> WebViewViewController {
    let viewController = WebViewViewController()
    let loginVkManager = LoginVKManager()
    let presenter = WebViewPresenter(router: router,
                                     moduleBuilder: self,
                                     loginVKManager: loginVkManager,
                                     alertManager: alertManager
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    
    return viewController
  }
  
//  func buildRegistrationViewController() -> RegistrationViewController {
//    let viewController = RegistrationViewController()
//    let presenter = RegistrationPresenter(router: router,
//                                          moduleBuilder: self,
//                                          alertManager: alertManager
//    )
//    viewController.presenter = presenter
//    presenter.viewController = viewController
//    return viewController
//  }
  
//  func buildAuthViewController() -> AuthViewController {
//    let viewController = AuthViewController()
//    let presenter = AuthPresenter(router: router,
//                                  moduleBuilder: self,
//                                  alertManager: alertManager
//    )
//    viewController.presenter = presenter
//    presenter.viewController = viewController
//    return viewController
//  }
  
  func buildSplashViewController() -> SplashViewController {
    let viewController = SplashViewController()
    let presenter = SplashPresenter(router: router,
                                    moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
//  func buildTabBarController() -> MainTabBarController {
//    MainTabBarController(moduleBuilder: self)
//  }
  
//  func buildNewsViewController() -> NewsViewController {
//    let viewController = NewsViewController()
//    let presenter = NewsPresenter(router: router,
//                                  moduleBuilder: self
//    )
//    viewController.presenter = presenter
//    presenter.viewController = viewController
//    return viewController
//  }
//
//  func buildSearchViewController() -> SearchViewController {
//    let viewController = SearchViewController()
//    let presenter = SearchPresenter(router: router,
//                                    moduleBuilder: self
//    )
//    viewController.presenter = presenter
//    presenter.viewController = viewController
//    return viewController
//  }
  
//  func buildCategoriesViewController() -> CategoriesViewController {
//    let viewController = CategoriesViewController()
//    let presenter = CategoriesPresenter(router: router,
//                                        moduleBuilder: self
//    )
//    viewController.presenter = presenter
//    presenter.viewController = viewController
//    return viewController
//  }
  
//  func buildHistoryViewController() -> HistoryViewController {
//    let viewController = HistoryViewController()
//    let presenter = HistoryPresenter(router: router,
//                                     moduleBuilder: self
//    )
//    viewController.presenter = presenter
//    presenter.viewController = viewController
//    return viewController
//  }
//
//  func buildProfileViewController() -> ProfileViewController {
//    let viewController = ProfileViewController()
//    let presenter = ProfilePresenter(router: router,
//                                     moduleBuilder: self
//    )
//    viewController.presenter = presenter
//    presenter.viewController = viewController
//    return viewController
//  }
  
//  func buildHelpCategoryViewController(with model: HelpCategoryModel) -> HelpCategoryViewController {
//    let calendarManager = CalendarManager()
//    let viewController = HelpCategoryViewController()
//    let presenter = HelpCategoryPresenter(router: router,
//                                          moduleBuilder: self,
//                                          calendarManager: calendarManager,
//                                          helpCategoryModel: model
//    )
//    viewController.presenter = presenter
//    presenter.viewController = viewController
//    return viewController
//  }
  
  func buildFullEventDescriptionViewController(with viewModel: FullEventDescriptionViewModel) -> FullEventDescriptionVC {
    let viewController = FullEventDescriptionVC()
    let presenter = FullEventDescriptionPresenter(router: router,
                                                  moduleBuilder: self,
                                                  model: viewModel
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  
  
  
  
  func buildRegistrationMVVMVC() -> RegistrationViewController {
    let viewController = RegistrationViewController()
    let viewModel = RegistrationViewModel()
    viewController.viewModel = viewModel
    return viewController
  }
  
  func buildAuthMVVMVC() -> AuthViewController {
    let viewController = AuthViewController()
    let viewModel = AuthViewModel()
    viewController.viewModel = viewModel
    return viewController
  }
  
  func buildCategoriesMVVMVC() -> CategoriesViewController {
    let viewController = CategoriesViewController()
    let viewModel = CategoriesViewModel()
    viewController.viewModel = viewModel
    return viewController
  }
}
