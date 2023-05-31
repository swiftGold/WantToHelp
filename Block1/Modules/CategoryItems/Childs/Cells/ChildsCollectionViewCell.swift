//
//  ChildsCollectionViewCell.swift
//  Block1
//
//  Created by Сергей Золотухин on 29.05.2023.
//

import UIKit

final class ChildsCollectionViewCell: UICollectionViewCell {
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
    label.font = UIFont(name: Fonts.OfficSanExtraBold, size: 21)
    label.textAlignment = .center
    label.textColor = .specialTitleColor
    label.numberOfLines = 0
    return label
  }()
  
  private let separatorImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.heartSeparator)
    return imageView
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg, size: 15)
    label.textAlignment = .center
    label.textColor = .specialDescriptionColor
    label.numberOfLines = 3
    return label
  }()
  
  private let bottomView: UIView = {
    let view = UIView()
    view.backgroundColor = .specialNavBarBGColor
    view.layer.cornerRadius = 5
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
    label.font = UIFont(name: Fonts.SFUIMed, size: 11)
    label.textAlignment = .left
    label.textColor = .white
    return label
  }()
  
  private let diaryStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 10
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
    mainImageView.loadImage(from: model.mainImage)
    titleLabel.text = model.title
    descriptionLabel.text = model.description
    diaryLabel.text = model.diaryString
  }
}

// MARK: - Private methods
private extension ChildsCollectionViewCell {
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
      mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
      mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
      mainImageView.heightAnchor.constraint(equalToConstant: 231),
      
      shapeFormImageView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
      shapeFormImageView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor),
      shapeFormImageView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor),
      
      titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45),
      
      separatorImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      separatorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      separatorImageView.heightAnchor.constraint(equalToConstant: 20),
      
      descriptionLabel.topAnchor.constraint(equalTo: separatorImageView.bottomAnchor, constant: 8),
      descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      
      bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
      bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
      bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
      bottomView.heightAnchor.constraint(equalToConstant: 31),
      
      diaryStackView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
      diaryStackView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor)
    ])
  }
}
