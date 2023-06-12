//
//  CategoryCoreDataModel+CoreDataProperties.swift
//  
//
//  Created by Сергей Золотухин on 11.06.2023.
//
//

import Foundation
import CoreData


extension CategoryCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryCoreDataModel> {
        return NSFetchRequest<CategoryCoreDataModel>(entityName: "CategoryCoreDataModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?

}
