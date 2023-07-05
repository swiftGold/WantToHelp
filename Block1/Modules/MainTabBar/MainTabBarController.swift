//
//  MainTabBarController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
  // MARK: - UI
  private lazy var middleButton: UIButton = {
    let middleButton = UIButton(type: .custom)
    let middleIcon = UIImage(named: Images.heart)?.withRenderingMode(.alwaysTemplate)
    middleButton.setImage(middleIcon, for: .normal)
    middleButton.tintColor = .white
    middleButton.backgroundColor = .specialMiddleButtonTabBarColor
    middleButton.layer.cornerRadius = Constants.middleButtonCornerRadius
    middleButton.frame.size = CGSize(width: Constants.middleButtonWidthFrameSize,
                                     height: Constants.middleButtonHeightFrameSize)
    middleButton.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
    middleButton.addTarget(self, action: #selector(middleButtonDown), for: .touchDown)
    middleButton.addTarget(self, action: #selector(middleButtonUp), for: [.touchUpInside, .touchUpOutside])
    middleButton.center = CGPoint(x: tabBar.center.x, y: (tabBar.bounds.height - middleButton.bounds.height / Constants.tabBarcoefficient) - Constants.spaceForTabBarImage)
    return middleButton
  }()
  
  var moduleBuilder: ModuleBuilderProtocol
  
  init(moduleBuilder: ModuleBuilderProtocol) {
    self.moduleBuilder = moduleBuilder
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    generateTabBar()
    setTabBarAppearance()
    setupController()
    self.selectedIndex = Constants.tabBarSelectedItemIndex
    middleButton.backgroundColor = .specialNavBarBGColor
    self.delegate = self
  }
  
  // MARK: - Objc methods
  @objc
  func middleButtonTapped(sender: UIButton) {
    selectedIndex = Constants.tabBarSelectedItemIndex
    sender.backgroundColor = .specialNavBarBGColor
  }
  
  @objc
  func middleButtonDown(sender: UIButton) {
    sender.layer.shadowColor = UIColor.black.cgColor
    sender.layer.shadowOffset = CGSize(width: Constants.middleButtonShadowWidth,
                                       height: Constants.middleButtonShadowHeight)
    sender.layer.shadowRadius = Constants.middleButtonShadowRadius
    sender.layer.shadowOpacity = Constants.middleButtonShadowOpacityAfterPush
  }
  
  @objc
  func middleButtonUp(sender: UIButton) {
    sender.layer.shadowOpacity = Constants.middleButtonShadowOpacityAfterReturn
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
  }
  
  func addSubviews() {
    tabBar.addSubview(middleButton)
  }
  
  func generateTabBar() {
    
    let newsNavVC = UINavigationController(rootViewController: moduleBuilder.buildNewsViewController())
    let searchNavVC = UINavigationController(rootViewController: moduleBuilder.buildSearchViewController())
    let categoriesNavVC = UINavigationController(rootViewController: moduleBuilder.buildCategoriesViewController())
    let historyNavVC = UINavigationController(rootViewController: moduleBuilder.buildHistoryViewController())
    let profileNavVC = UINavigationController(rootViewController: moduleBuilder.buildProfileViewController())
    
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
    
    let bgView = UIImageView(image: UIImage(named: Images.plate))
    bgView.frame = CGRect(x: Constants.tabBarBackgroundViewOriginX,
                          y: Constants.tabBarBackgroundViewOriginY,
                          width: self.tabBar.bounds.width,
                          height: Constants.tabBarBackgroundViewFrameHeight)
    tabBar.addSubview(bgView)
    tabBar.sendSubviewToBack(bgView)
  }
  
  enum Constants {
    static let middleButtonCornerRadius: CGFloat = 21
    static let middleButtonWidthFrameSize: CGFloat = 42
    static let middleButtonHeightFrameSize: CGFloat = 42
    static let middleButtonShadowWidth: CGFloat = 0
    static let middleButtonShadowHeight: CGFloat = 2
    static let middleButtonShadowRadius: CGFloat = 4
    static let middleButtonShadowOpacityAfterPush: Float = 0.3
    static let middleButtonShadowOpacityAfterReturn: Float = 0
    static let tabBarcoefficient: CGFloat = 1.2
    static let spaceForTabBarImage: CGFloat = 4
    static let tabBarSelectedItemIndex = 2
    static let tabBarBackgroundViewOriginX: CGFloat = 0
    static let tabBarBackgroundViewOriginY: CGFloat = 50
    static let tabBarBackgroundViewFrameHeight: CGFloat = -67
  }
}
