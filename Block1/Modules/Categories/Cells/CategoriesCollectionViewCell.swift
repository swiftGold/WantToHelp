//
//  CategoriesCollectionViewCell.swift
//  Block1
//
//  Created by Сергей Золотухин on 26.05.2023.
//

import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
  // MARK: - UI
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
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
    imageView.image = UIImage(named: model.image)
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
    addSubview(imageView)
    addSubview(titleLabel)
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
