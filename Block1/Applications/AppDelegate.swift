//
//  AppDelegate.swift
//  Block1
//
//  Created by Сергей Золотухин on 19.05.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  private let jsonService = JSONService()
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.tintColor = .white
    application.statusBarStyle = UIStatusBarStyle.lightContent
    CoreDataManager.instance.deleteAllCategories()
    CoreDataManager.instance.deleteAllDescriptions()
    DispatchQueue.global(qos: .background).sync {
      self.fetchCategoriesFromJSON()
      self.fetchDescriptionsFromJSON()
    }
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

// MARK: - Private Methods
private extension AppDelegate {
  func fetchCategoriesFromJSON() {
    jsonService.fetchCategoriesFromJSON(completion: { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let response):
        strongSelf.createCategoriesCoreData(with: response)
      case .failure(let error):
        print(error.localizedDescription)
      }
    })
  }
  
  func createCategoriesCoreData(with models: [CategoryModel]) {
    let context = CoreDataManager.instance.context
    context.perform {
      models.forEach { model in
        CoreDataManager.instance.createCategory(title: model.title,
                                                image: model.image
        )
      }
    }
  }
  
  func fetchDescriptionsFromJSON() {
    jsonService.fetchFullEventDescriptionFromJSON(completion: { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let response):
        strongSelf.createDescriptionsCoreData(with: response)
      case .failure(let error):
        print(error.localizedDescription)
      }
    })
  }

  func createDescriptionsCoreData(with models: [FullEventDescriptionModel]) {
    let context = CoreDataManager.instance.context
    context.perform {
      models.forEach { model in
        CoreDataManager.instance.createDescriptionModel(title: model.title,
                                                        descr: model.description,
                                                        dateStart: model.dateStart,
                                                        dateFinish: model.dateFinish,
                                                        organizationName:
                                                          model.organizationName,
                                                        adress: model.adress,
                                                        phone1: model.phone1,
                                                        phone2: model.phone2,
                                                        mainImage: model.mainImage,
                                                        detailImage1: model.detailImage1,
                                                        detailImage2: model.detailImage2,
                                                        detailImage3: model.detailImage3,
                                                        photo1: model.phone1,
                                                        photo2: model.phone2,
                                                        photo3: model.photo3,
                                                        photo4: model.photo4,
                                                        photo5: model.photo5,
                                                        participantsCount: Int32(model.participantsCount)
        )
      }
    }
  }
}
