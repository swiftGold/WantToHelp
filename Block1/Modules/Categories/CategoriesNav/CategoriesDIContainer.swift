//
//  CategoriesDIContainer.swift
//  Block1
//
//  Created by Сергей Золотухин on 12.07.2023.
//

import UIKit

struct CategoriesModuleDependencies {
  let categoriesNetworkService: Networkable
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
  
  func makeHelpCategoryViewController(router: HelpCategoryRouterInput) -> UIViewController {
    let viewController = HelpCategoryViewController()
    let viewModel = HelpCategoryViewModel()
    viewController.viewModel = viewModel
    viewController.router = router
    return viewController
  }
}
