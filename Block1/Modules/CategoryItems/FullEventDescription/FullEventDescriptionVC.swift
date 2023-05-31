//
//  FullEventDescriptionVC.swift
//  Block1
//
//  Created by Сергей Золотухин on 29.05.2023.
//

import UIKit

class FullEventDescriptionVC: UIViewController {
  //MARK: - UI
  private lazy var barButtonItem = UIBarButtonItem(image: UIImage(named: Images.share), style: .plain, target: self, action: #selector(didTapBarButton))
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .clear
    return scrollView
  }()
  
  private let backgroundView: UIView = {
    let backgroundView = UIView()
    backgroundView.backgroundColor = .clear
    return backgroundView
  }()
  
  private let customNavBarTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.OfficSanExtraBold, size: 21)
    label.textColor = .white
    return label
  }()
  
  private let fullEventDescriptionMainView = FullEventDescriptionMainView()
  private let bottomParticipantsView = BottomParticipantsView()
  private let bottomButtonsView = BottomButtonsView()
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    setupNavBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    tabBarController?.tabBar.isHidden = false
  }
  
  func configureViewController(with model: FullEventDescriptionViewModel) {
    customNavBarTitle.text = model.title
    fullEventDescriptionMainView.configureView(with: model)
    bottomParticipantsView.configureView(with: model)
  }
  
  // MARK: - Objc methods
  @objc
  private func didTapBarButton() {
    print(#function)
  }
}

// MARK: - Private Methods
private extension FullEventDescriptionVC {
  func setupViewController() {
    view.backgroundColor = .white
    addSubviews()
    addConstraints()
  }
  
  func addSubviews() {
    view.myAddSubView(scrollView)
    scrollView.myAddSubView(backgroundView)
    backgroundView.myAddSubView(fullEventDescriptionMainView)
    view.myAddSubView(bottomParticipantsView)
    view.myAddSubView(bottomButtonsView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      scrollView.bottomAnchor.constraint(equalTo: bottomParticipantsView.topAnchor, constant: -32),
      
      backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      backgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      
      fullEventDescriptionMainView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
      fullEventDescriptionMainView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
      fullEventDescriptionMainView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
      fullEventDescriptionMainView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
      
      bottomParticipantsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bottomParticipantsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bottomParticipantsView.bottomAnchor.constraint(equalTo: bottomButtonsView.topAnchor),
      bottomParticipantsView.heightAnchor.constraint(equalToConstant: 68),
      
      bottomButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bottomButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bottomButtonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      bottomButtonsView.heightAnchor.constraint(equalToConstant: 70),
    ])
  }
  
  func setupNavBar() {
    navigationItem.titleView = customNavBarTitle
    navigationItem.rightBarButtonItem = barButtonItem
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor.specialNavBarBGColor
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
}
