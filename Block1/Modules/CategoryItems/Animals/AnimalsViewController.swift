//
//  AnimalsViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 29.05.2023.
//

import UIKit

protocol AnimalsViewControllerProtocol: AnyObject {}

final class AnimalsViewController: CustomVC {
  // MARK: - Variables
  var presenter: AnimalsPresenterProtocol?
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBarWithBackButton(titleName: TabBarNames.animals)
    presenter?.viewDidLoad()
  }
}

// MARK: - AnimalsViewControllerProtocol impl
extension AnimalsViewController: AnimalsViewControllerProtocol {}

// MARK: - Private Methods
private extension AnimalsViewController {
  enum Constants {
    static let customNavBarTitleFontSize: CGFloat = 21
  }
}
