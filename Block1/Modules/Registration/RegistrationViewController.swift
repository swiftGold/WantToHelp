//
//  RegistrationViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

import UIKit

protocol RegistrationViewControllerProtocol: AnyObject {
  func routeToAuthVC(to viewController: UIViewController)
  func showAlert(with viewController: UIViewController)
}

final class RegistrationViewController: CustomVC {
  // MARK: - UI
  private let mainView = RegistrationMainView()
  
  // MARK: - Variables
  var presenter: RegistrationPresenterProtocol?
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDelegates()
    setupViewController()
    setupNavBarWithBackButton(titleName: TabBarNames.reg)
  }
}

// MARK: - ViewControllerProtocol impl
extension RegistrationViewController: RegistrationViewControllerProtocol {
  func showAlert(with viewController: UIViewController) {
    present(viewController, animated: true)
  }
  
  func routeToAuthVC(to viewController: UIViewController) {
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - RegistrationMainViewDelegate impl
extension RegistrationViewController: RegistrationMainViewDelegate {
  func registrationButtonDidTap(with model: RegistrationModel) {
    presenter?.didTapGeristrationButton(with: model)
  }
}

// MARK: - Private Methods
private extension RegistrationViewController {
  func setupDelegates() {
    mainView.delegate = self
  }
  
  func setupViewController() {
    view.backgroundColor = .white
    addSubviews()
    addConstraints()
  }
  
  func addSubviews() {
    view.myAddSubView(mainView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.mainViewInsetLeft),
      mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.mainViewInsetRight),
      mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  enum Constants {
    static let mainViewInsetLeft: CGFloat = 20
    static let mainViewInsetRight: CGFloat = -20
  }
}
