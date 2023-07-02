//
//  Alerts.swift
//  VKGallery
//
//  Created by Сергей Золотухин on 22.04.2023.
//

import UIKit

protocol AlertManagerProtocol {
  func showAlertWith(title: String, message: String) -> UIAlertController
  func showAlertWithVC(title: String, message: String, vc: UIViewController?)
  func showAlertWithTwoVariants(title: String, message: String, vc: UIViewController) -> UIAlertController
}

final class AlertManager {
  private let router: Router
 
  init(
      router: Router
  ) {
      self.router = router
  }
}

extension AlertManager: AlertManagerProtocol {
  func showAlertWith(title: String, message: String) -> UIAlertController {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    return ac
  }
  
  func showAlertWithTwoVariants(title: String, message: String, vc: UIViewController) -> UIAlertController {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
      self.router.push(vc, animated: true)
    })
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    return ac
  }
  
  func showAlertWithVC(title: String, message: String, vc: UIViewController?) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    vc?.present(ac, animated: true)
  }
}
