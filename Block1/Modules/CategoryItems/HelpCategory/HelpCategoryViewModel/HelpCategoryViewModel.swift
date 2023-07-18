//
//  HelpCategoryViewModel.swift
//  Block1
//
//  Created by Сергей Золотухин on 09.07.2023.
//

import Foundation

class HelpCategoryViewModel {
  var helpCategoryTitle = Box(" ")
  var sortedViewModels: Box<[ShortEventViewModel]> = Box([])
  var eventDescriptionModel: Box<FullEventModel?> = Box(nil)
  
//  private var sortedViewModels: [ShortEventViewModel] = []
  private var fullEventDescriptionModels: [FullEventDescriptionModel] = []
  private var filtredFullEventDescriptionModels: [FullEventDescriptionModel] = []
  private var fullDescriptionViewModels: [FullEventModel] = []
  private var sortedDescriptionViewModels: [FullEventModel] = []
  private var isCurrent = true
  
  private let categoryModel: HelpCategoryModel
  private let calendarManager: CalendarManagerProtocol
  
  init(categoryModel: HelpCategoryModel,
       calendarManager: CalendarManagerProtocol
  ) {
    self.categoryModel = categoryModel
    self.calendarManager = calendarManager
  }
  
  func printModel() {
    print("HelpCategory: \(categoryModel)")
  }
}

extension HelpCategoryViewModel {
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
    helpCategoryTitle.value = categoryModel.title
  }
  
  func routeToCategoryItem(index: Int) {
    eventDescriptionModel.value = sortedDescriptionViewModels[index]
  }
  
  func didTapToggleButton(isCurrentEvent: Bool) {
    if isCurrentEvent {
      fullDescriptionViewModels.forEach { model in
        if !model.isFinished {
          sortedDescriptionViewModels.removeAll()
          sortedDescriptionViewModels.append(model)
          sortedViewModels.value = mappingToViewModels(with: sortedDescriptionViewModels)
        }
      }
    } else {
      fullDescriptionViewModels.forEach { model in
        if model.isFinished {
          sortedDescriptionViewModels.removeAll()
          sortedDescriptionViewModels.append(model)
          sortedViewModels.value = mappingToViewModels(with: sortedDescriptionViewModels)
        }
      }
    }
//    viewController?.showSortedEvents(with: sortedViewModels)
  }
}

private extension HelpCategoryViewModel {
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
      if elem.category_id == categoryModel.id {
        filtredFullEventDescriptionModels.append(elem)
      }
    }
  }
  
  func mappingToDescriptionViewModel() {
    fullDescriptionViewModels = filtredFullEventDescriptionModels.map { model -> FullEventModel in
      let diaryString = calculateDaysToEvent(with: model).0
      let isFinished = calculateDaysToEvent(with: model).1
      let viewModel = FullEventModel(title: model.title,
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
  
  func mappingToViewModels(with models: [FullEventModel]) -> [ShortEventViewModel] {
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
