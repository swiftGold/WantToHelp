//
//  CoordinatorOutput.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

protocol CoordinatorOutput: Coordinator {
  var onFinish: (() -> Void)? { get set }
}
