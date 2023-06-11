//
//  CategoriesPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 26.05.2023.
//

import Foundation

protocol CategoriesPresenterProtocol {
  func viewDidLoad()
  func routeToCategoryItem(index: Int)
}

final class CategoriesPresenter {
  weak var viewController: CategoriesViewControllerProtocol?
  private var categoriesModel: [CategoryModel] = []
  private let router: Router
  private let moduleBuilder: ModuleBuilderProtocol
  private let jsonService: JSONServiceProtocol
  
  init(
    router: Router,
    moduleBuilder: ModuleBuilderProtocol,
    jsonService: JSONServiceProtocol
  ) {
    self.router = router
    self.moduleBuilder = moduleBuilder
    self.jsonService = jsonService
  }
}

extension CategoriesPresenter: CategoriesPresenterProtocol {
  func routeToCategoryItem(index: Int) {
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
    // MARK: - 1
    //    DispatchQueue.global(qos: .background).async { [weak self] in
    //      guard let strongSelf = self else { return }
    //      let group = DispatchGroup()
    //      group.enter()
    //      strongSelf.fetchDataFromJson()
    //      group.leave()
    //      group.notify(queue: DispatchQueue.main) {
    //        strongSelf.viewController?.setupCollectionView(with: strongSelf.categoriesModel)
    //      }
    //    }
    
    // MARK: - 2
    //    DispatchQueue.global(qos: .background).async {
    //      self.fetchDataFromJson()
    //      DispatchQueue.main.async {
    //        self.viewController?.setupCollectionView(with: self.categoriesModel)
    //      }
    //    }
    
    // MARK: - 3
//    let semaphore = DispatchSemaphore(value: 1)
//    DispatchQueue.global(qos: .background).async {
//      semaphore.wait()
//      self.fetchDataFromJson()
//      semaphore.signal()
//      DispatchQueue.main.async {
//        self.viewController?.setupCollectionView(with: self.categoriesModel)
//      }
//    }
    
    // MARK: - 4
    DispatchQueue.global(qos: .background).sync {
      self.fetchDataFromJson()
    }
    
    DispatchQueue.main.async {
      self.viewController?.setupCollectionView(with: self.categoriesModel)
    }
  }
}

private extension CategoriesPresenter {
  func fetchDataFromJson() {
    jsonService.fetchCategoriesFromJSON(completion: { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let response):
        strongSelf.categoriesModel = response
      case .failure(let error):
        print(error.localizedDescription)
      }
    })
  }
}
