//
//  HistoryViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import UIKit

protocol HistoryViewControllerProtocol: AnyObject {}

final class HistoryViewController: CustomVC {
  // MARK: - UI
  
  // MARK: - Variables
  var presenter: HistoryPresenterProtocol?
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBar(titleName: TabBarNames.history)
  }
}

// MARK: - ViewControllerProtocol impl
extension HistoryViewController: HistoryViewControllerProtocol {}

// MARK: - Private Methods
private extension HistoryViewController {}
