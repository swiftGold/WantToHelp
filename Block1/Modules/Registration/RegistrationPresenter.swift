//
//  RegistrationPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

import Foundation
import FirebaseAuth

protocol RegistrationPresenterProtocol {
  func didTapGeristrationButton(with model: RegistrationModel)
}

final class RegistrationPresenter {
  weak var viewController: RegistrationViewControllerProtocol?
  private let router: Router
  private let moduleBuilder: ModuleBuilderProtocol
  private let alertManager: AlertManagerProtocol
  
  init(
    router: Router,
    moduleBuilder: ModuleBuilderProtocol,
    alertManager: AlertManagerProtocol
  ) {
    self.router = router
    self.moduleBuilder = moduleBuilder
    self.alertManager = alertManager
  }
}

extension RegistrationPresenter: RegistrationPresenterProtocol {
  func didTapGeristrationButton(with model: RegistrationModel) {
    
    Auth.auth().createUser(withEmail: model.email, password: model.password) {authResult, error in
      if let e = error {
        let message = e.localizedDescription
        let vc = self.alertManager.showAlertWith(title: "Error",
                                                 message: message
        )
        self.viewController?.showAlert(with: vc)
      } else {
        let vc = self.moduleBuilder.buildAuthViewController()
        self.viewController?.routeToAuthVC(to: vc)
      }
    }
  }
}

private extension RegistrationPresenter {}
