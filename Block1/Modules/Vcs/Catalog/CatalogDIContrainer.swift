//
//  CatalogDIContrainer.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit

struct CatalogModuleDependencies {
  let mapNetworkService: Networkable
}

final class CatalogDIContainer {
  private let dependencies: CatalogModuleDependencies
  
  init(dependencies: CatalogModuleDependencies) {
    self.dependencies = dependencies
  }
}

extension CatalogDIContainer {
  func makeCatalogViewController(router: CatalogRouterInput) -> UIViewController {
    let viewController = CatalogViewController()
    let viewModel = CatalogViewModel()
    viewController.viewModel = viewModel
    viewController.router = router
    return viewController
  }
  
//  func makeSearchAddressViewController(router: SearchAdressRouterInput) -> UIViewController {}
//
//  func makeRestaurantsViewController(router: SearchAdressRouterInput) -> UIViewController {}
}

