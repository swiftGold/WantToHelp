//
//  HelpCategoryPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 04.06.2023.
//

import Foundation

protocol HelpCategoryPresenterProtocol {
  func viewDidLoad()
  func routeToCategoryItem(index: Int)
  func didTapToggleButton(isCurrentEvent: Bool)
}

final class HelpCategoryPresenter {
  weak var viewController: HelpCategoryViewControllerProtocol?
  private var sortedViewModels: [ShortEventViewModel] = []
  private var fullEventDescriptionModels: [FullEventDescriptionModel] = []
  private var filtredFullEventDescriptionModels: [FullEventDescriptionModel] = []
  private var fullDescriptionViewModels: [FullEventDescriptionViewModel] = []
  private var sortedDescriptionViewModels: [FullEventDescriptionViewModel] = []
  private var isCurrent = true
  private let router: Router
  private let moduleBuilder: ModuleBuilderProtocol
  private let calendarManager: CalendarManagerProtocol
  private var categoryIndex: Int
  private var categoryTitle: String
  
  init(
    router: Router,
    moduleBuilder: ModuleBuilderProtocol,
    calendarManager: CalendarManagerProtocol,
    categoryIndex: Int,
    categoryTitle: String
  ) {
    self.router = router
    self.moduleBuilder = moduleBuilder
    self.calendarManager = calendarManager
    self.categoryIndex = categoryIndex
    self.categoryTitle = categoryTitle
  }
}

extension HelpCategoryPresenter: HelpCategoryPresenterProtocol {
  func viewDidLoad() {
    DispatchQueue.global(qos: .background).async { [weak self] in
      guard let strongSelf = self else { return }
      let group = DispatchGroup()
      group.enter()
      strongSelf.fetchDataFromCoreData()
      group.leave()
      
      group.wait()
      
      group.enter()
      strongSelf.mappingToDescriptionViewModel()
      group.leave()
      
      group.notify(queue: DispatchQueue.main) {
        strongSelf.self.didTapToggleButton(isCurrentEvent: true)
      }
    }
    viewController?.setTitle(with: categoryTitle)
  }
  
  func routeToCategoryItem(index: Int) {
    let viewModel = sortedDescriptionViewModels[index]
    let VC = moduleBuilder.buildFullEventDescriptionViewController(with: viewModel)
    viewController?.routeToVC(to: VC)
  }
  
  func didTapToggleButton(isCurrentEvent: Bool) {
    if isCurrentEvent {
      fullDescriptionViewModels.forEach { model in
        if !model.isFinished {
          sortedDescriptionViewModels.removeAll()
          sortedDescriptionViewModels.append(model)
          sortedViewModels = mappingToViewModels(with: sortedDescriptionViewModels)
        }
      }
    } else {
      fullDescriptionViewModels.forEach { model in
        if model.isFinished {
          sortedDescriptionViewModels.removeAll()
          sortedDescriptionViewModels.append(model)
          sortedViewModels = mappingToViewModels(with: sortedDescriptionViewModels)
        }
      }
    }
    viewController?.showSortedEvents(with: sortedViewModels)
  }
}

private extension HelpCategoryPresenter {
  func fetchDataFromCoreData() {
    let coreDataModels = CoreDataManager.instance.fetchDescriptions()
    fullEventDescriptionModels = coreDataModels.map { model -> FullEventDescriptionModel in
      return FullEventDescriptionModel(category_id: Int(model.category_id),
                                       title: model.title,
                                       description: model.descr,
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
                                       participantsCount: Int(model.participantsCount)
      )
    }
    filterEventsByCategoryIndex(with: fullEventDescriptionModels)
  }
  
  func filterEventsByCategoryIndex(with models: [FullEventDescriptionModel]) {
    models.forEach { elem in
      if elem.category_id == categoryIndex {
        filtredFullEventDescriptionModels.append(elem)
      }
    }
  }
  
  func mappingToDescriptionViewModel() {
//    fullDescriptionViewModels = fullEventDescriptionModels.map { model -> FullEventDescriptionViewModel in
    fullDescriptionViewModels = filtredFullEventDescriptionModels.map { model -> FullEventDescriptionViewModel in
      let diaryString = calculateDaysToEvent(with: model).0
      let isFinished = calculateDaysToEvent(with: model).1
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
    }
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
    if let howMuchDaysLeft = calendarManager.howMuchdaysLeft(currentDate: currentDate, eventDate: startDate) {
      let eventFinished = calendarManager.fetchFullStringDateFromTimeStamp(ti: model.dateFinish)
      if howMuchDaysLeft >= Constants.zeroDays {
        return ("Осталось: \(howMuchDaysLeft) дней (\(startDateString) - \(finishDateString))", false)
      } else {
        return ("Завершено: " + "\(eventFinished)".firstCharOnly(), true)
      }
    } else {
      return ("Ошибка", true)
    }
  }
  
  enum Constants {
    static let zeroDays = 0
  }
}
