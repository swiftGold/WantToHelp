//
//  NewsViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import UIKit

final class NewsViewController: CustomVC {
  // MARK: - UI
  
  // MARK: - Variables
  var viewModel: NewsViewModel?
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBar(titleName: TabBarNames.news)
  }
}

// MARK: - Private Methods
private extension NewsViewController {}
