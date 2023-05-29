//
//  MainTabBarController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
  //MARK: - UI
  private lazy var middleButton: UIButton = {
    let middleButton = UIButton(type: .custom)
    let middleIcon = UIImage(named: Images.heart)?.withRenderingMode(.alwaysTemplate)
    middleButton.setImage(middleIcon, for: .normal)
    middleButton.tintColor = .white
    middleButton.backgroundColor = .specialMiddleButtonTabBarColor
    middleButton.layer.cornerRadius = 21
    middleButton.frame.size = CGSize(width: 42, height: 42)
    middleButton.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
    middleButton.addTarget(self, action: #selector(middleButtonDown), for: .touchDown)
    middleButton.addTarget(self, action: #selector(middleButtonUp), for: [.touchUpInside, .touchUpOutside])
    let space: CGFloat = 4
    middleButton.center = CGPoint(x: tabBar.center.x, y: (tabBar.bounds.height - middleButton.bounds.height / 1.2) - space)
    return middleButton
  }()
  
  private let bgTabBarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: Images.plate)
    imageView.contentMode = .scaleToFill
    return imageView
  }()
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    generateTabBar()
    setTabBarAppearance()
    setupController()
    self.selectedIndex = 2
    self.delegate = self
  }
  
  // MARK: - Objc methods
  @objc
  func middleButtonTapped(sender: UIButton) {
    selectedIndex = 2
    sender.backgroundColor = .specialNavBarBGColor
  }
  
  @objc
  func middleButtonDown(sender: UIButton) {
    sender.layer.shadowColor = UIColor.black.cgColor
    sender.layer.shadowOffset = CGSize(width: 0, height: 2)
    sender.layer.shadowRadius = 4
    sender.layer.shadowOpacity = 0.3
  }
  
  @objc
  func middleButtonUp(sender: UIButton) {
    sender.layer.shadowOpacity = 0
  }
}

// MARK: - UITabBarControllerDelegate impl
extension MainTabBarController: UITabBarControllerDelegate {
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    if tabBarItem.title != TabBarNames.categories {
      middleButton.backgroundColor = .specialMiddleButtonTabBarColor
    } else {
      middleButton.backgroundColor = .specialNavBarBGColor
    }
  }
}

// MARK: - Private methods
private extension MainTabBarController {
  func setupController() {
    view.backgroundColor = .white
    addSubviews()
    setConstraints()
  }
  
  func addSubviews() {
    tabBar.addSubview(middleButton)
    tabBar.addSubview(bgTabBarImageView)
    tabBar.sendSubviewToBack(bgTabBarImageView)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      bgTabBarImageView.heightAnchor.constraint(equalToConstant: 105),
      bgTabBarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bgTabBarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bgTabBarImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  func generateTabBar() {
    
    let newsNavVC = UINavigationController(rootViewController: NewsViewController())
    let searchNavVC = UINavigationController(rootViewController: SearchViewController())
    let categoriesNavVC = UINavigationController(rootViewController: CategoriesViewController())
    let historyNavVC = UINavigationController(rootViewController: HistoryViewController())
    let profileNavVC = UINavigationController(rootViewController: ProfileViewController())
    
    viewControllers = [
      generateVC(viewConroller: newsNavVC,
                 title: TabBarNames.news,
                 image: UIImage(named: Images.news)
                ),
      generateVC(viewConroller: searchNavVC,
                 title: TabBarNames.search,
                 image: UIImage(named: Images.search)
                ),
      generateVC(viewConroller: categoriesNavVC,
                 title: TabBarNames.categories,
                 image: UIImage(named: Images.categories)
                ),
      generateVC(viewConroller: historyNavVC,
                 title: TabBarNames.history,
                 image: UIImage(named: Images.history)
                ),
      generateVC(viewConroller: profileNavVC,
                 title: TabBarNames.profile,
                 image: UIImage(named: Images.profile))
    ]
  }
  
  func generateVC(viewConroller: UIViewController, title: String, image: UIImage?) -> UIViewController {
    viewConroller.tabBarItem.title = title
    viewConroller.tabBarItem.image = image
    return viewConroller
  }
  
  func setTabBarAppearance() {
    tabBar.tintColor = .specialNavBarBGColor
    tabBar.unselectedItemTintColor = .specialTabBarItemColor
    
    let appearance = tabBar.standardAppearance
    appearance.shadowImage = nil
    appearance.shadowColor = nil
    tabBar.standardAppearance = appearance
    
//    let bgView = UIImageView(image: UIImage(named: Images.plate))
//    // TODO: - доработать отображение на разных экранах
//    bgView.frame = CGRect(x: 0, y: 50, width: self.tabBar.bounds.width, height: -67)
//    tabBar.addSubview(bgView)
//    tabBar.sendSubviewToBack(bgView)
  }
}
