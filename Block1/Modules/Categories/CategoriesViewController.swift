//
//  ViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 25.05.2023.
//

import UIKit

final class CategoriesViewController: UIViewController {
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
    layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 27) / 2,
                             height: 160
    )
    layout.minimumLineSpacing = 9
    layout.minimumInteritemSpacing = 0
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
    collectionView.contentInsetAdjustmentBehavior = .always
    collectionView.bounces = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsVerticalScrollIndicator = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(CategoriesCollectionViewCell.self,
                            forCellWithReuseIdentifier: "CategoriesCollectionViewCell"
    )
    return collectionView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: Fonts.SFUIReg, size: 17)
    label.text = "Выберите категорию помощи"
    label.textAlignment = .center
    label.textColor = .specialTitleGreyColor
    return label
  }()
  
  // MARK: - Variables
  private var categoriesModel: [CategoryModel] = []
  private let categoriesArray: [(String, String)] = [
    (Images.childrens, "Дети"),
    (Images.adult, "Взрослые"),
    (Images.elderly, "Пожилые"),
    (Images.animals, "Животные"),
    (Images.events, "Мероприятия")
  ]
  
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
    navigationController?.isNavigationBarHidden = false
    setupNavBar()
    setupViewController()
    arrayMapping()
  }
  
  // MARK: - Objc methods
  @objc
  private func didTapBarButton() {
    exit(0)
  }
}

// MARK: - UICollectionViewDelegate impl
extension CategoriesViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let index = indexPath.row
    let viewController = CategoryViewsControllers[index]
    navigationController?.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - UICollectionViewDataSource impl
extension CategoriesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categoriesModel.count
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
  func setupNavBar() {
    customNavBarTitle()
    navigationItem.leftBarButtonItem = barButtonItem
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor.specialNavBarBGColor
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
  }
  
  func arrayMapping() {
    categoriesModel = categoriesArray.map {
      CategoryModel(image: $0.0, title: $0.1)
    }
  }
  
  func customNavBarTitle() {
    let label = UILabel()
    label.text = TabBarNames.categories
    label.font = UIFont(name: Fonts.OfficSanExtraBold, size: 21)
    label.textColor = .white
    navigationItem.titleView = label
  }
  
  func setupViewController() {
    view.backgroundColor = .white
    addSubviews()
    addConstraints()
  }
  
  func addSubviews() {
    view.addSubview(collectionView)
    view.addSubview(titleLabel)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
