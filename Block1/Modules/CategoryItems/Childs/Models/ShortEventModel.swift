//
//  ShortEventModel.swift
//  Block1
//
//  Created by Сергей Золотухин on 31.05.2023.
//

import Foundation

struct ShortEventModel: Codable {
  let title: String
  let description: String
  let dateStart: Double
  let dateFinish: Double
  let mainImage: String
}
