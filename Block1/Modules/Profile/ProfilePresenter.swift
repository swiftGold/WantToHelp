//
//  ProfilePresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import Foundation

protocol ProfilePresenterProtocol {
  func viewDidLoad()
}

final class ProfilePresenter {
  weak var viewController: ProfileViewControllerProtocol?
  
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

extension ProfilePresenter: ProfilePresenterProtocol {
  func viewDidLoad() {
    
  }
}
