//
//  FullEventDescriptionMainView.swift
//  Block1
//
//  Created by Сергей Золотухин on 30.05.2023.
//

import UIKit

protocol FullEventDescriptionMainViewDelegate: AnyObject {
  func didTapWriteUsButton()
  func didTapRouteToSiteButton()
}

final class FullEventDescriptionMainView: UIView {
  // MARK: - UI
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.OfficSanExtraBold,
                        size: Constants.titleLabelFontSize
    )
    label.textAlignment = .left
    label.textColor = .specialTitleColor
    label.numberOfLines = Constants.titleLabelInfinityLines
    return label
  }()
  
  private let diaryImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.greyDiary)
    return imageView
  }()
  
  private let diaryLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIMed,
                        size: Constants.diaryLabelFontSize
    )
    label.textAlignment = .left
    label.textColor = .specialDiaryLightGreyColor
    return label
  }()
  
  private let diaryStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.diaryStackViewSpacing
    stackView.distribution = .fill
    stackView.alignment = .leading
    return stackView
  }()
  
  private let organizationNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.organizationNameLabelFontSize
    )
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    label.numberOfLines = Constants.organizationNameLabelInfinityLines
    return label
  }()
  
  private let adressLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.adressLabelFontSize
    )
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    label.numberOfLines = Constants.adressLabelInfinityLines
    return label
  }()
  
  private let adressImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.nav)
    return imageView
  }()
  
  private let adressStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.adressStackViewSpacing
    stackView.distribution = .fill
    stackView.alignment = .leading
    return stackView
  }()
  
  private let firstPhoneLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.firstPhoneLabelFontSize
    )
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    return label
  }()
  
  private let secondPhoneLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.secondPhoneLabelFontSize
    )
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    return label
  }()
  
  private let phoneNumbersStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = Constants.phoneNumbersStackViewSpacing
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
    stackView.spacing = Constants.phoneStackViewSpacing
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
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.mailLabelFontSize
    )
    label.text = "У вас есть вопросы?"
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    return label
  }()
  
  private lazy var writeUsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Напишите нам", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIReg,
                                     size: Constants.writeUsButtonFontSize
    )
    button.addTarget(self, action: #selector(writeUsButtonTapped), for: .touchUpInside)
    button.tintColor = .specialNavBarBGColor
    return button
  }()
  
  private let mailStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.mailStackViewSpacing
    stackView.distribution = .fill
    stackView.alignment = .center
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
    stackView.spacing = Constants.smallPhotosStackViewSpacing
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private let photosStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.photosStackViewSpacing
    stackView.distribution = .fill
    return stackView
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.descriptionLabelFontSize
    )
    label.textAlignment = .left
    label.textColor = .specialTitleGreyColor
    label.numberOfLines = Constants.descriptionLabelInfinityLines
    return label
  }()
  
  private lazy var routeToSiteButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Перейти на сайт организаии", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIReg,
                                     size: Constants.routeToSiteButtonFontSize
    )
    button.addTarget(self, action: #selector(routeToSiteButtonTapped), for: .touchUpInside)
    button.tintColor = .specialNavBarBGColor
    return button
  }()
  
  private let mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.mainStackViewSpacing
    stackView.axis = .vertical
    stackView.alignment = .top
    stackView.distribution = .fillProportionally
    return stackView
  }()
  
  // MARK: - Delegate
  weak var delegate: FullEventDescriptionMainViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureView(with model: MainViewModel) {
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
    delegate?.didTapWriteUsButton()
  }
  
  @objc
  private func routeToSiteButtonTapped() {
    print(#function)
    delegate?.didTapRouteToSiteButton()
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
      smallPhotosStackView.widthAnchor.constraint(equalToConstant: Constants.smallPhotosStackViewWidth),
      photosStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      photosStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      photosStackView.heightAnchor.constraint(equalToConstant: Constants.photosStackViewHeight)
    ])
  }
  
  enum Constants {
    static let titleLabelFontSize: CGFloat = 21
    static let titleLabelInfinityLines = 0
    static let diaryLabelFontSize: CGFloat = 11
    static let diaryStackViewSpacing: CGFloat = 10
    static let organizationNameLabelFontSize: CGFloat = 11
    static let organizationNameLabelInfinityLines = 0
    static let adressLabelFontSize: CGFloat = 15
    static let adressLabelInfinityLines = 0
    static let adressStackViewSpacing: CGFloat = 10
    static let firstPhoneLabelFontSize: CGFloat = 15
    static let secondPhoneLabelFontSize: CGFloat = 15
    static let phoneNumbersStackViewSpacing: CGFloat = 3
    static let phoneStackViewSpacing: CGFloat = 10
    static let mailLabelFontSize: CGFloat = 15
    static let writeUsButtonFontSize: CGFloat = 15
    static let mailStackViewSpacing: CGFloat = 10
    static let smallPhotosStackViewSpacing: CGFloat = 10
    static let photosStackViewSpacing: CGFloat = 10
    static let descriptionLabelFontSize: CGFloat = 15
    static let routeToSiteButtonFontSize: CGFloat = 15
    static let descriptionLabelInfinityLines = 0
    static let mainStackViewSpacing: CGFloat = 10
    static let smallPhotosStackViewWidth: CGFloat = 103
    static let photosStackViewHeight: CGFloat = 168
  }
}
