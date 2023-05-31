//
//  CategoriesCollectionViewCell.swift
//  Block1
//
//  Created by Сергей Золотухин on 26.05.2023.
//

import UIKit
import Kingfisher

final class CategoriesCollectionViewCell: UICollectionViewCell {
  // MARK: - UI
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.OfficSanExtraBold, size: 15)
    label.textAlignment = .center
    label.textColor = .specialGreenColor
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  func configureCell(with model: CategoryModel) {
    imageView.loadImage(from: model.image)
    titleLabel.text = model.title
  }
  
  func configurePlaceholder() {
    imageView.image = UIImage(named: Images.placeHolder)
  }
}

// MARK: - Private methods
private extension CategoriesCollectionViewCell {
  func setupCell() {
    backgroundColor = .specialLightGreenBGColor
    addSubviews()
    setConstraints()
  }
  
  func addSubviews() {
    myAddSubView(imageView)
    myAddSubView(titleLabel)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -32),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14)
    ])
  }
}
