//
//  AuthMainView.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

import UIKit

protocol AuthMainViewDelegate: AnyObject {
  func registrationButtonDidTap()
  func enterButtonDidTap()
  func vkButtonDidTap()
}

final class AuthMainView: UIView {
  // MARK: - UI
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.titleLabelFontSize
    )
    label.textAlignment = .center
    label.textColor = .specialTitleGreyColor
    label.numberOfLines = Constants.titleLabelInfinityLines
    label.text = "Для участия в мероприятиях войдите в приложение через социальые сети"
    return label
  }()
  
  private lazy var vkButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(named: Images.vk)?.withRenderingMode(.alwaysOriginal)
    button.addTarget(self, action: #selector(didTapVkButton), for: .touchUpInside)
    button.setImage(image, for: .normal)
    return button
  }()
  
  private lazy var fbButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(named: Images.fb)?.withRenderingMode(.alwaysOriginal)
    button.addTarget(self, action: #selector(didTapFbButton), for: .touchUpInside)
    button.setImage(image, for: .normal)
    return button
  }()
  
  private lazy var okButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(named: Images.ok)?.withRenderingMode(.alwaysOriginal)
    button.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
    button.setImage(image, for: .normal)
    return button
  }()
  
  private let socialButtonsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.socialButtonsSpacing
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private let subTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.titleLabelFontSize
    )
    label.textAlignment = .center
    label.textColor = .specialTitleGreyColor
    label.numberOfLines = Constants.titleLabelInfinityLines
    label.text = "Или авторизуйтесь через приложение"
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
  
  private lazy var enterButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("ВОЙТИ", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIMed,
                                     size: Constants.enterButtonFontSize
    )
    button.addTarget(self, action: #selector(didTapEnterButton), for: .touchUpInside)
    button.layer.cornerRadius = Constants.enterButtonCorner
    button.backgroundColor = .specialNavBarBGColor
    button.tintColor = .white
    return button
  }()
  
  private lazy var revivePasswordButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Забыли пароль?", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIReg,
                                     size: Constants.revivePasswordButtonFontSize
    )
    button.addTarget(self, action: #selector(didTapRevivePasswordButton), for: .touchUpInside)
    button.tintColor = .specialNavBarBGColor
    return button
  }()
  
  private lazy var registrationButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Регистрация", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIReg,
                                     size: Constants.registrationButtonFontSize
    )
    button.addTarget(self, action: #selector(didTapRegistrationButton), for: .touchUpInside)
    button.tintColor = .specialNavBarBGColor
    return button
  }()
  
  // MARK: - Delegate
  weak var delegate: AuthMainViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Objc methods
  @objc
  private func didTapVkButton() {
    delegate?.vkButtonDidTap()
  }
  
  @objc
  private func didTapFbButton() {
    print(#function)
  }
  
  @objc
  private func didTapOkButton() {
    print(#function)
  }
  
  @objc
  private func didTapShowPasswordButton() {
    print(#function)
  }
  
  @objc
  private func didTapEnterButton() {
    delegate?.enterButtonDidTap()
  }
  
  @objc
  private func didTapRevivePasswordButton() {
    print(#function)
  }
  
  @objc
  private func didTapRegistrationButton() {
    delegate?.registrationButtonDidTap()
  }
}

// MARK: - Private methods
private extension AuthMainView {
  func setupView() {
    addSubviews()
    setConstraints()
  }
  
  func addSubviews() {
    socialButtonsStackView.addArrangedSubview(vkButton)
    socialButtonsStackView.addArrangedSubview(fbButton)
    socialButtonsStackView.addArrangedSubview(okButton)
  
    myAddSubView(titleLabel)
    myAddSubView(socialButtonsStackView)
    myAddSubView(subTitleLabel)
    myAddSubView(emailLabel)
    myAddSubView(emailTextField)
    myAddSubView(emailLineView)
    myAddSubView(passwordLabel)
    myAddSubView(passwordTextField)
    myAddSubView(passwordLineView)
    passwordTextField.myAddSubView(showPasswordButton)
    myAddSubView(enterButton)
    myAddSubView(revivePasswordButton)
    myAddSubView(registrationButton)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelInsetTop),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            socialButtonsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.socialButtonsStackViewInsetTop),
      socialButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.socialButtonsStackViewInsetLeft),
      socialButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.socialButtonsStackViewInsetRight),
      subTitleLabel.topAnchor.constraint(equalTo: socialButtonsStackView.bottomAnchor, constant: Constants.subTitleLabelInsetTop),
      subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      emailLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: Constants.emailLabelInsetTop),
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
      enterButton.topAnchor.constraint(equalTo: passwordLineView.bottomAnchor, constant: Constants.enterButtonInsetTop),
      enterButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      enterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      enterButton.heightAnchor.constraint(equalToConstant: Constants.enterButtonHeight),
      revivePasswordButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: Constants.revivePasswordButtonInsetTop),
      revivePasswordButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      revivePasswordButton.heightAnchor.constraint(equalToConstant: Constants.revivePasswordButtonHeight),
      registrationButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: Constants.registrationButtonInsetTop),
      registrationButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      registrationButton.heightAnchor.constraint(equalToConstant: Constants.registrationButtonHeight),
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
    static let socialButtonsStackViewInsetLeft: CGFloat = 68
    static let socialButtonsStackViewInsetRight: CGFloat = -68
    static let socialButtonsStackViewInsetTop: CGFloat = 20
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
    static let revivePasswordButtonInsetTop: CGFloat = 20
    static let revivePasswordButtonHeight: CGFloat = 20
    static let registrationButtonInsetTop: CGFloat = 20
    static let registrationButtonHeight: CGFloat = 20
  }
}
