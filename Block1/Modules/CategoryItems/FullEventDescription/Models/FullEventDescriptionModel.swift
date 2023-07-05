//
//  FullEventDescriptionModel.swift
//  Block1
//
//  Created by Сергей Золотухин on 31.05.2023.
//

import Foundation

struct FullEventDescriptionModel: Codable {
  let category_id: Int
  let title: String?
  let description: String?
  let dateStart: Double
  let dateFinish: Double
  let organizationName: String?
  let adress: String?
  let phone1: String?
  let phone2: String?
  let mainImage: String?
  let detailImage1: String?
  let detailImage2: String?
  let detailImage3: String?
  let photo1: String?
  let photo2: String?
  let photo3: String?
  let photo4: String?
  let photo5: String?
  let participantsCount: Int
}
