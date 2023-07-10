//
//  AuthViewModel.swift
//  Block1
//
//  Created by Сергей Золотухин on 09.07.2023.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
  
  var showStateAlert: ((RegistrationState) -> Void)?
  
  func enterButtonDidTap(with model: RegistrationModel) {
    Auth.auth().signIn(withEmail: model.email, password: model.password) {authResult, error in
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
