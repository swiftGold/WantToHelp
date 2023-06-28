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
    let childVC = moduleBuilder.buildChildViewController()
    let adultVC = moduleBuilder.buildAdultViewController()
    let elderlyVC = moduleBuilder.buildElderlyViewController()
    let animalsVC = moduleBuilder.buildAnimalsViewController()
    let eventsVC = moduleBuilder.buildEventsViewController()
    
    let categoryViewsControllers = [
      childVC,
      adultVC,
      elderlyVC,
      animalsVC,
      eventsVC
    ]
    let vc = categoryViewsControllers[index]
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
      CategoryModel(image: model.image, title: model.title)
    }
  }
}
