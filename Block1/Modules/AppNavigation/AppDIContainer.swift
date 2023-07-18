//
//  AppDIContainer.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

final class AppDIContainer {
  // TODO: - vozmojno ubrat' networkable pozje
  private let networkService: Networkable
  private let calendarManager: CalendarManagerProtocol
  
  init(networkService: Networkable,
       calendarManager: CalendarManagerProtocol
  ) {
    self.networkService = networkService
    self.calendarManager = calendarManager
  }
  
  convenience init() {
    let jsonService = JSONDecoderManager()
    let calendarManager = CalendarManager()
    let networkService = NetworkManager(jsonService: jsonService)
    
    self.init(networkService: networkService,
              calendarManager: calendarManager)
  }
}

extension AppDIContainer {
  func makeAuthCoordinator(router: Router) -> CoordinatorOutput {
    let dependencies = AuthModuleDependencies(authNetworkService: networkService)
    let diContainer = AuthDIContainer(dependencies: dependencies)
    let authCoordinator = AuthCoordinator(router: router,
                                        diContainer: diContainer
    )
    return authCoordinator
  }
  
  func makeTabBarCoordinator(router: Router) -> CoordinatorOutput {
    let dependencies = MainTabBarModuleDependencies(mainTabBarNetworkService: networkService)
    let diContrainer = MainTabBarDIContainer(dependencies: dependencies)
    let mainTabBarCoordinator = MainTabBarCoordinator(router: router,
                                                diContainer: diContrainer
    )
    return mainTabBarCoordinator
  }
  
  func makeCategoryCoordinator(router: Router) -> CoordinatorOutput {
    let dependencies = CategoriesModuleDependencies(categoriesNetworkService: networkService,
                                                    calendarManager: calendarManager
    )
    let diContrainer = CategoriesDIContainer(dependencies: dependencies)
    let CategoriesCoordinator = CategoriesCoordinator(router: router,
                                                diContainer: diContrainer
    )
    return CategoriesCoordinator
  }
}
