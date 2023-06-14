//
//  FullEventDescriptionPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 05.06.2023.
//

import Foundation

protocol FullEventDescriptionPresenterProtocol {
  func viewDidLoad()
  func didTapShirtButton()
  func didTapHandsButton()
  func didTapToolsButton()
  func didTapCashButton()
  func didTapWriteUsButton()
  func didTapRouteToSiteButton()
}

final class FullEventDescriptionPresenter {
  weak var viewController: FullEventDescriptionVCProtocol?
  var model: FullEventDescriptionViewModel
  private let router: Router
  private let moduleBuilder: ModuleBuilderProtocol
  
  init(
    router: Router,
    moduleBuilder: ModuleBuilderProtocol,
    model: FullEventDescriptionViewModel
  ) {
    self.router = router
    self.moduleBuilder = moduleBuilder
    self.model = model
  }
}

extension FullEventDescriptionPresenter: FullEventDescriptionPresenterProtocol {
  func viewDidLoad() {
    guard let titleText = model.title else { return }
    let mainViewModel = convertMainViewModel()
    let participantsViewModel = convertParticipantsModel()
    viewController?.updateViewController(titleText: titleText,
                                         with: mainViewModel,
                                         with: participantsViewModel)
  }
  
  func didTapShirtButton() {
    print(#function)
  }
  
  func didTapHandsButton() {
    print(#function)
  }
  
  func didTapToolsButton() {
    print(#function)
  }
  
  func didTapCashButton() {
    print(#function)
  }
  
  func didTapWriteUsButton() {
    print(#function)
  }
  
  func didTapRouteToSiteButton() {
    print(#function)
  }
}

private extension FullEventDescriptionPresenter {
  func convertMainViewModel() -> MainViewModel {
    let viewModel = MainViewModel(title: model.title,
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
                                  diaryString: model.diaryString
    )
    return viewModel
  }
  
  func convertParticipantsModel() -> ParticipantsViewModel {
    let viewModel = ParticipantsViewModel(photo1: model.photo1,
                                          photo2: model.photo2,
                                          photo3: model.photo3,
                                          photo4: model.photo4,
                                          photo5: model.photo5,
                                          participantsCount: model.participantsCount
    )
    return viewModel
  }
}
