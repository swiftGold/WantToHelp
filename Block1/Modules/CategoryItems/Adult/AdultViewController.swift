//
//  AdultViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 29.05.2023.
//

import UIKit

protocol AdultViewControllerProtocol: AnyObject {}

final class AdultViewController: CustomVC {
  // MARK: - Variables
  var presenter: AdultPresenterProtocol?
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBarWithBackButton(titleName: TabBarNames.adult)
    presenter?.viewDidLoad()
  }
}

// MARK: - AdultViewControllerProtocol impl
extension AdultViewController: AdultViewControllerProtocol {}

// MARK: - Private Methods
private extension AdultViewController {
  enum Constants {
    static let customNavBarTitleFontSize: CGFloat = 21
  }
}
