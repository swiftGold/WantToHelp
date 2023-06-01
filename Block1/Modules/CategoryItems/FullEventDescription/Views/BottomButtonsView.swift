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
    label.font = UIFont(name: Fonts.SFUIMed,
                        size: Constants.shirtLabelFontSize
    )
    label.text = "Помочь \n вещами"
    label.textAlignment = .center
    label.textColor = .specialSublabelColor
    label.numberOfLines = Constants.shirtLabelInfinityLines
    return label
  }()
  
  private let shirtStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.shirtStackViewSpacing
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
    label.font = UIFont(name: Fonts.SFUIMed,
                        size: Constants.handsLabelFontSize
    )
    label.text = "Стать \n волонтером"
    label.textAlignment = .center
    label.textColor = .specialSublabelColor
    label.numberOfLines = Constants.handsLabelInfinityLines
    return label
  }()
  
  private let handsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.handsStackViewSpacing
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
    label.font = UIFont(name: Fonts.SFUIMed,
                        size: Constants.toolsLabelFontSize
    )
    label.text = "Проф.\n помощь"
    label.textAlignment = .center
    label.textColor = .specialSublabelColor
    label.numberOfLines = Constants.toolsLabelInfinityLines
    return label
  }()
  
  private let toolsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.toolsStackViewSpacing
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
    label.font = UIFont(name: Fonts.SFUIMed,
                        size: Constants.cashLabelFontSize
    )
    label.text = "Помочь \n деньгами"
    label.textAlignment = .center
    label.textColor = .specialSublabelColor
    label.numberOfLines = Constants.cashLabelInfinityLines
    return label
  }()
  
  private let cashStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.cashStackViewSpacing
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .center
    return stackView
  }()
  
  private let bottomIconsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.bottomIconsStackViewSpacing
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
    stackView.spacing = Constants.bottomButtonsStackViewSpacing
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
      bottomButtonsView.heightAnchor.constraint(equalToConstant: Constants.bottomButtonsViewHeight),
      bottomIconsStackView.centerYAnchor.constraint(equalTo: bottomButtonsView.centerYAnchor),
      bottomIconsStackView.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor),
      bottomIconsStackView.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor),
      bottomButtonsStackView.centerYAnchor.constraint(equalTo: bottomButtonsView.centerYAnchor),
      bottomButtonsStackView.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor),
      bottomButtonsStackView.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor),
      separatorImageView1.centerYAnchor.constraint(equalTo: bottomButtonsView.centerYAnchor),
      separatorImageView1.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor, constant: Constants.separatorImageView1LeadingInset),
      separatorImageView2.centerYAnchor.constraint(equalTo: bottomButtonsView.centerYAnchor),
      separatorImageView2.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor, constant: Constants.separatorImageView2TrailingInset),
      separatorImageView3.centerYAnchor.constraint(equalTo: bottomButtonsView.centerYAnchor),
      separatorImageView3.centerXAnchor.constraint(equalTo: bottomButtonsView.centerXAnchor)
    ])
  }
  
  enum Constants {
    static let shirtLabelFontSize: CGFloat = 10
    static let shirtLabelInfinityLines = 0
    static let shirtStackViewSpacing: CGFloat = 5
    static let handsLabelFontSize: CGFloat = 10
    static let handsLabelInfinityLines = 0
    static let handsStackViewSpacing: CGFloat = 5
    static let toolsLabelFontSize: CGFloat = 10
    static let toolsLabelInfinityLines = 0
    static let toolsStackViewSpacing: CGFloat = 5
    static let cashLabelFontSize: CGFloat = 10
    static let cashLabelInfinityLines = 0
    static let cashStackViewSpacing: CGFloat = 5
    static let bottomIconsStackViewSpacing: CGFloat = 0
    static let bottomButtonsStackViewSpacing: CGFloat = 3
    static let bottomButtonsViewHeight: CGFloat = 70
    static let separatorImageView1LeadingInset: CGFloat = UIScreen.main.bounds.width / 4
    static let separatorImageView2TrailingInset: CGFloat = -(UIScreen.main.bounds.width / 4)
  }
}
