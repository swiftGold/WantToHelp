//
//  FullEventDescriptionViewModel.swift
//  Block1
//
//  Created by Сергей Золотухин on 18.07.2023.
//

import Foundation

class FullEventDescriptionViewModel {
  var eventTitle = Box(" ")
  var mainViewModel: Box<MainViewModel?> = Box(nil)
  var participantsViewModel: Box<ParticipantsViewModel?> = Box(nil)
  
  private var model: FullEventModel
  
  init(
    model: FullEventModel
  ) {
    self.model = model
  }
  
  func viewDidLoad() {
    guard let title = model.title else { return }
    eventTitle.value = title
    convertMainViewModel()
    convertParticipantsModel()
  }
}

private extension FullEventDescriptionViewModel {
  func convertMainViewModel() {
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
    mainViewModel.value = viewModel
  }
  
  func convertParticipantsModel() {
    let viewModel = ParticipantsViewModel(photo1: model.photo1,
                                          photo2: model.photo2,
                                          photo3: model.photo3,
                                          photo4: model.photo4,
                                          photo5: model.photo5,
                                          participantsCount: model.participantsCount
    )
    participantsViewModel.value = viewModel
  }
}
