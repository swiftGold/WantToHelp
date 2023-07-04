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
    stackView.spacing = Constants.bottomPhotosStackViewSpacing
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private let participantCountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIMed,
                        size: Constants.participantCountLabelFontSize
    )
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
  
  func configureView(with model: ParticipantsViewModel) {
    guard let image1 = model.photo1,
          let image2 = model.photo2,
          let image3 = model.photo3,
          let image4 = model.photo4,
          let image5 = model.photo5 else {
      return
    }
    
    print(image1)
    print(image2)
    print(image3)
    print(image4)
    print(image5)

    photo1ImageView.loadImage(from: image1)
    photo2ImageView.loadImage(from: image2)
    photo3ImageView.loadImage(from: image3)
    photo4ImageView.loadImage(from: image4)
    photo5ImageView.loadImage(from: image5)
    let participantsCount = model.participantsCount - Constants.numberOfParticipantsInImages
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
      bottomParticipantsView.heightAnchor.constraint(equalToConstant: Constants.bottomParticipantsViewHeight),
      bottomPhotosStackView.centerYAnchor.constraint(equalTo: bottomParticipantsView.centerYAnchor),
      bottomPhotosStackView.leadingAnchor.constraint(equalTo: bottomParticipantsView.leadingAnchor, constant: Constants.bottomPhotosStackViewLeadingInset),
      bottomPhotosStackView.widthAnchor.constraint(equalToConstant: Constants.bottomPhotosStackViewWidth),
      bottomPhotosStackView.heightAnchor.constraint(equalToConstant: Constants.bottomPhotosStackViewHeight),
      participantCountLabel.centerYAnchor.constraint(equalTo: bottomParticipantsView.centerYAnchor),
      participantCountLabel.leadingAnchor.constraint(equalTo: bottomPhotosStackView.trailingAnchor, constant: Constants.participantCountLabelLeadingInset),
    ])
  }
  
  enum Constants {
    static let participantCountLabelFontSize: CGFloat = 13
    static let bottomPhotosStackViewSpacing: CGFloat = -5
    static let numberOfParticipantsInImages = 5
    static let bottomParticipantsViewHeight: CGFloat = 68
    static let bottomPhotosStackViewLeadingInset: CGFloat = 20
    static let bottomPhotosStackViewWidth: CGFloat = 180
    static let bottomPhotosStackViewHeight: CGFloat = 36
    static let participantCountLabelLeadingInset: CGFloat = 10
  }
}
