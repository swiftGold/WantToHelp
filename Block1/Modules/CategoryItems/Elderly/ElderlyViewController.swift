//
//  ElderlyViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 29.05.2023.
//

import UIKit

protocol ElderlyViewControllerProtocol: AnyObject {}

final class ElderlyViewController: CustomVC {
  // MARK: - Variables
  var presenter: ElderlyPresenterProtocol?
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBarWithBackButton(titleName: TabBarNames.elderly)
    presenter?.viewDidLoad()
  }
}

// MARK: - ElderlyViewControllerProtocol impl
extension ElderlyViewController: ElderlyViewControllerProtocol {}

// MARK: - Private Methods
private extension ElderlyViewController {
  enum Constants {
    static let customNavBarTitleFontSize: CGFloat = 21
  }
}
