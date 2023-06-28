//
//  ModuleBuilder.swift
//  VKGallery
//
//  Created by Сергей Золотухин on 20.04.2023.
//

import Foundation

protocol ModuleBuilderProtocol {
  func buildWebViewViewController() -> WebViewViewController
  func buildRegistrationViewController() -> RegistrationViewController
  func buildAuthViewController() -> AuthViewController
  func buildSplashViewController() -> SplashViewController
  func buildTabBarController() -> MainTabBarController
  func buildNewsViewController() -> NewsViewController
  func buildSearchViewController() -> SearchViewController
  func buildCategoriesViewController() -> CategoriesViewController
  func buildHistoryViewController() -> HistoryViewController
  func buildProfileViewController() -> ProfileViewController
  func buildChildViewController() -> ChildsViewController
  func buildFullEventDescriptionViewController(with viewModel: FullEventDescriptionViewModel) -> FullEventDescriptionVC
  func buildAdultViewController() -> AdultViewController
  func buildElderlyViewController() -> ElderlyViewController
  func buildAnimalsViewController() -> AnimalsViewController
  func buildEventsViewController() -> EventsViewController
}

final class ModuleBuilder {
  private var router: Router
  
  init(router: Router) {
    self.router = router
  }
}

extension ModuleBuilder: ModuleBuilderProtocol {
  func buildWebViewViewController() -> WebViewViewController {
    let viewController = WebViewViewController()
    let alertManager = AlertManager()
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
  
  func buildRegistrationViewController() -> RegistrationViewController {
    let viewController = RegistrationViewController()
    let presenter = RegistrationPresenter(router: router,
                                        moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildAuthViewController() -> AuthViewController {
    let viewController = AuthViewController()
    let presenter = AuthPresenter(router: router,
                                        moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildSplashViewController() -> SplashViewController {
    let viewController = SplashViewController()
    let presenter = SplashPresenter(router: router,
                                    moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildTabBarController() -> MainTabBarController {
    MainTabBarController(moduleBuilder: self)
  }
  
  func buildNewsViewController() -> NewsViewController {
    let viewController = NewsViewController()
    let presenter = NewsPresenter(router: router,
                                  moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildSearchViewController() -> SearchViewController {
    let viewController = SearchViewController()
    let presenter = SearchPresenter(router: router,
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
  
  func buildHistoryViewController() -> HistoryViewController {
    let viewController = HistoryViewController()
    let presenter = HistoryPresenter(router: router,
                                     moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildProfileViewController() -> ProfileViewController {
    let viewController = ProfileViewController()
    let presenter = ProfilePresenter(router: router,
                                     moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildChildViewController() -> ChildsViewController {
    let calendarManager = CalendarManager()
    let viewController = ChildsViewController()
    let presenter = ChildsPresenter(router: router,
                                    moduleBuilder: self,
                                    calendarManager: calendarManager
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildFullEventDescriptionViewController(with viewModel: FullEventDescriptionViewModel) -> FullEventDescriptionVC {
    let viewController = FullEventDescriptionVC()
    let presenter = FullEventDescriptionPresenter(router: router,
                                                  moduleBuilder: self, model: viewModel
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildAdultViewController() -> AdultViewController {
    let viewController = AdultViewController()
    let presenter = AdultPresenter(router: router,
                                     moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildElderlyViewController() -> ElderlyViewController {
    let viewController = ElderlyViewController()
    let presenter = ElderlyPresenter(router: router,
                                     moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildAnimalsViewController() -> AnimalsViewController {
    let viewController = AnimalsViewController()
    let presenter = AnimalsPresenter(router: router,
                                     moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
  
  func buildEventsViewController() -> EventsViewController {
    let viewController = EventsViewController()
    let presenter = EventsPresenter(router: router,
                                     moduleBuilder: self
    )
    viewController.presenter = presenter
    presenter.viewController = viewController
    return viewController
  }
}
