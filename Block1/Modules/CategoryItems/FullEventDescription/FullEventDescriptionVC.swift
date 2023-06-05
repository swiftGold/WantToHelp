//
//  FullEventDescriptionVC.swift
//  Block1
//
//  Created by Сергей Золотухин on 29.05.2023.
//

import UIKit

protocol FullEventDescriptionVCProtocol: AnyObject {
  func updateViewController(titleText: String,
                            with mainViewModel: MainViewModel,
                            with participantsViewModel: ParticipantsViewModel
  )
}

final class FullEventDescriptionVC: CustomVC {
  // MARK: - UI
  private lazy var barButtonItem = UIBarButtonItem(image: UIImage(named: Images.share),
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(didTapBarButton)
  )
  
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
    label.font = UIFont(name: Fonts.OfficSanExtraBold,
                        size: Constants.customNavBarTitleFontSize
    )
    label.textColor = .white
    return label
  }()
  
  // MARK: - Variables
  var presenter: FullEventDescriptionPresenterProtocol?
  private let fullEventDescriptionMainView = FullEventDescriptionMainView()
  private let bottomParticipantsView = BottomParticipantsView()
  private let bottomButtonsView = BottomButtonsView()
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    setupNavBarWithoutTitle()
    navigationItem.titleView = customNavBarTitle
    navigationItem.rightBarButtonItem = barButtonItem
    setupDelegates()
    presenter?.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    tabBarController?.tabBar.isHidden = false
  }
  
  // MARK: - Objc methods
  @objc
  private func didTapBarButton() {
    print(#function)
  }
}

// MARK: - FullEventDescriptionVCProtocol impl
extension FullEventDescriptionVC: FullEventDescriptionVCProtocol {
  func updateViewController(titleText: String,
                            with mainViewModel: MainViewModel,
                            with participantsViewModel: ParticipantsViewModel
  ) {
    customNavBarTitle.text = titleText
    fullEventDescriptionMainView.configureView(with: mainViewModel)
    bottomParticipantsView.configureView(with: participantsViewModel)
  }
}

// MARK: - BottomButtonsViewDelegate
extension FullEventDescriptionVC: BottomButtonsViewDelegate {
  func didTapShirtButton() {
    presenter?.didTapShirtButton()
  }
  
  func didTapHandsButton() {
    presenter?.didTapHandsButton()
  }
  
  func didTapToolsButton() {
    presenter?.didTapToolsButton()
  }
  
  func didTapCashButton() {
    presenter?.didTapCashButton()
  }
}

// MARK: - FullEventDescriptionMainViewDelegate
extension FullEventDescriptionVC: FullEventDescriptionMainViewDelegate {
  func didTapWriteUsButton() {
    presenter?.didTapWriteUsButton()
  }
  
  func didTapRouteToSiteButton() {
    presenter?.didTapRouteToSiteButton()
  }
}

// MARK: - Private Methods
private extension FullEventDescriptionVC {
  func setupDelegates() {
    bottomButtonsView.delegate = self
    fullEventDescriptionMainView.delegate = self
  }
  
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
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.scrollViewTopInset),
      scrollView.bottomAnchor.constraint(equalTo: bottomParticipantsView.topAnchor, constant: Constants.scrollViewBottomInset),
      backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      backgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      fullEventDescriptionMainView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
      fullEventDescriptionMainView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: Constants.fullEventDescriptionMainViewTrailingInset),
      fullEventDescriptionMainView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Constants.fullEventDescriptionMainViewLeadingInset),
      fullEventDescriptionMainView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
      bottomParticipantsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bottomParticipantsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bottomParticipantsView.bottomAnchor.constraint(equalTo: bottomButtonsView.topAnchor),
      bottomParticipantsView.heightAnchor.constraint(equalToConstant: Constants.bottomParticipantsViewHeight),
      bottomButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bottomButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bottomButtonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      bottomButtonsView.heightAnchor.constraint(equalToConstant: Constants.bottomButtonsViewHeight),
    ])
  }

  enum Constants {
    static let customNavBarTitleFontSize: CGFloat = 21
    static let scrollViewTopInset: CGFloat = 20
    static let scrollViewBottomInset: CGFloat = -32
    static let fullEventDescriptionMainViewTrailingInset: CGFloat = -20
    static let fullEventDescriptionMainViewLeadingInset: CGFloat = 20
    static let bottomParticipantsViewHeight: CGFloat = 68
    static let bottomButtonsViewHeight: CGFloat = 70
  }
}
