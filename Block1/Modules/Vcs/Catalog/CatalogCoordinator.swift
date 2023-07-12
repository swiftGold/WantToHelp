//
//  CatalogCoordinator.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit

final class CatalogCoordinator: BaseCoordinator & CoordinatorOutput {
  var onFinish: (() -> Void)?
  
  private let router: Router1
  private let diContainer: CatalogDIContainer
  
  init(router: Router1,
       diContainer: CatalogDIContainer
  ) {
    self.router = router
    self.diContainer = diContainer
  }
  
  override func start() {
    let catalogViewController = diContainer.makeCatalogViewController(router: self)
    router.push(catalogViewController, animated: false)
  }
}

extension CatalogCoordinator: CatalogRouterInput {
  func routeToCartVC() {
    let viewController = CartViewCOntroller()
    router.push(viewController, animated: false)
  }
  
  func routeToDetailVC() {
    let viewController = DetailViewCOntroller()
    router.push(viewController, animated: false)
  }

  func finishFlow() {
    onFinish?()
  }
}
