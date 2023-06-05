//
//  HistoryPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import Foundation

protocol HistoryPresenterProtocol {
  func viewDidLoad()
}

final class HistoryPresenter {
  weak var viewController: HistoryViewControllerProtocol?
  
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

extension HistoryPresenter: HistoryPresenterProtocol {
  func viewDidLoad() {
    
  }
}
