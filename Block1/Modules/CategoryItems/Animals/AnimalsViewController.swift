//
//  AnimalsViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 29.05.2023.
//

import UIKit

class AnimalsViewController: UIViewController {
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBar()
  }
}

// MARK: - Private Methods
private extension AnimalsViewController {
  func setupNavBar() {
    customNavBarTitle()
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor.specialNavBarBGColor
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  func customNavBarTitle() {
    let label = UILabel()
    label.text = TabBarNames.adult
    label.font = UIFont(name: Fonts.OfficSanExtraBold,
                        size: Constants.customNavBarTitleFontSize
    )
    label.textColor = .white
    navigationItem.titleView = label
  }
  
  enum Constants {
    static let customNavBarTitleFontSize: CGFloat = 21
  }
}
