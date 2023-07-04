//
//  RegistrationMainView.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

import UIKit

protocol RegistrationMainViewDelegate: AnyObject {
  func registrationButtonDidTap(with model: RegistrationModel)
}

final class RegistrationMainView: UIView {
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
    button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
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
  
  // MARK: - Delegate
  weak var delegate: RegistrationMainViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Objc methods
  @objc
  private func didTapShowPasswordButton() {
    print(#function)
  }
  
  @objc
  private func didTapRegisterButton() {
    guard let email = emailTextField.text,
          let password = passwordTextField.text else {
      return
    }
    let model = RegistrationModel(email: email, password: password)
    delegate?.registrationButtonDidTap(with: model)
  }
}

// MARK: - Private methods
private extension RegistrationMainView {
  func setupView() {
    addSubviews()
    setConstraints()
  }
  
  func addSubviews() {
    myAddSubView(titleLabel)
    myAddSubView(subTitleLabel)
    myAddSubView(emailLabel)
    myAddSubView(emailTextField)
    myAddSubView(emailLineView)
    myAddSubView(passwordLabel)
    myAddSubView(passwordTextField)
    myAddSubView(passwordLineView)
    passwordTextField.myAddSubView(showPasswordButton)
    myAddSubView(registerButton)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelInsetTop),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.emailLabelInsetTop),
      emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Constants.emailTextFieldInsetTop),
      emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
      emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
      emailLineView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Constants.emailLineViewInsetTop),
      emailLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
      emailLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
      emailLineView.heightAnchor.constraint(equalToConstant: Constants.emailLineViewHeight),
      passwordLabel.topAnchor.constraint(equalTo: emailLineView.bottomAnchor, constant: Constants.passwordLabelInsetTop),
      passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      passwordLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: Constants.passwordTextFieldInsetTop),
      passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
      passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
      passwordLineView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constants.passwordLineViewInsetTop),
      passwordLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
      passwordLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
      passwordLineView.heightAnchor.constraint(equalToConstant: Constants.passwordLineViewHeight),
      showPasswordButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
      showPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
      registerButton.topAnchor.constraint(equalTo: passwordLineView.bottomAnchor, constant: Constants.enterButtonInsetTop),
      registerButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      registerButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      registerButton.heightAnchor.constraint(equalToConstant: Constants.enterButtonHeight),
      subTitleLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: Constants.subTitleLabelInsetTop),
      subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
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
  }
}
