//
//  FullEventDescriptionMainView.swift
//  Block1
//
//  Created by Сергей Золотухин on 30.05.2023.
//

import UIKit

final class FullEventDescriptionMainView: UIView {
  // MARK: - UI
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.OfficSanExtraBold, size: 21)
    label.textAlignment = .left
    label.textColor = .specialTitleColor
    label.numberOfLines = 0
    return label
  }()
  
  private let diaryImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.greyDiary)
    return imageView
  }()
  
  private let diaryLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIMed, size: 11)
    label.textAlignment = .left
    label.textColor = .specialDiaryLightGreyColor
    return label
  }()
  
  private let diaryStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 10
    stackView.distribution = .fill
    stackView.alignment = .leading
    return stackView
  }()
  
  private let organizationNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg, size: 11)
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    label.numberOfLines = 0
    return label
  }()
  
  private let adressLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg, size: 15)
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    label.numberOfLines = 0
    return label
  }()
  
  private let adressImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.nav)
    return imageView
  }()
  
  private let adressStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 10
    stackView.distribution = .fill
    stackView.alignment = .leading
    return stackView
  }()
  
  private let firstPhoneLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg, size: 15)
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    return label
  }()
  
  private let secondPhoneLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg, size: 15)
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    return label
  }()
  
  private let phoneNumbersStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 3
    stackView.distribution = .fill
    stackView.alignment = .leading
    return stackView
  }()
  
  private let phoneImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.phone)
    return imageView
  }()
  
  private let phoneStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 10
    stackView.distribution = .fill
    stackView.alignment = .leading
    return stackView
  }()
  
  private let mailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.mail)
    return imageView
  }()
  
  private let mailLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg, size: 15)
    label.text = "У вас есть вопросы?"
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    return label
  }()
  
  private lazy var writeUsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Напишите нам", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIReg, size: 15)
    button.addTarget(self, action: #selector(writeUsButtonTapped), for: .touchUpInside)
    button.tintColor = .specialNavBarBGColor
    return button
  }()
  
  private let mailStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 10
    stackView.distribution = .fill
    stackView.alignment = .leading
    return stackView
  }()
  
  private let bigPhotoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    return imageView
  }()
  
  private let firstSmallPhotoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    return imageView
  }()
  
  private let secondSmallPhotoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    return imageView
  }()
  
  private let smallPhotosStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private let photosStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 10
    stackView.distribution = .fill
    return stackView
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg, size: 15)
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var routeToSiteButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Перейти на сайт организаии", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIReg, size: 15)
    button.addTarget(self, action: #selector(routeToSiteButtonTapped), for: .touchUpInside)
    button.tintColor = .specialNavBarBGColor
    return button
  }()
  
  private let mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 10
    stackView.axis = .vertical
    stackView.alignment = .top
    stackView.distribution = .fillProportionally
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureView(with model: FullEventDescriptionViewModel) {
    titleLabel.text = model.title
    organizationNameLabel.text = model.organizationName
    adressLabel.text = model.adress
    firstPhoneLabel.text = model.phone1
    secondPhoneLabel.text = model.phone2
    bigPhotoImageView.loadImage(from: model.detailImage1)
    firstSmallPhotoImageView.loadImage(from: model.detailImage2)
    secondSmallPhotoImageView.loadImage(from: model.detailImage3)
    descriptionLabel.text = model.description
    diaryLabel.text = model.diaryString
  }
  
  // MARK: - Objc methods
  @objc
  private func writeUsButtonTapped() {
    print(#function)
  }
  
  @objc
  private func routeToSiteButtonTapped() {
    print(#function)
  }
}

// MARK: - Private methods
private extension FullEventDescriptionMainView {
  func setupView() {
    addSubviews()
    setConstraints()
  }
  
  func addSubviews() {
    diaryStackView.addArrangedSubview(diaryImageView)
    diaryStackView.addArrangedSubview(diaryLabel)
    
    adressStackView.addArrangedSubview(adressImageView)
    adressStackView.addArrangedSubview(adressLabel)
    
    phoneNumbersStackView.addArrangedSubview(firstPhoneLabel)
    phoneNumbersStackView.addArrangedSubview(secondPhoneLabel)
    
    phoneStackView.addArrangedSubview(phoneImageView)
    phoneStackView.addArrangedSubview(phoneNumbersStackView)
    
    mailStackView.addArrangedSubview(mailImageView)
    mailStackView.addArrangedSubview(mailLabel)
    mailStackView.addArrangedSubview(writeUsButton)
    
    smallPhotosStackView.addArrangedSubview(firstSmallPhotoImageView)
    smallPhotosStackView.addArrangedSubview(secondSmallPhotoImageView)
    
    photosStackView.addArrangedSubview(bigPhotoImageView)
    photosStackView.addArrangedSubview(smallPhotosStackView)
    
    mainStackView.addArrangedSubview(titleLabel)
    mainStackView.addArrangedSubview(diaryStackView)
    mainStackView.addArrangedSubview(organizationNameLabel)
    mainStackView.addArrangedSubview(adressStackView)
    mainStackView.addArrangedSubview(phoneStackView)
    mainStackView.addArrangedSubview(mailStackView)
    mainStackView.addArrangedSubview(photosStackView)
    mainStackView.addArrangedSubview(descriptionLabel)
    mainStackView.addArrangedSubview(routeToSiteButton)
    
    myAddSubView(mainStackView)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(equalTo: topAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
}


