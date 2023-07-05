//
//  DescriptionCoreDataModel+CoreDataProperties.swift
//  Block1
//
//  Created by Сергей Золотухин on 12.06.2023.
//
//

import Foundation
import CoreData

extension DescriptionCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DescriptionCoreDataModel> {
        return NSFetchRequest<DescriptionCoreDataModel>(entityName: "DescriptionCoreDataModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var category_id: Int32
    @NSManaged public var descr: String?
    @NSManaged public var dateStart: Double
    @NSManaged public var dateFinish: Double
    @NSManaged public var organizationName: String?
    @NSManaged public var adress: String?
    @NSManaged public var phone1: String?
    @NSManaged public var phone2: String?
    @NSManaged public var mainImage: String?
    @NSManaged public var detailImage1: String?
    @NSManaged public var detailImage2: String?
    @NSManaged public var detailImage3: String?
    @NSManaged public var photo1: String?
    @NSManaged public var photo2: String?
    @NSManaged public var photo3: String?
    @NSManaged public var photo4: String?
    @NSManaged public var photo5: String?
    @NSManaged public var participantsCount: Int32
}

extension DescriptionCoreDataModel : Identifiable {}
