//
//  AuthViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class AuthViewController: CustomVC {
  // MARK: - UI
  private let mainView = AuthMainView()
  
  // MARK: - Variables
  var viewModel = AuthViewModel()
  let disposeBag = DisposeBag()
  
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
  
  func vkButtonDidTap() {}
  
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
    mainView.emailTextField.rx.text.orEmpty
      .bind(to: viewModel.emailText)
      .disposed(by: disposeBag)
    mainView.passwordTextField.rx.text.orEmpty
      .bind(to: viewModel.passwordText)
      .disposed(by: disposeBag)
    
    mainView.enterButton.rx.tap
      .flatMapLatest { [weak self] _ in
        return self?.viewModel.loginUser() ?? Observable
          .just(false)
      }
      .subscribe(onNext: { [weak self] success in
        if success {
          print("Login successful")
          let vc = MainTabBarController()
          vc.modalPresentationStyle = .fullScreen
          self?.present(vc, animated: false)
        }
      })
      .disposed(by: disposeBag)
    
    mainView.okButton.rx.tap
      .bind(to: viewModel.didTapOkButton)
      .disposed(by: disposeBag)
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
