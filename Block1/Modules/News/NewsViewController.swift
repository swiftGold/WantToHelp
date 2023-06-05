//
//  NewsViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import UIKit

protocol NewsViewControllerProtocol: AnyObject {}

final class NewsViewController: CustomVC {
  // MARK: - UI
  
  // MARK: - Variables
  var presenter: NewsPresenterProtocol?
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBar(titleName: TabBarNames.news)
  }
}

// MARK: - ViewControllerProtocol impl
extension NewsViewController: NewsViewControllerProtocol {}

// MARK: - Private Methods
private extension NewsViewController {}
