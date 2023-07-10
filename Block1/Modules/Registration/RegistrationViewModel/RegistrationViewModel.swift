//
//  RegistrationViewModel.swift
//  Block1
//
//  Created by Сергей Золотухин on 09.07.2023.
//

import Foundation
import FirebaseAuth

class RegistrationViewModel {
//  let statusErrorText = Box(" ")
  var showStateAlert: ((RegistrationState) -> Void)?
  
  func registerUser(with model: RegistrationModel) {
    Auth.auth().createUser(withEmail: model.email, password: model.password) {authResult, error in
      if let e = error {
        let message = e.localizedDescription
        let model = RegistrationState.RegStatusModel(status: "Error", message: message)
//        self.statusErrorText.value = message
        self.showStateAlert?(.failure(model))
      } else {
        let model = RegistrationState.RegStatusModel(status: "Success!", message: "User registred!")
        self.showStateAlert?(.success(model))
      }
    }
  }
}

enum RegistrationState {
  case success(RegStatusModel)
  case failure(RegStatusModel)
  
  struct RegStatusModel {
    let status: String
    let message: String
  }
}
