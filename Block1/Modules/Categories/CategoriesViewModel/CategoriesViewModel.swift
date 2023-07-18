//
//  CategoriesViewModel.swift
//  Block1
//
//  Created by Сергей Золотухин on 09.07.2023.
//

import Foundation

class CategoriesViewModel {
  var categoriesModel: Box<[CategoryModel]> = Box([])
  var helpCategoryTitle = Box(" ")
  
  func viewDidLoad() {
    Queues.concurrentQueueBarrier.sync {
      self.fetchDataFromCoreData()
    }
  }
  
  func fetchCategoryTitle(with index: Int) {
    let title = fetchCategoryTitle(with: categoriesModel.value, index: index)
    helpCategoryTitle.value = title
  }
}

extension CategoriesViewModel {
  func fetchDataFromCoreData() {
    let coreDataModels = CoreDataManager.instance.fetchCategories()
    let models = coreDataModels.map { model in
      CategoryModel(id: Int(model.id), image: model.image, title: model.title)
    }
    categoriesModel.value = models
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
