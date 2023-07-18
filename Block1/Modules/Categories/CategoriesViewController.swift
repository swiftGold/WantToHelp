//
//  ViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 25.05.2023.
//

import UIKit

protocol CategoriesRouterInput: AnyObject {
  func routeToHelpCategory(with model: HelpCategoryModel)
}

final class CategoriesViewController: CustomVC {
  // MARK: - UI
  private lazy var barButtonItem = UIBarButtonItem(
    image: UIImage(named: Images.tabBarBackButton),
    style: .plain, target: self, action: #selector(didTapBarButton)
  )
  
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
    collectionView.register(CategoriesCollectionViewCell.self,
                            forCellWithReuseIdentifier: CellNames.categoriesCollectionViewCell
    )
    return collectionView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.SFUIReg,
                        size: Constants.titleLabelFontSize
    )
    label.text = "Выберите категорию помощи"
    label.textAlignment = .center
    label.textColor = .specialTitleGreyColor
    return label
  }()
  
  // MARK: - Variables
  var viewModel: CategoriesViewModel?
  var router: CategoriesRouterInput?
  private var categoryTitle = ""
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = false
    navigationItem.leftBarButtonItem = barButtonItem
    setupNavBar(titleName: TabBarNames.categories)
    setupViewController()
    showCategories()
    bindViewModel()
  }
  
  // MARK: - Objc methods
  @objc
  private func didTapBarButton() {
    print(#function)
  }
}

// MARK: - UICollectionViewDelegate impl
extension CategoriesViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let index = indexPath.row
    viewModel?.fetchCategoryTitle(with: index)
    guard let title = viewModel?.helpCategoryTitle.value else { return }
    let model = HelpCategoryModel(title: title,
                                  id: index
    )
    router?.routeToHelpCategory(with: model)
  }
}

// MARK: - UICollectionViewDataSource impl
extension CategoriesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    var modelsCount = 0
    if let cells = viewModel?.categoriesModel.value.count {
      modelsCount = cells
    }
    return modelsCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CellNames.categoriesCollectionViewCell,
      for: indexPath) as? CategoriesCollectionViewCell else {
      return UICollectionViewCell()
    }
    if let model = viewModel?.categoriesModel.value {
      cell.configureCell(with: model[indexPath.row])
    }
    return cell
  }
}

// MARK: - Private Methods
private extension CategoriesViewController {
  func bindViewModel() {
    viewModel?.categoriesModel.bind { [weak self] _ in
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }
    
    viewModel?.helpCategoryTitle.bind { title in
      self.categoryTitle = title
    }
  }
  
  func showCategories() {
    viewModel?.viewDidLoad()
  }
  
  func setupViewController() {
    view.backgroundColor = .white
    addSubviews()
    addConstraints()
  }
  
  func addSubviews() {
    view.myAddSubView(collectionView)
    view.myAddSubView(titleLabel)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleLabelTopInset),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.collectionViewBottomInset),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  enum Constants {
    static let customNavBarTitleFontSize: CGFloat = 21
    static let cellSizeWidth: CGFloat = (UIScreen.main.bounds.width - 27) / 2
    static let cellSizeHeight: CGFloat = 160
    static let sizeBetweenCells: CGFloat = 9
    static let sizeBetweenCellsInSameRow: CGFloat = 0
    static let sectionInsetTop: CGFloat = 9
    static let sectionInsetLeft: CGFloat = 9
    static let sectionInsetBottom: CGFloat = 9
    static let sectionInsetRight: CGFloat = 9
    static let titleLabelFontSize: CGFloat = 17
    static let titleLabelTopInset: CGFloat = 20
    static let collectionViewBottomInset: CGFloat = 8
  }
}
