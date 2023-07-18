//
//  CategoriesCoordinator.swift
//  Block1
//
//  Created by Сергей Золотухин on 12.07.2023.
//

import UIKit

final class CategoriesCoordinator: BaseCoordinator & CoordinatorOutput {
  var onFinish: (() -> Void)?
  
  private let router: Router
  private let diContainer: CategoriesDIContainer
  
  init(router: Router,
       diContainer: CategoriesDIContainer
  ) {
    self.router = router
    self.diContainer = diContainer
  }
  
  override func start() {
    let categoriesViewController = diContainer.makeCategoriesViewController(router: self)
    router.setRoot(categoriesViewController, embedNavBar: true, isNavigationBarHidden: true)
  }
}

extension CategoriesCoordinator: CategoriesRouterInput {
  func routeToHelpCategory(with model: HelpCategoryModel) {
    let helpCategoryViewController = diContainer.makeHelpCategoryViewController(router: self, model: model)
    router.push(helpCategoryViewController, animated: false)
  }
}

extension CategoriesCoordinator: HelpCategoryRouterInput {
  func routeToFullEventDescriptionVC(with model: FullEventModel) {
    let fullEventDescriptionViewController = diContainer.makeEventDescriptionViewController(router: self, model: model)
    router.push(fullEventDescriptionViewController, animated: false)
  }
}

extension CategoriesCoordinator: FullEventDescriptionVCRouterInput {}
