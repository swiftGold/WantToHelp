//
//  AnimalsPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 05.06.2023.
//

import Foundation

protocol AnimalsPresenterProtocol {
  func viewDidLoad()
}

final class AnimalsPresenter {
  weak var viewController: AnimalsViewControllerProtocol?
  private let router: Router
  private let moduleBuilder: ModuleBuilderProtocol
  
  init(
    router: Router,
    moduleBuilder: ModuleBuilderProtocol
  ) {
    self.router = router
    self.moduleBuilder = moduleBuilder
  }
}

extension AnimalsPresenter: AnimalsPresenterProtocol {
  func viewDidLoad() {
  }
}
