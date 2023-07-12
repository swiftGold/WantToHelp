//
//  NewsPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 04.06.2023.
//

import Foundation

protocol NewsPresenterProtocol {
  func viewDidLoad()
}

final class NewsPresenter {
  weak var viewController: NewsViewControllerProtocol?
  
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

extension NewsPresenter: NewsPresenterProtocol {
  func viewDidLoad() {
    
  }
}
