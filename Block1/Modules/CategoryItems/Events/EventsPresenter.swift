//
//  EventsPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 05.06.2023.
//

import Foundation

protocol EventsPresenterProtocol {
  func viewDidLoad()
}

final class EventsPresenter {
  weak var viewController: EventsViewControllerProtocol?
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

extension EventsPresenter: EventsPresenterProtocol {
  func viewDidLoad() {
  }
}
