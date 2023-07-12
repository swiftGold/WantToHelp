//
//  MapDIContainer.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit

struct MapModuleDependencies {
  let mapNetworkService: Networkable
}

final class MapDIContainer {
  private let dependencies: MapModuleDependencies
  
  init(dependencies: MapModuleDependencies) {
    self.dependencies = dependencies
  }
}

extension MapDIContainer {
  func makeMapViewController(router: MapRouterInput) -> UIViewController {
    let viewController = MapViewController()
    let viewModel = MapViewModel()
    viewController.viewModel = viewModel
    viewController.router = router
    return viewController
  }
  
  func makeSearchAddressViewController(router: SearchAdressRouterInput) -> UIViewController {
    let viewController = SearchAdressViewController()
    let viewModel = SearchAdressViewModel()
    viewController.viewModel = viewModel
    viewController.router = router
    return viewController
  }

  func makeRestaurantsViewController(router: RestaurantsRouterInput) -> UIViewController {
    let viewController = RestaurantsViewController()
    let viewModel = RestaurantsViewModel()
    viewController.viewModel = viewModel
    viewController.router = router
    return viewController
  }
}
