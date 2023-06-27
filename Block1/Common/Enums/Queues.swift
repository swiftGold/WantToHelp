//
//  Queues.swift
//  Block1
//
//  Created by Сергей Золотухин on 15.06.2023.
//

import Foundation

enum Queues {
  static let concurrentQueueBarrier = DispatchQueue(label: "barrierConcurent", attributes: .concurrent)
}
