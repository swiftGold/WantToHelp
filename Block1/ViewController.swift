//
//  ViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 25.05.2023.
//

import UIKit

final class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
  }
}

private extension ViewController {
  func setupViewController() {
    view.backgroundColor = .splashScreenBackgroundColor
    
    addSubviews()
    addConstraints()
  }
  
  func addSubviews() {
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([

    ])
  }
}
