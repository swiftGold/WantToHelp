//
//  DescriptionCoreDataModel+CoreDataClass.swift
//  Block1
//
//  Created by Сергей Золотухин on 12.06.2023.
//
//

import Foundation
import CoreData

@objc(DescriptionCoreDataModel)
public class DescriptionCoreDataModel: NSManagedObject {
  convenience init() {
    let entityDescription = CoreDataManager.instance.entityDescription(entityName: "DescriptionCoreDataModel")
    let context = CoreDataManager.instance.context
    self.init(entity: entityDescription, insertInto: context)
  }
}
