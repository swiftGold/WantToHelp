//
//  BottomButtonsView.swift
//  Block1
//
//  Created by Сергей Золотухин on 30.05.2023.
//

import UIKit

final class BottomButtonsView: UIView {
  // MARK: - UI
  private let bottomButtonsView: UIView = {
    let view = UIView()
    view.backgroundColor = .specialBottomViewColor
    return view
  }()
  
  private let shirtImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.shirt)?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = .specialNavBarBGColor
    return imageView
  }()
  
  private let shirtLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIMed, size: 10)
    label.text = "Помочь \n вещами"
    label.textAlignment = .center
    label.textColor = .specialSublabelColor
    label.numberOfLines = 0
    return label
  }()
  
  private let shirtStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 5
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .center
    return stackView
  }()
  
  private let handsImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.hands)?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = .specialNavBarBGColor
    return imageView
  }()
  
  private let handsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIMed, size: 10)
    label.text = "Стать \n волонтером"
    label.textAlignment = .center
    label.textColor = .specialSublabelColor
    label.numberOfLines = 0
    return label
  }()
  
  private let handsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 5
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .center
    return stackView
  }()
  
  private let toolsImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.tools)?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = .specialNavBarBGColor
    return imageView
  }()
  
  private let toolsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIMed, size: 10)
    label.text = "Проф.\n помощь"
    label.textAlignment = .center
    label.textColor = .specialSublabelColor
    label.numberOfLines = 0
    return label
  }()
  
  private let toolsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 5
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .center
    return stackView
  }()
  
  private let cashImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.coins)?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = .specialNavBarBGColor
    return imageView
  }()
  
  private let cashLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIMed, size: 10)
    label.text = "Помочь \n деньгами"
    label.textAlignment = .center
    label.textColor = .specialSublabelColor
    label.numberOfLines = 0
    return label
  }()
  
  private let cashStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 5
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .center
    return stackView
  }()
  
  private let bottomIconsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 0
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private lazy var shirtButton: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(shirtButtonTapped), for: .touchUpInside)
    button.backgroundColor = .clear
    return button
  }()
  
  private lazy var handsButton: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(handsButtonTapped), for: .touchUpInside)
    button.backgroundColor = .clear
    return button
  }()
  
  private lazy var toolsButton: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(toolsButtonTapped), for: .touchUpInside)
    button.backgroundColor = .clear
    return button
  }()
  
  private lazy var cashButton: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(cashButtonTapped), for: .touchUpInside)
    button.backgroundColor = .clear
    return button
  }()
  
  private let bottomButtonsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 3
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private let separatorImageView1: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.verticalSeparator)
    return imageView
  }()
  
  private let separatorImageView2: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.verticalSeparator)
    return imageView
  }()
  
  private let separatorImageView3: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: Images.verticalSeparator)
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Objc methods
  @objc
  private func shirtButtonTapped() {
    print(#function)
  }
  
  @objc
  private func handsButtonTapped() {
    print(#function)
  }
  
  @objc
  private func toolsButtonTapped() {
    print(#function)
  }
  
  @objc
  private func cashButtonTapped() {
    print(#function)
  }
}

// MARK: - Private methods
private extension BottomButtonsView {
  func setupView() {
    addSubviews()
    setConstraints()
  }
  
  func addSubviews() {
    shirtStackView.addArrangedSubview(shirtImageView)
    shirtStackView.addArrangedSubview(shirtLabel)
    
    handsStackView.addArrangedSubview(handsImageView)
    handsStackView.addArrangedSubview(handsLabel)
    
    toolsStackView.addArrangedSubview(toolsImageView)
    toolsStackView.addArrangedSubview(toolsLabel)
    
    cashStackView.addArrangedSubview(cashImageView)
    cashStackView.addArrangedSubview(cashLabel)
    
    bottomIconsStackView.addArrangedSubview(shirtStackView)
    bottomIconsStackView.addArrangedSubview(handsStackView)
    bottomIconsStackView.addArrangedSubview(toolsStackView)
    bottomIconsStackView.addArrangedSubview(cashStackView)
    
    bottomButtonsStackView.addArrangedSubview(shirtButton)
    bottomButtonsStackView.addArrangedSubview(handsButton)
    bottomButtonsStackView.addArrangedSubview(toolsButton)
    bottomButtonsStackView.addArrangedSubview(cashButton)
    
    myAddSubView(bottomButtonsView)
    bottomButtonsView.myAddSubView(bottomIconsStackView)
    bottomButtonsView.myAddSubView(bottomButtonsStackView)
    bottomButtonsView.myAddSubView(separatorImageView1)
    bottomButtonsView.myAddSubView(separatorImageView2)
    bottomButtonsView.myAddSubView(separatorImageView3)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      bottomButtonsView.leadingAnchor.constraint(equalTo: leadingAnchor),
      bottomButtonsView.trailingAnchor.constraint(equalTo: trailingAnchor),
      bottomButtonsView.bottomAnchor.constraint(equalTo: bottomAnchor),
      bottomButtonsView.heightAnchor.constraint(equalToConstant: 70),
      
      bottomIconsStackView.centerYAnchor.constraint(equalTo: bottomButtonsView.centerYAnchor),
      bottomIconsStackView.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor),
      bottomIconsStackView.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor),
      
      bottomButtonsStackView.centerYAnchor.constraint(equalTo: bottomButtonsView.centerYAnchor),
      bottomButtonsStackView.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor),
      bottomButtonsStackView.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor),
      
      separatorImageView1.centerYAnchor.constraint(equalTo: bottomButtonsView.centerYAnchor),
      separatorImageView1.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor, constant: UIScreen.main.bounds.width / 4),
      
      separatorImageView2.centerYAnchor.constraint(equalTo: bottomButtonsView.centerYAnchor),
      separatorImageView2.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor, constant: -(UIScreen.main.bounds.width / 4)),
      
      separatorImageView3.centerYAnchor.constraint(equalTo: bottomButtonsView.centerYAnchor),
      separatorImageView3.centerXAnchor.constraint(equalTo: bottomButtonsView.centerXAnchor)
    ])
  }
}
