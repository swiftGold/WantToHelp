//
//  SearchPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import Foundation

protocol SearchPresenterProtocol {
  func viewDidLoad()
}

final class SearchPresenter {
  weak var viewController: SearchViewControllerProtocol?
  
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

extension SearchPresenter: SearchPresenterProtocol {
  func viewDidLoad() {
    
  }
}
