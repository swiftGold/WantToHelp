//
//  ViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 25.05.2023.
//

import UIKit

protocol CategoriesViewControllerProtocol: AnyObject {
  func setupCollectionView(with models: [CategoryModel])
  func routeToVC(with viewController: UIViewController)
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
                            forCellWithReuseIdentifier: "CategoriesCollectionViewCell"
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
  var presenter: CategoriesPresenterProtocol?
  private var categoriesModel: [CategoryModel] = []
  private let CategoryViewsControllers = [
    ChildsViewController(),
    AdultViewController(),
    ElderlyViewController(),
    AnimalsViewController(),
    EventsViewController()
  ]
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    //    LoadingOverlay.shared.showOverlay(view: self.view)
    navigationController?.isNavigationBarHidden = false
    navigationItem.leftBarButtonItem = barButtonItem
    setupNavBar(titleName: TabBarNames.categories)
    setupViewController()
    presenter?.viewDidLoad()
  }
  
  // MARK: - Objc methods
  @objc
  private func didTapBarButton() {
    exit(0)
  }
}

// MARK: - CategoriesViewControllerProtocol impl
extension CategoriesViewController: CategoriesViewControllerProtocol {
  func routeToVC(with viewController: UIViewController) {
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  func setupCollectionView(with models: [CategoryModel]) {
    categoriesModel = models
    collectionView.reloadData()
  }
}

// MARK: - UICollectionViewDelegate impl
extension CategoriesViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let index = indexPath.row
    presenter?.routeToCategoryItem(index: index)
  }
}

// MARK: - UICollectionViewDataSource impl
extension CategoriesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    categoriesModel.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "CategoriesCollectionViewCell",
      for: indexPath) as? CategoriesCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.configureCell(with: categoriesModel[indexPath.row])
    return cell
  }
}

// MARK: - Private Methods
private extension CategoriesViewController {
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
