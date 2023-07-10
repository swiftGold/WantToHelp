//
//  AuthViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

import UIKit

final class AuthViewController: CustomVC {
  // MARK: - UI
  private let mainView = AuthMainView()
  
  // MARK: - Variables
  var viewModel = AuthViewModel()
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDelegates()
    setupViewController()
    setupNavBarWithBackButton(titleName: TabBarNames.auth)
    bindViewModel()
  }
}

// MARK: - AuthMainViewDelegate impl
extension AuthViewController: AuthMainViewDelegate {
  func fbButtonDidTap() {
    let vc = MainTabBarController()
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: false)
  }
  
  func enterButtonDidTap(with model: RegistrationModel) {
    viewModel.enterButtonDidTap(with: model)
  }
  
  func vkButtonDidTap() {
  }
  
  func registrationButtonDidTap() {
    let vc = RegistrationViewController()
    let viewModel = RegistrationViewModel()
    vc.viewModel = viewModel
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: - Private Methods
private extension AuthViewController {
  func bindViewModel() {
    viewModel.showStateAlert = { [weak self] status in
      switch status {
        
      case .success(let data):
        let vc = MainTabBarController()
        vc.modalPresentationStyle = .fullScreen
        self?.present(vc, animated: false)
      case .failure(let data):
        self?.callStatusAlert(status: data.status, message: data.message)
      }
    }
  }
  
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




//import UIKit
//
//protocol AuthViewControllerProtocol: AnyObject {
//  func routeToRegistrationVC(to viewController: UIViewController)
//  func routeToVkWebViewVC(to viewController: UIViewController)
//  func showAlert(with viewController: UIViewController)
//}
//
//final class AuthViewController: CustomVC {
//  // MARK: - UI
//  private let mainView = AuthMainView()
//
//  // MARK: - Variables
//  var presenter: AuthPresenterProtocol?
//
//  // MARK: - Lifecycles
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    setupDelegates()
//    setupViewController()
//    setupNavBarWithBackButton(titleName: TabBarNames.auth)
//  }
//}
//
//// MARK: - ViewControllerProtocol impl
//extension AuthViewController: AuthViewControllerProtocol {
//  func showAlert(with viewController: UIViewController) {
//    present(viewController, animated: true)
//  }
//
//  func routeToVkWebViewVC(to viewController: UIViewController) {
//    navigationController?.pushViewController(viewController, animated: true)
//  }
//
//  func routeToRegistrationVC(to viewController: UIViewController) {
//    navigationController?.pushViewController(viewController, animated: true)
//  }
//}
//
//// MARK: - AuthMainViewDelegate impl
//extension AuthViewController: AuthMainViewDelegate {
//  func fbButtonDidTap() {
//    presenter?.fbButtonDidTap()
//  }
//
//  func enterButtonDidTap(with model: RegistrationModel) {
//    presenter?.enterButtonDidTap(with: model)
//  }
//
//  func vkButtonDidTap() {
//    presenter?.vkButtonDidTap()
//  }
//
//  func registrationButtonDidTap() {
//    presenter?.registrationButtonDidTap()
//  }
//}
//
//// MARK: - Private Methods
//private extension AuthViewController {
//  func setupDelegates() {
//    mainView.delegate = self
//  }
//
//  func setupViewController() {
//    view.backgroundColor = .white
//    addSubviews()
//    addConstraints()
//  }
//
//  func addSubviews() {
//    view.myAddSubView(mainView)
//  }
//
//  func addConstraints() {
//    NSLayoutConstraint.activate([
//      mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//      mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.mainViewInsetLeft),
//      mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.mainViewInsetRight),
//      mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//    ])
//  }
//
//  enum Constants {
//    static let mainViewInsetLeft: CGFloat = 20
//    static let mainViewInsetRight: CGFloat = -20
//  }
//}
