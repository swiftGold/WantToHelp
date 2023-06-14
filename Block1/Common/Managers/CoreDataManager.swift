//
//  CoreDataManager.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.06.2023.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
  
}

final class CoreDataManager: NSObject {
  static let instance = CoreDataManager()
  private override init() {}
  
  lazy var context: NSManagedObjectContext = {
    persistentContainer.viewContext
  }()
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CoreData")
    container.loadPersistentStores { description, error in
      if let error {
        print(error.localizedDescription)
      } else {
        print("DB url -", description.url?.absoluteString ?? "can't find coreData file path")
      }
    }
    return container
  }()
  
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        fatalError(error.localizedDescription)
      }
    }
  }
  
  func entityDescription(entityName: String) -> NSEntityDescription {
    guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else { fatalError() }
    return entityDescription
  }
  
  public func createCategory(title: String?, image: String?) {
    let categoryCoreDataModel = CategoryCoreDataModel()
    categoryCoreDataModel.title = title
    categoryCoreDataModel.image = image
    saveContext()
  }
  
  public func deleteAllCategories() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryCoreDataModel")
    do {
      let categories = try? context.fetch(fetchRequest) as? [CategoryCoreDataModel]
      categories?.forEach { context.delete($0) }
    }
    saveContext()
  }
  
  public func fetchCategories() -> [CategoryCoreDataModel] {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryCoreDataModel")
    do {
      return try context.fetch(fetchRequest) as! [CategoryCoreDataModel]
    } catch {
      print(error.localizedDescription)
    }
    return []
  }
  
  public func createDescriptionModel(title: String?,
                                     descr: String?,
                                     dateStart: Double,
                                     dateFinish: Double,
                                     organizationName: String?,
                                     adress: String?,
                                     phone1: String?,
                                     phone2: String?,
                                     mainImage: String?,
                                     detailImage1: String?,
                                     detailImage2: String?,
                                     detailImage3: String?,
                                     photo1: String?,
                                     photo2: String?,
                                     photo3: String?,
                                     photo4: String?,
                                     photo5: String?,
                                     participantsCount: Int32
  ) {
    let categoryCoreDataModel = DescriptionCoreDataModel()
    categoryCoreDataModel.title = title
    categoryCoreDataModel.descr = descr
    categoryCoreDataModel.dateStart = dateStart
    categoryCoreDataModel.dateFinish = dateFinish
    categoryCoreDataModel.organizationName = organizationName
    categoryCoreDataModel.adress = adress
    categoryCoreDataModel.phone1 = phone1
    categoryCoreDataModel.phone2 = phone2
    categoryCoreDataModel.mainImage = mainImage
    categoryCoreDataModel.detailImage1 = detailImage1
    categoryCoreDataModel.detailImage2 = detailImage2
    categoryCoreDataModel.detailImage3 = detailImage3
    categoryCoreDataModel.photo1 = photo1
    categoryCoreDataModel.photo2 = photo2
    categoryCoreDataModel.photo3 = photo3
    categoryCoreDataModel.photo4 = photo4
    categoryCoreDataModel.photo5 = photo5
    categoryCoreDataModel.participantsCount = participantsCount
    saveContext()
  }
  
  public func deleteAllDescriptions() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DescriptionCoreDataModel")
    do {
      let categories = try? context.fetch(fetchRequest) as? [DescriptionCoreDataModel]
      categories?.forEach { context.delete($0) }
    }
    saveContext()
  }
  
  public func fetchDescriptions() -> [DescriptionCoreDataModel] {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DescriptionCoreDataModel")
    do {
      return try context.fetch(fetchRequest) as! [DescriptionCoreDataModel]
    } catch {
      print(error.localizedDescription)
    }
    return []
  }
}



// TODO: - delete after
// MARK: - CRUD
//public final class CoreDataManager: NSObject {
//  public static let shared = CoreDataManager()
//  private override init() {}

//  // MARK: - показывает путь к хранилищу
//  public func logCoreDataDBPath() {
//    if let url = appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
//      print("DB url - \(url)")
//    }
//  }
//
//  public func createCategory(title: String, image: String) {
//    guard let categoryEntityDescription = NSEntityDescription.entity(
//      forEntityName: "CategoryCoreDataModel",
//      in: context
//    ) else {
//      print("Can't create categoryEntityDescription")
//      return
//    }
//    let categoryCoreDataModel = CategoryCoreDataModel(
//      entity: categoryEntityDescription,
//      insertInto: context
//    )
//
//    categoryCoreDataModel.title = title
//    categoryCoreDataModel.image = image
//
//    appDelegate.saveContext()
//  }
//
//  public func fetchCategories() -> [CategoryCoreDataModel] {
//    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryCoreDataModel")
//    do {
//      return try context.fetch(fetchRequest) as! [CategoryCoreDataModel]
//    } catch {
//      print(error.localizedDescription)
//    }
//
//    return []
//  }
//
//  public func fetchCategory(with title: String) -> CategoryCoreDataModel? {
//    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryCoreDataModel")
//    fetchRequest.predicate = NSPredicate(format: "title == %@", title)
//    do {
//      let categories = try? context.fetch(fetchRequest) as? [CategoryCoreDataModel]
//      return categories?.first
//    }
//  }
//
//  public func updateCategory(with title: String, newImage: String) {
//    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryCoreDataModel")
//    fetchRequest.predicate = NSPredicate(format: "title == %@", title)
//    do {
//      guard let categories = try? context.fetch(fetchRequest) as? [CategoryCoreDataModel],
//            let categoryCoreDataModel = categories.first else { return }
//      categoryCoreDataModel.image = newImage
//    }
//    appDelegate.saveContext()
//  }
//
//  public func deletaAllCategories() {
//    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryCoreDataModel")
//    do {
//      let categories = try? context.fetch(fetchRequest) as? [CategoryCoreDataModel]
//      categories?.forEach { context.delete($0) }
//    }
//    appDelegate.saveContext()
//  }
//
//  public func deletaCategory(with title: String) {
//    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryCoreDataModel")
//    fetchRequest.predicate = NSPredicate(format: "title == %@", title)
//    do {
//      guard let categories = try? context.fetch(fetchRequest) as? [CategoryCoreDataModel],
//      let categoryCoreDataModel = categories.first else { return }
//      context.delete(categoryCoreDataModel)
//    }
//    appDelegate.saveContext()
//  }
//}
