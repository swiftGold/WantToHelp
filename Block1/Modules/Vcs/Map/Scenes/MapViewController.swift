//
//  MapViewController.swift
//  MVVM-Coordinator-Practice
//
//  Created by Сергей Золотухин on 10.07.2023.
//

import UIKit

class MapViewModel {}

class MapViewController: UIViewController {
  
  private lazy var button1: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("To Search!", for: .normal)
    button.addTarget(self, action: #selector(button1DidTap), for: .touchUpInside)
    button.backgroundColor = .cyan
    button.tintColor = .black
    return button
  }()
  
  private lazy var button2: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("MapViewController!", for: .normal)
    button.addTarget(self, action: #selector(button2DidTap), for: .touchUpInside)
    button.backgroundColor = .cyan
    button.tintColor = .black
    return button
  }()
  
  var router: MapRouterInput?
  var viewModel = MapViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    view.addSubview(button1)
    view.addSubview(button2)
    button1.frame = CGRect(x: 135, y: 320, width: 150, height: 70)
    button2.frame = CGRect(x: 135, y: 400, width: 150, height: 70)
  }
  
  @objc
  private func button1DidTap() {
    router?.routeToSearchAddress()
  }
  
  @objc
  private func button2DidTap() {}
}

protocol MapRouterInput: AnyObject {
  func routeToSearchAddress()
}
