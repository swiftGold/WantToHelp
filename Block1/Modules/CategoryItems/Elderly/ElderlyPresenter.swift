//
//  ElderlyPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 05.06.2023.
//

import Foundation

protocol ElderlyPresenterProtocol {
  func viewDidLoad()
}

final class ElderlyPresenter {
  weak var viewController: ElderlyViewControllerProtocol?
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

extension ElderlyPresenter: ElderlyPresenterProtocol {
  func viewDidLoad() {
  }
}
