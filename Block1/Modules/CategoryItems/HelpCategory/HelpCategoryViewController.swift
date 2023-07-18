//
//  HelpCategoryViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 29.05.2023.
//

import UIKit

protocol HelpCategoryRouterInput {
  func routeToFullEventDescriptionVC(with model: FullEventModel)
}

final class HelpCategoryViewController: CustomVC {
  // MARK: - UI
  private lazy var barButtonItem = UIBarButtonItem(image: UIImage(named: Images.filter), style: .plain, target: self, action: #selector(didTapBarButton))
  
  private lazy var currentEventsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Текущие", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIMed,
                                     size: Constants.currentEventsButtonFontSize
    )
    button.addTarget(self, action: #selector(currentEventsButtonTapped), for: .touchUpInside)
    button.layer.cornerRadius = Constants.currentEventsButtonCorner
    button.backgroundColor = .specialNavBarBGColor
    button.tintColor = .white
    return button
  }()
  
  private lazy var finishedEventsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Завершенные", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIMed,
                                     size: Constants.finishedEventsButtonFontSize
    )
    button.addTarget(self, action: #selector(finishedEventsButtonTapped), for: .touchUpInside)
    button.layer.cornerRadius = Constants.finishedEventsButtonCorner
    button.backgroundColor = .clear
    button.tintColor = .specialNavBarBGColor
    return button
  }()
  
  private let toggleStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Constants.toggleStackBorderWidth
    stackView.distribution = .fillEqually
    stackView.layer.borderWidth = Constants.toggleStackViewSpacing
    stackView.layer.cornerRadius = Constants.toggleStackViewCorner
    stackView.layer.borderColor = UIColor.specialNavBarBGColor.cgColor
    return stackView
  }()
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout
    )
    layout.itemSize = CGSize(width: Constants.cellSizeWidth,
                             height: Constants.cellSizeHeight
    )
    layout.minimumLineSpacing = Constants.sizeBetweenCells
    layout.minimumInteritemSpacing = Constants.sizeBetweenCellsInSameRow
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: Constants.sectionInsetTop,
                                       left: Constants.sectionInsetLeft,
                                       bottom: Constants.sectionInsetBottom,
                                       right: Constants.sectionInsetRight
    )
    collectionView.contentInsetAdjustmentBehavior = .always
    collectionView.bounces = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(HelpCategoryCollectionViewCell.self,
                            forCellWithReuseIdentifier: CellNames.helpCategoryCollectionViewCell
    )
    collectionView.backgroundColor = .specialCollectionViewBGColor
    return collectionView
  }()
  
  // MARK: - Variables
  var viewModel: HelpCategoryViewModel?
  var router: HelpCategoryRouterInput?
  
  private var sortedViewModels: [ShortEventViewModel] = []
  private var navBarTitle = ""
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    navigationItem.rightBarButtonItem = barButtonItem
    viewModel?.viewDidLoad()
    bindViewModel()
    setupNavBarWithBackButton(titleName: navBarTitle)
  }
  
  // MARK: - Objc methods
  @objc
  private func currentEventsButtonTapped() {
    viewModel?.didTapToggleButton(isCurrentEvent: true)
    currentEventsButton.backgroundColor = .specialNavBarBGColor
    currentEventsButton.tintColor = .white
    finishedEventsButton.backgroundColor = .clear
    finishedEventsButton.tintColor = .specialNavBarBGColor
  }
  
  @objc
  private func finishedEventsButtonTapped() {
    viewModel?.didTapToggleButton(isCurrentEvent: false)
    currentEventsButton.backgroundColor = .clear
    currentEventsButton.tintColor = .specialNavBarBGColor
    finishedEventsButton.backgroundColor = .specialNavBarBGColor
    finishedEventsButton.tintColor = .white
  }
  
  @objc
  private func didTapBarButton() {
    print(#function)
  }
}

// MARK: - UICollectionViewDelegate impl
extension HelpCategoryViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let index = indexPath.row
    viewModel?.routeToCategoryItem(index: index)
  }
}

// MARK: - UICollectionViewDataSource impl
extension HelpCategoryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    var cellsCount = 0
    if let models = viewModel?.sortedViewModels.value {
      cellsCount = models.count
    }
    return cellsCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CellNames.helpCategoryCollectionViewCell,
      for: indexPath) as? HelpCategoryCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.layer.cornerRadius = Constants.cellCornerRadius
    if let model = viewModel?.sortedViewModels.value[indexPath.row] {
      cell.configureCell(with: model)
    }
    return cell
  }
}

// MARK: - Private Methods
private extension HelpCategoryViewController {
  func bindViewModel() {
    updateNavBarTitle()
    showSortedEvents()
    routeToFullEventDescriptionVC()
  }
  
  func showSortedEvents() {
    viewModel?.sortedViewModels.bind { [weak self] _ in
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }
  }
  
  func updateNavBarTitle() {
    viewModel?.helpCategoryTitle.bind { title in
      self.navBarTitle = title
    }
  }
  
  func routeToFullEventDescriptionVC() {
    viewModel?.eventDescriptionModel.bind { model in
      guard let model = model else { return }
      self.router?.routeToFullEventDescriptionVC(with: model)
    }
  }
  
  func setupViewController() {
    view.backgroundColor = .white
    addSubviews()
    addConstraints()
  }
  
  func addSubviews() {
    toggleStackView.addArrangedSubview(currentEventsButton)
    toggleStackView.addArrangedSubview(finishedEventsButton)
    view.myAddSubView(toggleStackView)
    view.myAddSubView(collectionView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      toggleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.toggleStackViewTopInset),
      toggleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.toggleStackViewLeadingInset),
      toggleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.toggleStackViewTrailingInset),
      toggleStackView.heightAnchor.constraint(equalToConstant: Constants.toggleStackViewHeight),
      collectionView.topAnchor.constraint(equalTo: toggleStackView.bottomAnchor, constant: Constants.collectionViewBottomTopInset),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  enum Constants {
    static let currentEventsButtonFontSize: CGFloat = 13
    static let currentEventsButtonCorner: CGFloat = 4
    static let finishedEventsButtonFontSize: CGFloat = 13
    static let finishedEventsButtonCorner: CGFloat = 4
    static let toggleStackBorderWidth: CGFloat = 0
    static let toggleStackViewSpacing: CGFloat = 1
    static let toggleStackViewCorner: CGFloat = 4
    static let cellSizeWidth: CGFloat = (UIScreen.main.bounds.width - 24)
    static let cellSizeHeight: CGFloat = 413
    static let sizeBetweenCells: CGFloat = 8
    static let sizeBetweenCellsInSameRow: CGFloat = 0
    static let sectionInsetTop: CGFloat = 8
    static let sectionInsetLeft: CGFloat = 8
    static let sectionInsetBottom: CGFloat = 8
    static let sectionInsetRight: CGFloat = 8
    static let cellCornerRadius: CGFloat = 5
    static let customNavBarTitleFontSize: CGFloat = 21
    static let toggleStackViewTopInset: CGFloat = 10
    static let toggleStackViewLeadingInset: CGFloat = 16
    static let toggleStackViewTrailingInset: CGFloat = -16
    static let toggleStackViewHeight: CGFloat = 24
    static let collectionViewBottomTopInset: CGFloat = 10
  }
}
