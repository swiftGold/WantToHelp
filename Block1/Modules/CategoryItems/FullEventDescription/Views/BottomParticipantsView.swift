//
//  BottomParticipantsView.swift
//  Block1
//
//  Created by Сергей Золотухин on 30.05.2023.
//

import UIKit

final class BottomParticipantsView: UIView {
  // MARK: - UI\
  private let bottomParticipantsView: UIView = {
    let view = UIView()
    view.backgroundColor = .specialCollectionViewBGColor
    return view
  }()
  
  private let photo1ImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  private let photo2ImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  private let photo3ImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  private let photo4ImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  private let photo5ImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  private let bottomPhotosStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = -5
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private let participantCountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIMed, size: 13)
    label.textAlignment = .left
    label.textColor = .specialDiaryLightGreyColor
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureView(with model: FullEventDescriptionViewModel) {
    photo1ImageView.loadImage(from: model.photo1)
    photo2ImageView.loadImage(from: model.photo2)
    photo3ImageView.loadImage(from: model.photo3)
    photo4ImageView.loadImage(from: model.photo4)
    photo5ImageView.loadImage(from: model.photo5)
    let participantsCount = model.participantsCount - 5
    participantCountLabel.text = "+\(participantsCount)"
  }
}

// MARK: - Private methods
private extension BottomParticipantsView {
  func setupView() {
    addSubviews()
    setConstraints()
  }
  
  func addSubviews() {
    bottomPhotosStackView.addArrangedSubview(photo1ImageView)
    bottomPhotosStackView.addArrangedSubview(photo2ImageView)
    bottomPhotosStackView.addArrangedSubview(photo3ImageView)
    bottomPhotosStackView.addArrangedSubview(photo4ImageView)
    bottomPhotosStackView.addArrangedSubview(photo5ImageView)
    
    myAddSubView(bottomParticipantsView)
    bottomParticipantsView.myAddSubView(bottomPhotosStackView)
    bottomParticipantsView.myAddSubView(participantCountLabel)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      bottomParticipantsView.leadingAnchor.constraint(equalTo: leadingAnchor),
      bottomParticipantsView.trailingAnchor.constraint(equalTo: trailingAnchor),
      bottomParticipantsView.bottomAnchor.constraint(equalTo: bottomAnchor),
      bottomParticipantsView.heightAnchor.constraint(equalToConstant: 68),
      
      bottomPhotosStackView.centerYAnchor.constraint(equalTo: bottomParticipantsView.centerYAnchor),
      bottomPhotosStackView.leadingAnchor.constraint(equalTo: bottomParticipantsView.leadingAnchor, constant: 20),
      bottomPhotosStackView.widthAnchor.constraint(equalToConstant: 180),
      bottomPhotosStackView.heightAnchor.constraint(equalToConstant: 36),
      
      participantCountLabel.centerYAnchor.constraint(equalTo: bottomParticipantsView.centerYAnchor),
      participantCountLabel.leadingAnchor.constraint(equalTo: bottomPhotosStackView.trailingAnchor, constant: 10),
    ])
  }
}

