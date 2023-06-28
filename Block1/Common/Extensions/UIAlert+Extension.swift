//
//  UIAlert+Extension.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

import UIKit

extension UIViewController {
  func callErrorAlert(message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
      self.dismiss(animated: true, completion: nil)
    })
    present(alert, animated: true)
  }
}
