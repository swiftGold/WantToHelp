//
//  CategoriesDIContainer.swift
//  Block1
//
//  Created by Сергей Золотухин on 12.07.2023.
//

import UIKit

struct CategoriesModuleDependencies {
  let categoriesNetworkService: Networkable
  let calendarManager: CalendarManagerProtocol
}

final class CategoriesDIContainer {
  private let dependencies: CategoriesModuleDependencies
  
  init(dependencies: CategoriesModuleDependencies) {
    self.dependencies = dependencies
  }
}

extension CategoriesDIContainer {
  func makeCategoriesViewController(router: CategoriesRouterInput) -> UIViewController {
    let viewController = CategoriesViewController()
    let viewModel = CategoriesViewModel()
    viewController.viewModel = viewModel
    viewController.router = router
    return viewController
  }
  
  func makeHelpCategoryViewController(router: HelpCategoryRouterInput, model: HelpCategoryModel) -> UIViewController {
    let viewController = HelpCategoryViewController()
    let viewModel = HelpCategoryViewModel(categoryModel: model,
                                          calendarManager: dependencies.calendarManager
    )
    viewController.viewModel = viewModel
    viewController.router = router
    return viewController
  }
  
  func makeEventDescriptionViewController(router: FullEventDescriptionVCRouterInput, model: FullEventModel) -> UIViewController {
    let viewController = FullEventDescriptionVC()
    let viewModel = FullEventDescriptionViewModel(model: model)
    viewController.viewModel = viewModel
    viewController.router = router
    return viewController
  }
}
