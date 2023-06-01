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
    collectionView.register(ChildsCollectionViewCell.self,
                            forCellWithReuseIdentifier: "ChildsCollectionViewCell"
    )
    collectionView.backgroundColor = .specialCollectionViewBGColor
    return collectionView
  }()
  
  // MARK: - Variables
  private var jsonService = JSONService()
  private let calendarManager = CalendarManager()
  private var eventViewModels: [ShortEventViewModel] = []
  private var sortedViewModels: [ShortEventViewModel] = []
  private var fullDescriptionViewModels: [FullEventDescriptionViewModel] = []
  private var sortedDescriptionViewModels: [FullEventDescriptionViewModel] = []
  private var isCurrent = true
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    setupNavBar()
    fetchDataFromJson()
    isCurrentEvents()
  }
  
  // MARK: - Objc methods
  @objc
  private func currentEventsButtonTapped() {
    isCurrent = true
    isCurrentEvents()
  }
  
  @objc
  private func finishedEventsButtonTapped() {
    isCurrent = false
    isCurrentEvents()
  }
  
  @objc
  private func didTapBarButton() {
    print(#function)
  }
}

// MARK: - UICollectionViewDelegate impl
extension ChildsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let index = indexPath.row
    let viewModel = sortedDescriptionViewModels[index]
    let viewController = FullEventDescriptionVC()
    viewController.configureViewController(with: viewModel)
    navigationController?.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - UICollectionViewDataSource impl
extension ChildsViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sortedViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "ChildsCollectionViewCell",
      for: indexPath) as? ChildsCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.layer.cornerRadius = Constants.cellCornerRadius
    cell.configureCell(with: sortedViewModels[indexPath.row])
    return cell
  }
}

// MARK: - Private Methods
private extension ChildsViewController {
  func fetchDataFromJson() {
    jsonService.fetchFullEventDescriptionFromJSON(completion: { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let response):
        strongSelf.fullDescriptionViewModels = response.map({ model -> FullEventDescriptionViewModel in
          let diaryString = strongSelf.calculateDaysToEvent(with: model).0
          let isFinished = strongSelf.calculateDaysToEvent(with: model).1
          let viewModel = FullEventDescriptionViewModel(title: model.title,
                                                        description: model.description,
                                                        dateStart: model.dateStart,
                                                        dateFinish: model.dateFinish,
                                                        organizationName: model.organizationName,
                                                        adress: model.adress,
                                                        phone1: model.phone1,
                                                        phone2: model.phone2,
                                                        mainImage: model.mainImage,
                                                        detailImage1: model.detailImage1,
                                                        detailImage2: model.detailImage2,
                                                        detailImage3: model.detailImage3,
                                                        photo1: model.photo1,
                                                        photo2: model.photo2,
                                                        photo3: model.photo3,
                                                        photo4: model.photo4,
                                                        photo5: model.photo5,
                                                        participantsCount: model.participantsCount,
                                                        diaryString: diaryString,
                                                        isFinished: isFinished
          )
          return viewModel
        })
      case .failure(let error):
        print(error.localizedDescription)
      }
    })
    collectionView.reloadData()
  }
  
  func mappingToViewModels(with models: [FullEventDescriptionViewModel]) -> [ShortEventViewModel] {
    let viewModels = models.map { model in
      ShortEventViewModel(title: model.title,
                          description: model.description,
                          dateStart: model.dateStart,
                          dateFinish: model.dateFinish,
                          mainImage: model.mainImage,
                          diaryString: model.diaryString,
                          isFinished: model.isFinished
      )
    }
    return viewModels
  }
  
  func calculateDaysToEvent(with model: FullEventDescriptionModel) -> (String, Bool) {
    let startDateString = calendarManager.fetchStringDateFromTimeStamp(ti: model.dateStart)
    let finishDateString = calendarManager.fetchStringDateFromTimeStamp(ti: model.dateFinish)
    let startDate = calendarManager.fetchDateFromTimeStamp(ti: model.dateStart)
    let currentDate = Date()
    let howMuchDaysLeft = calendarManager.howMuchdaysLeft(currentDate: currentDate, eventDate: startDate)
    let eventFinished = calendarManager.fetchFullStringDateFromTimeStamp(ti: model.dateFinish)
    if howMuchDaysLeft >= Constants.zeroDays {
      return ("Осталось: \(howMuchDaysLeft) дней (\(startDateString) - \(finishDateString))", false)
    } else {
      return ("Завершено: " + "\(eventFinished)".firstCharOnly(), true)
    }
  }
  
  func isCurrentEvents() {
    if isCurrent {
      currentEventsButton.backgroundColor = .specialNavBarBGColor
      currentEventsButton.tintColor = .white
      finishedEventsButton.backgroundColor = .clear
      finishedEventsButton.tintColor = .specialNavBarBGColor
      
      fullDescriptionViewModels.forEach { model in
        if !model.isFinished {
          sortedDescriptionViewModels.removeAll()
          sortedDescriptionViewModels.append(model)
          sortedViewModels = mappingToViewModels(with: sortedDescriptionViewModels)
        }
      }
    } else {
      currentEventsButton.backgroundColor = .clear
      currentEventsButton.tintColor = .specialNavBarBGColor
      finishedEventsButton.backgroundColor = .specialNavBarBGColor
      finishedEventsButton.tintColor = .white
      
      fullDescriptionViewModels.forEach { model in
        if model.isFinished {
          sortedDescriptionViewModels.removeAll()
          sortedDescriptionViewModels.append(model)
          sortedViewModels = mappingToViewModels(with: sortedDescriptionViewModels)
        }
      }
    }
    collectionView.reloadData()
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
    label.font = UIFont(name: Fonts.OfficSanExtraBold,
                        size: Constants.customNavBarTitleFontSize
    )
    label.textColor = .white
    navigationItem.titleView = label
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
    static let zeroDays = 0
    static let customNavBarTitleFontSize: CGFloat = 21
    static let toggleStackViewTopInset: CGFloat = 10
    static let toggleStackViewLeadingInset: CGFloat = 16
    static let toggleStackViewTrailingInset: CGFloat = -16
    static let toggleStackViewHeight: CGFloat = 24
    static let collectionViewBottomTopInset: CGFloat = 10
  }
}
