//
//  AdultPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 05.06.2023.
//

import Foundation

protocol AdultPresenterProtocol {
  func viewDidLoad()
}

final class AdultPresenter {
  weak var viewController: AdultViewControllerProtocol?
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

extension AdultPresenter: AdultPresenterProtocol {
  func viewDidLoad() {
  }
}
