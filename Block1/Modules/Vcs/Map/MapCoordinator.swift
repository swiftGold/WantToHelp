//
//  MapCoordinator.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit

final class MapCoordinator: BaseCoordinator & CoordinatorOutput {
  var onFinish: (() -> Void)?
  
  private let router: Router1
  private let diContainer: MapDIContainer
  
  init(router: Router1,
       diContainer: MapDIContainer
  ) {
    self.router = router
    self.diContainer = diContainer
  }
  
  override func start() {
    let mapViewController = diContainer.makeMapViewController(router: self)
    router.setRoot(mapViewController, embedNavBar: true, isNavigationBarHidden: false)
  }
}

extension MapCoordinator: MapRouterInput {
  func routeToSearchAddress() {
    let viewController = diContainer.makeSearchAddressViewController(router: self)
    router.push(viewController, animated: false)
  }
}

extension MapCoordinator: SearchAdressRouterInput {
  func routeToRestaurantsVC() {
    let viewController = diContainer.makeRestaurantsViewController(router: self)
    router.push(viewController, animated: false)
  }
}

extension MapCoordinator: RestaurantsRouterInput {
  func routeToCatalogVCFINISHFLOW() {
    onFinish?()
  }
}
