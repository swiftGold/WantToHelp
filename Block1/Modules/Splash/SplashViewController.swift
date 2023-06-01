//
//  SplashViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 19.05.2023.
//

import UIKit

class SplashViewController: UIViewController {
  // MARK: - UI
  private let logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.logo)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let loadLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.loadLabelFontSize)
    label.textAlignment = .center
    label.textColor = .specialTitleGreyColor
    label.text = "Загрузка..."
    return label
  }()
  
  private let simbirSoftLogoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.simbirSoft)
    return imageView
  }()
    
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    routeAfterLoad()
    LoadingOverlay.shared.showOverlay(view: self.view)
    // TODO: - delete after
//        for family in UIFont.familyNames.sorted() {
//          let names = UIFont.fontNames(forFamilyName: family)
//          print("family : \(family) Font names : \(names)")
//        }
  }
}

// MARK: - Private methods
private extension SplashViewController {
  func routeAfterLoad() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      guard let strongSelf = self else { return }
      let viewController = MainTabBarController()
      viewController.modalPresentationStyle = .fullScreen
      strongSelf.present(viewController, animated: false)
    }
  }
  
  func setupViewController() {
    view.backgroundColor = .specialLightBlueBGColor
    
    addSubviews()
    addConstraints()
  }
  
  func addSubviews() {
    view.myAddSubView(logoImageView)
    view.myAddSubView(loadLabel)
    view.myAddSubView(simbirSoftLogoImageView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.logoImageViewTopInset),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: Constants.logoImageViewHeight),
      logoImageView.widthAnchor.constraint(equalToConstant: Constants.logoImageViewWidth),
      loadLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.loadLabelBottonInset),
      loadLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.loadLabelLeadingInset),
      loadLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.loadLabelTrailingInset),
      simbirSoftLogoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.simbirSoftLogoBottomInset),
      simbirSoftLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      simbirSoftLogoImageView.heightAnchor.constraint(equalToConstant: Constants.simbirSoftLogoHeight),
      simbirSoftLogoImageView.widthAnchor.constraint(equalToConstant: Constants.simbirSoftLogoWidth)
    ])
  }
  
  enum Constants {
    static let loadLabelFontSize: CGFloat = 13
    static let logoImageViewTopInset: CGFloat = 197
    static let logoImageViewHeight: CGFloat = 74
    static let logoImageViewWidth: CGFloat = 247
    static let loadLabelLeadingInset: CGFloat = 20
    static let loadLabelTrailingInset: CGFloat = -20
    static let simbirSoftLogoBottomInset: CGFloat = -48
    static let simbirSoftLogoHeight: CGFloat = 16
    static let simbirSoftLogoWidth: CGFloat = 116
    static let loadLabelBottonInset: CGFloat = -(UIScreen.main.bounds.height / 2 - 50)
  }
}

