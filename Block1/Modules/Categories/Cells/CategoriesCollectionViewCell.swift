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
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.OfficSanExtraBold,
                        size: Constants.titleLabelFontSize
    )
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
      imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: Constants.imageViewTopInset),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLabelLeadingInset),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.titleLabelTrailingTopInset),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.titleLabelBottomTopInset)
    ])
  }
  
  enum Constants {
    static let titleLabelFontSize: CGFloat = 15
    static let imageViewTopInset: CGFloat = -32
    static let titleLabelLeadingInset: CGFloat = 20
    static let titleLabelTrailingTopInset: CGFloat = -20
    static let titleLabelBottomTopInset: CGFloat = -14
  }
}
