//
//  SearchViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {}

final class SearchViewController: CustomVC {
  // MARK: - UI
  
  // MARK: - Variables
  var presenter: SearchPresenterProtocol?
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBar(titleName: TabBarNames.search)
  }
}

// MARK: - ViewControllerProtocol impl
extension SearchViewController: SearchViewControllerProtocol {}

// MARK: - Private Methods
private extension SearchViewController {}
