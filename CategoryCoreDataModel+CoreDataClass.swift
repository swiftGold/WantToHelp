//
//  CategoryCoreDataModel+CoreDataClass.swift
//  
//
//  Created by Сергей Золотухин on 11.06.2023.
//
//

import Foundation
import CoreData

@objc(CategoryCoreDataModel)
public class CategoryCoreDataModel: NSManagedObject {
  
  convenience init() {
    let entityDescription = CoreDataManager.instance.entityDescription(entityName: "CategoryCoreDataModel")
    let context = CoreDataManager.instance.context
    self.init(entity: entityDescription, insertInto: context)
  }
}
