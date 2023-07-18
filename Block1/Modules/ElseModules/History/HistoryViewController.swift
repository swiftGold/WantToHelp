//
//  HistoryViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import UIKit

final class HistoryViewController: CustomVC {
  // MARK: - UI
  
  // MARK: - Variables
  var viewModel: HistoryViewModel?

  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBar(titleName: TabBarNames.history)
  }
}

// MARK: - Private Methods
private extension HistoryViewController {}
