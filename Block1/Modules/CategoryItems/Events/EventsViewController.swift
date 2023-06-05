//
//  EventsViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 29.05.2023.
//

import UIKit

protocol EventsViewControllerProtocol: AnyObject {}

final class EventsViewController: CustomVC {
  // MARK: - Variables
  var presenter: EventsPresenterProtocol?
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBarWithBackButton(titleName: TabBarNames.events)
    presenter?.viewDidLoad()
  }
}

// MARK: - EventsViewControllerProtocol impl
extension EventsViewController: EventsViewControllerProtocol {}

// MARK: - Private Methods
private extension EventsViewController {
  enum Constants {
    static let customNavBarTitleFontSize: CGFloat = 21
  }
}
