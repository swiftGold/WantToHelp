//
//  RegistrationViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class RegistrationViewController: CustomVC {
  // MARK: - UI
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.titleLabelFontSize
    )
    label.textAlignment = .center
    label.textColor = .specialTitleGreyColor
    label.numberOfLines = Constants.titleLabelInfinityLines
    label.text = "Регистрация бесплатна \n и не займет у вас много времени"
    return label
  }()
  
  private let emailLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.emailLabelFontSize
    )
    label.textAlignment = .left
    label.textColor = .specialDiaryLightGreyColor
    label.text = "E-mail"
    return label
  }()
  
  private lazy var emailTextField: UITextField = {
    let textField = UITextField()
    textField.attributedPlaceholder = NSAttributedString(
      string: "Введите e-mail",
      attributes: [NSAttributedString.Key.foregroundColor: UIColor.specialDiaryLightGreyColor]
    )
    textField.textColor = .specialTitleGreyColor
    textField.font = UIFont(name: Fonts.SFUIReg,
                            size: Constants.emailTextFieldFontSize
    )
    return textField
  }()
  
  private let emailLineView: UIView = {
    let view = UIView()
    view.backgroundColor = .specialDiaryLightGreyColor
    return view
  }()
  
  private let passwordLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.emailLabelFontSize
    )
    label.textAlignment = .left
    label.textColor = .specialDiaryLightGreyColor
    label.text = "Пароль"
    return label
  }()
  
  private lazy var passwordTextField: UITextField = {
    let textField = UITextField()
    textField.attributedPlaceholder = NSAttributedString(
      string: "Введите пароль",
      attributes: [NSAttributedString.Key.foregroundColor: UIColor.specialDiaryLightGreyColor]
    )
    textField.textColor = .specialTitleGreyColor
    textField.font = UIFont(name: Fonts.SFUIReg,
                            size: Constants.emailTextFieldFontSize
    )
    return textField
  }()
  
  private let passwordLineView: UIView = {
    let view = UIView()
    view.backgroundColor = .specialDiaryLightGreyColor
    return view
  }()
  
  private lazy var showPasswordButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(named: Images.showPassword)?.withRenderingMode(.alwaysOriginal)
    button.addTarget(self, action: #selector(didTapShowPasswordButton), for: .touchUpInside)
    button.setImage(image, for: .normal)
    return button
  }()
  
  private lazy var registerButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("ЗАРЕГИСТРИРОВАТЬСЯ", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIMed,
                                     size: Constants.enterButtonFontSize
    )
    button.layer.cornerRadius = Constants.enterButtonCorner
    button.backgroundColor = .specialNavBarBGColor
    button.tintColor = .white
    return button
  }()
  
  private let subTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.titleLabelFontSize
    )
    label.textAlignment = .center
    label.textColor = .specialTitleGreyColor
    label.numberOfLines = Constants.titleLabelInfinityLines
    label.text = "На указанный вами e-mail придет уведомление об успешной регистрации"
    return label
  }()
  
  // MARK: - Variables
  var viewModel = RegistrationViewModel()
  private let disposeBag = DisposeBag()
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    setupNavBarWithBackButton(titleName: TabBarNames.reg)
    bindViewModel()
  }
  
  // MARK: - Objc methods
  @objc
  private func didTapShowPasswordButton() {
    print(#function)
  }
}

// MARK: - Private Methods
private extension RegistrationViewController {
  func bindViewModel() {
    emailTextField.rx.text.orEmpty
      .bind(to: viewModel.emailText)
      .disposed(by: disposeBag)
    passwordTextField.rx.text.orEmpty
      .bind(to: viewModel.passwordText)
      .disposed(by: disposeBag)
    
    registerButton.rx.tap
      .flatMapLatest { [weak self] _ in
        return self?.viewModel
          .registerUser() ?? Observable
          .just(false)
      }
      .subscribe(onNext: { [weak self] success in
        if success {
          let vc = AuthViewController()
          let viewModel = AuthViewModel()
          vc.viewModel = viewModel
          self?.navigationController?.pushViewController(vc, animated: true)
        }
      })
      .disposed(by: disposeBag)
  }
//
//  func callSuccessAlert(status: String, message: String) {
//    let alert = UIAlertController(title: status, message: message, preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
//      let vc = AuthViewController()
//      let viewModel = AuthViewModel()
//      vc.viewModel = viewModel
//      self.navigationController?.pushViewController(vc, animated: true)
//    })
//    present(alert, animated: true)
//  }
  
  func setupViewController() {
    view.backgroundColor = .white
    addSubviews()
    addConstraints()
  }
  
  func addSubviews() {
    view.myAddSubView(titleLabel)
    view.myAddSubView(subTitleLabel)
    view.myAddSubView(emailLabel)
    view.myAddSubView(emailTextField)
    view.myAddSubView(emailLineView)
    view.myAddSubView(passwordLabel)
    view.myAddSubView(passwordTextField)
    view.myAddSubView(passwordLineView)
    passwordTextField.myAddSubView(showPasswordButton)
    view.myAddSubView(registerButton)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.titleLabelInsetTop),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.containerLeadingInset),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.containerTrailingInset),
      emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.emailLabelInsetTop),
      emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.containerLeadingInset),
      emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.containerTrailingInset),
      emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Constants.emailTextFieldInsetTop),
      emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.containerLeadingInset),
      emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.containerTrailingInset),
      emailLineView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Constants.emailLineViewInsetTop),
      emailLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.containerLeadingInset),
      emailLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.containerTrailingInset),
      emailLineView.heightAnchor.constraint(equalToConstant: Constants.emailLineViewHeight),
      passwordLabel.topAnchor.constraint(equalTo: emailLineView.bottomAnchor, constant: Constants.passwordLabelInsetTop),
      passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.containerLeadingInset),
      passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.containerTrailingInset),
      passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: Constants.passwordTextFieldInsetTop),
      passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.containerLeadingInset),
      passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.containerTrailingInset),
      passwordLineView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constants.passwordLineViewInsetTop),
      passwordLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.containerLeadingInset),
      passwordLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.containerTrailingInset),
      passwordLineView.heightAnchor.constraint(equalToConstant: Constants.passwordLineViewHeight),
      showPasswordButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
      showPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: Constants.containerTrailingInset),
      registerButton.topAnchor.constraint(equalTo: passwordLineView.bottomAnchor, constant: Constants.enterButtonInsetTop),
      registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.containerLeadingInset),
      registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.containerTrailingInset),
      registerButton.heightAnchor.constraint(equalToConstant: Constants.enterButtonHeight),
      subTitleLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: Constants.subTitleLabelInsetTop),
      subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.containerLeadingInset),
      subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.containerTrailingInset),
    ])
  }
  
  enum Constants {
    static let titleLabelInfinityLines = 0
    static let titleLabelFontSize: CGFloat = 15
    static let emailLabelFontSize: CGFloat = 13
    static let emailTextFieldFontSize: CGFloat = 17
    static let enterButtonFontSize: CGFloat = 15
    static let enterButtonCorner: CGFloat = 4
    static let revivePasswordButtonFontSize: CGFloat = 15
    static let registrationButtonFontSize: CGFloat = 15
    static let socialButtonsSpacing: CGFloat = 0
    static let titleLabelInsetTop: CGFloat = 119
    static let subTitleLabelInsetTop: CGFloat = 40
    static let emailLabelInsetTop: CGFloat = 30
    static let emailTextFieldInsetTop: CGFloat = 6
    static let emailLineViewInsetTop: CGFloat = 10
    static let emailLineViewHeight: CGFloat = 1
    static let passwordLabelInsetTop: CGFloat = 30
    static let passwordTextFieldInsetTop: CGFloat = 6
    static let passwordLineViewInsetTop: CGFloat = 10
    static let passwordLineViewHeight: CGFloat = 1
    static let enterButtonInsetTop: CGFloat = 30
    static let enterButtonHeight: CGFloat = 50
    static let containerLeadingInset: CGFloat = 20
    static let containerTrailingInset: CGFloat = -20
  }
}



//    let input = RegistrationViewModel.Input(loginText: emailTextField.rx.text.orEmpty.asObservable(),
//                                            PasswordText: passwordTextField.rx.text.orEmpty.asObservable(),
//                                            registerButtonTap: registerButton.rx.tap.asObservable())
