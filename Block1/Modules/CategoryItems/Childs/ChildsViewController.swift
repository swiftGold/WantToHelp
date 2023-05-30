//
//  ChildsViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 29.05.2023.
//

import UIKit

class ChildsViewController: UIViewController {
  //MARK: - UI
  private lazy var barButtonItem = UIBarButtonItem(image: UIImage(named: Images.filter), style: .plain, target: self, action: #selector(didTapBarButton))
  
  private lazy var currentEventsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Текущие", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIMed, size: 13)
    button.addTarget(self, action: #selector(currentEventsButtonTapped), for: .touchUpInside)
    button.layer.cornerRadius = 4
    button.backgroundColor = .specialNavBarBGColor
    button.tintColor = .white
    return button
  }()
  
  private lazy var finishedEventsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Завершенные", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.SFUIMed, size: 13)
    button.addTarget(self, action: #selector(finishedEventsButtonTapped), for: .touchUpInside)
    button.layer.cornerRadius = 4
    button.backgroundColor = .clear
    button.tintColor = .specialNavBarBGColor
    return button
  }()
  
  private let toggleStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 0
    stackView.distribution = .fillEqually
    stackView.layer.borderWidth = 1
    stackView.layer.cornerRadius = 4
    stackView.layer.borderColor = UIColor.specialNavBarBGColor.cgColor
    return stackView
  }()
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout
    )
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 24,
                             height: 413
    )
    layout.minimumLineSpacing = 8
    layout.minimumInteritemSpacing = 0
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    collectionView.contentInsetAdjustmentBehavior = .always
    collectionView.bounces = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(ChildsCollectionViewCell.self,
                            forCellWithReuseIdentifier: "ChildsCollectionViewCell"
    )
    collectionView.backgroundColor = .specialCollectionViewBGColor
    return collectionView
  }()
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    setupNavBar()
  }
  
  // MARK: - Objc methods
  @objc
  private func currentEventsButtonTapped() {
    currentEventsButton.backgroundColor = .specialNavBarBGColor
    currentEventsButton.tintColor = .white
    finishedEventsButton.backgroundColor = .clear
    finishedEventsButton.tintColor = .specialNavBarBGColor
  }
  
  @objc
  private func finishedEventsButtonTapped() {
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
extension ChildsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let viewController = FullEventDescriptionVC()
    navigationController?.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - UICollectionViewDataSource impl
extension ChildsViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "ChildsCollectionViewCell",
      for: indexPath) as? ChildsCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.layer.cornerRadius = 5
    return cell
  }
}

// MARK: - Private Methods
private extension ChildsViewController {
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
      toggleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      toggleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      toggleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      toggleStackView.heightAnchor.constraint(equalToConstant: 24),
      
      collectionView.topAnchor.constraint(equalTo: toggleStackView.bottomAnchor, constant: 10),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  func setupNavBar() {
    customNavBarTitle()
    navigationItem.rightBarButtonItem = barButtonItem
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor.specialNavBarBGColor
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  func customNavBarTitle() {
    let label = UILabel()
    label.text = TabBarNames.childs
    label.font = UIFont(name: Fonts.OfficSanExtraBold, size: 21)
    label.textColor = .white
    navigationItem.titleView = label
  }
}




