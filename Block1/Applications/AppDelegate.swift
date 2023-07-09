//
//  AppDelegate.swift
//  Block1
//
//  Created by Сергей Золотухин on 19.05.2023.
//

import UIKit
import CoreData
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  private let jsonService = JSONService(jsonDecoderManager: JSONDecoderManager())
  private let apiService = APIService(
    networkManager: NetworkManager(
      jsonService: JSONDecoderManager()),
    alamofireNetworkManager: AlamofireNetworkManager(
      jsonService: JSONDecoderManager()))
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.tintColor = .white
    application.statusBarStyle = UIStatusBarStyle.lightContent
    FirebaseApp.configure()
    CoreDataManager.instance.deleteAllCategories()
    CoreDataManager.instance.deleteAllDescriptions()
    
    Queues.concurrentQueueBarrier.async(flags: .barrier) {
      self.fetchCategories()
      self.fetchEvents()
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
  func fetchCategories() {
    apiService.fetchCategories { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let response):
        strongSelf.createCategoriesCoreData(with: response)
      case .failure(let error):
        if let error = error as? CustomError {
          print(error.message)
        } else {
          print(error.localizedDescription)
        }
        print("FETCH CATEGORIES FROM JSON FILE")
        strongSelf.fetchCategoriesFromJSON()
      }
    }
  }
  
  func fetchEvents() {
    apiService.fetchEvents { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let response):
        strongSelf.createDescriptionsCoreData(with: response)
      case .failure(let error):
        if let error = error as? CustomError {
          print(error.message)
        } else {
          print(error.localizedDescription)
        }
        print("FETCH EVENTS FROM JSON FILE")
        strongSelf.fetchDescriptionsFromJSON()
      }
    }
  }
  
  func fetchCategoriesFromJSON() {
    jsonService.fetchCategoriesFromJSON(completion: { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let response):
        strongSelf.createCategoriesCoreData(with: response)
      case .failure(let error):
        if let error = error as? CustomError {
          print(error.message)
        } else {
          print(error.localizedDescription)
        }
      }
    })
  }
  
  func createCategoriesCoreData(with models: [CategoryModel]) {
    let context = CoreDataManager.instance.context
    context.perform {
      models.forEach { model in
        CoreDataManager.instance.createCategory(id: model.id,
                                                title: model.title,
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
        if let error = error as? CustomError {
          print(error.message)
        } else {
          print(error.localizedDescription)
        }
      }
    })
  }
  
  func createDescriptionsCoreData(with models: [FullEventDescriptionModel]) {
    let context = CoreDataManager.instance.context
    context.perform {
      models.forEach { model in
        CoreDataManager.instance.createDescriptionModel(category_id: Int32(model.category_id),
                                                        title: model.title,
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
                                                        photo1: model.photo1,
                                                        photo2: model.photo2,
                                                        photo3: model.photo3,
                                                        photo4: model.photo4,
                                                        photo5: model.photo5,
                                                        participantsCount: Int32(model.participantsCount)
        )
      }
    }
  }
}
