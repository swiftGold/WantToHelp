//
//  Router1.swift
//  Block1
//
//  Created by Сергей Золотухин on 11.07.2023.
//

import UIKit

protocol Router1: AnyObject {
//  func setRoot(_ viewController: UIViewController)
  func setRoot(_ viewController: UIViewController,
               embedNavBar: Bool,
               isNavigationBarHidden: Bool
  )
  func push(_ viewController: UIViewController, animated: Bool)
  func popToRoot(animated: Bool)
}
