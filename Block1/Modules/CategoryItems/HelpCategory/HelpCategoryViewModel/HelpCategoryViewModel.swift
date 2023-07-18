//
//  HelpCategoryViewModel.swift
//  Block1
//
//  Created by Сергей Золотухин on 09.07.2023.
//

import Foundation

class HelpCategoryViewModel {
  private let categoryModel: HelpCategoryModel
  init(categoryModel: HelpCategoryModel) {
    self.categoryModel = categoryModel
  }
  
  func printModel() {
    print(categoryModel)
  }
}
