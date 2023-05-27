//
//  CategoriesPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 26.05.2023.
//

import Foundation

protocol CategoriesPresenterProtocol {
  func viewDidLoad()
}

final class CategoriesPresenter {
  weak var viewController: CategoriesViewControllerProtocol?
  
  private let router: Router
  private let moduleBuilder: ModuleBuilderProtocol
  private var models: [CategoryModel] = []
  
  private let categoriesArray: [(String, String)] = [
    ("girl", "Дети"),
    ("man", "Взрослые"),
    ("grandMa", "Пожилые"),
    ("cat", "Животные"),
    ("boots", "Мероприятия")
  ]
  
  init(
      router: Router,
      moduleBuilder: ModuleBuilderProtocol
  ) {
      self.router = router
      self.moduleBuilder = moduleBuilder
  }
}

extension CategoriesPresenter: CategoriesPresenterProtocol {
  func viewDidLoad() {
    models = categoriesArray.map {
      CategoryModel(image: $0.0, title: $0.1)
    }
    viewController?.setupCollectionView(with: models)
  }
}
