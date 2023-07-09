//
//  CategoriesPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 26.05.2023.
//

import Foundation

protocol CategoriesPresenterProtocol {
  func viewDidLoad()
  func categoryItemDidTap(index: Int)
  func didTapBackButton()
}

final class CategoriesPresenter {
  weak var viewController: CategoriesViewControllerProtocol?
  private var categoriesModel: [CategoryModel] = []
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

extension CategoriesPresenter: CategoriesPresenterProtocol {
  func didTapBackButton() {
    let vc = moduleBuilder.buildAuthViewController()
    viewController?.routeToVC(with: vc)
  }
  
  func categoryItemDidTap(index: Int) {
    let title = fetchCategoryTitle(with: categoriesModel, index: index)
    let model = HelpCategoryModel(title: title, id: index)
    let vc = moduleBuilder.buildHelpCategoryViewController(with: model)
    viewController?.routeToVC(with: vc)
  }
  
  func viewDidLoad() {
    Queues.concurrentQueueBarrier.sync {
      self.fetchDataFromCoreData()
    }
    
    DispatchQueue.main.async {
      self.viewController?.setupCollectionView(with: self.categoriesModel)
    }
  }
}

private extension CategoriesPresenter {
  func fetchDataFromCoreData() {
    let coreDataModels = CoreDataManager.instance.fetchCategories()
    categoriesModel = coreDataModels.map { model in
      CategoryModel(id: Int(model.id), image: model.image, title: model.title)
    }
  }
  
  func fetchCategoryTitle(with models: [CategoryModel], index: Int) -> String {
    var returnedString = ""
    models.forEach { elem in
      if elem.id == index {
        guard let title = elem.title else { return }
        returnedString = title
      }
    }
    return returnedString
  }
}
