//
//  HistoryViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import UIKit

class HistoryViewController: UIViewController {
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBar()
  }
}

// MARK: - Private Methods
private extension HistoryViewController {
  func setupNavBar() {
    customNavBarTitle()
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor.specialNavBarBGColor
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
  }
  
  func customNavBarTitle() {
    let label = UILabel()
    label.text = TabBarNames.history
    label.font = UIFont(name: Fonts.OfficSanExtraBold, size: 21)
    label.textColor = .white
    navigationItem.titleView = label
  }
}
