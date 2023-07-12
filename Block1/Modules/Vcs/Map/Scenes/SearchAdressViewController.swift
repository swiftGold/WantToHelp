//
//  SearchAdressViewController.swift
//  MVVM-Coordinator-Practice
//
//  Created by Сергей Золотухин on 10.07.2023.
//

import UIKit

class SearchAdressViewModel {}

class SearchAdressViewController: UIViewController {
  
  private lazy var button1: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("To Restaraunts!", for: .normal)
    button.addTarget(self, action: #selector(button1DidTap), for: .touchUpInside)
    button.backgroundColor = .cyan
    button.tintColor = .black
    return button
  }()
  
  private lazy var button2: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("SearchADressVC!", for: .normal)
    button.addTarget(self, action: #selector(button2DidTap), for: .touchUpInside)
    button.backgroundColor = .cyan
    button.tintColor = .black
    return button
  }()
  
  var viewModel = SearchAdressViewModel()
  var router: SearchAdressRouterInput?

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
    router?.routeToRestaurantsVC()
  }
  
  @objc
  private func button2DidTap() {}
}

protocol SearchAdressRouterInput: AnyObject {
  func routeToRestaurantsVC()
}
