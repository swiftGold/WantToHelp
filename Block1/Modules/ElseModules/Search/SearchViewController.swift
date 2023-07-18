//
//  SearchViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import UIKit

final class SearchViewController: CustomVC {
  // MARK: - UI
  
  // MARK: - Variables
  var viewModel: SearchViewModel?

  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBar(titleName: TabBarNames.search)
  }
}

// MARK: - Private Methods
private extension SearchViewController {}
