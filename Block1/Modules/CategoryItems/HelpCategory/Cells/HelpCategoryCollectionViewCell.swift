//
//  HelpCategoryCollectionViewCell.swift
//  Block1
//
//  Created by Сергей Золотухин on 29.05.2023.
//

import UIKit

final class HelpCategoryCollectionViewCell: UICollectionViewCell {
  // MARK: - UI
  private let mainImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    return imageView
  }()
  
  private let shapeFormImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.shapeForm)
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.OfficSanExtraBold,
                        size: Constants.titleLabelFontSize
    )
    label.textAlignment = .center
    label.textColor = .specialTitleColor
    label.numberOfLines = Constants.titleLabelInfinityLines
    return label
  }()
  
  private let separatorImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.heartSeparator)
    return imageView
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.descriptionLabelFontSize
    )
    label.textAlignment = .center
    label.textColor = .specialDescriptionColor
    label.numberOfLines = Constants.descriptionLabelThreeLines
    return label
  }()
  
  private let bottomView: UIView = {
    let view = UIView()
    view.backgroundColor = .specialNavBarBGColor
    view.layer.cornerRadius = Constants.bottomViewCornerRadius
    view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    return view
  }()
  
  private let diaryImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.diary)
    return imageView
  }()
  
  private let diaryLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIMed,
                        size: Constants.diaryLabelFontSize
    )
    label.textAlignment = .left
    label.textColor = .white
    return label
  }()
  
  private let diaryStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.diaryStackViewSpacing
    stackView.distribution = .fill
    stackView.alignment = .center
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  func configureCell(with model: ShortEventViewModel) {
    guard let image = model.mainImage else { return }
    mainImageView.loadImage(from: image)
    titleLabel.text = model.title
    descriptionLabel.text = model.description
    diaryLabel.text = model.diaryString
  }
}

// MARK: - Private methods
private extension HelpCategoryCollectionViewCell {
  func setupCell() {
    backgroundColor = .white
    addSubviews()
    setConstraints()
  }
  
  func addSubviews() {
    diaryStackView.addArrangedSubview(diaryImageView)
    diaryStackView.addArrangedSubview(diaryLabel)
    myAddSubView(mainImageView)
    mainImageView.myAddSubView(shapeFormImageView)
    myAddSubView(titleLabel)
    myAddSubView(separatorImageView)
    myAddSubView(descriptionLabel)
    myAddSubView(bottomView)
    bottomView.myAddSubView(diaryStackView)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.mainImageViewTopInset),
      mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.mainImageViewLeadingInset),
      mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.mainImageViewTrailingInset),
      mainImageView.heightAnchor.constraint(equalToConstant: Constants.mainImageViewHeight),
      shapeFormImageView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
      shapeFormImageView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor),
      shapeFormImageView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor),
      titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLabelLeadingInset),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.titleLabelTrailingInset),
      separatorImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.titleLabelTopInset),
      separatorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      separatorImageView.heightAnchor.constraint(equalToConstant: Constants.separatorImageViewHeight),
      descriptionLabel.topAnchor.constraint(equalTo: separatorImageView.bottomAnchor, constant: Constants.descriptionLabelTopInset),
      descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.descriptionLabelLeadingInset),
      descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.descriptionLabelTrailingInset),
      bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
      bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
      bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
      bottomView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight),
      diaryStackView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
      diaryStackView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor)
    ])
  }
  
  enum Constants {
    static let titleLabelFontSize: CGFloat = 21
    static let titleLabelInfinityLines = 0
    static let descriptionLabelFontSize: CGFloat = 15
    static let descriptionLabelThreeLines = 3
    static let bottomViewCornerRadius: CGFloat = 5
    static let diaryLabelFontSize: CGFloat = 11
    static let diaryStackViewSpacing: CGFloat = 10
    static let mainImageViewTopInset: CGFloat = 4
    static let mainImageViewLeadingInset: CGFloat = 4
    static let mainImageViewTrailingInset: CGFloat = -4
    static let mainImageViewHeight: CGFloat = 231
    static let titleLabelLeadingInset: CGFloat = 45
    static let titleLabelTrailingInset: CGFloat = -45
    static let titleLabelTopInset: CGFloat = 8
    static let separatorImageViewHeight: CGFloat = 20
    static let descriptionLabelTopInset: CGFloat = 8
    static let descriptionLabelLeadingInset: CGFloat = 24
    static let descriptionLabelTrailingInset: CGFloat = -24
    static let bottomViewHeight: CGFloat = 31
  }
}
