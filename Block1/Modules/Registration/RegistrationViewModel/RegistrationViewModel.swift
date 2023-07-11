//
//  RegistrationViewModel.swift
//  Block1
//
//  Created by Сергей Золотухин on 09.07.2023.
//

import Foundation
import FirebaseAuth
import RxSwift
import RxCocoa

class RegistrationViewModel {
  let emailText = BehaviorSubject<String>(value: "")
  let passwordText = BehaviorSubject<String>(value: "")
  
  func registerUser() -> Observable<Bool> {
    return Observable.create { observer in
      guard let email = try? self.emailText.value(),
            let password = try? self.passwordText.value() else {
        observer.onNext(false)
        return Disposables.create()
      }
      
      Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let error = error {
          print("Error: \(error.localizedDescription)")
          observer.onNext(false)
        } else {
          observer.onNext(true)
        }
      }
      return Disposables.create()
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

////  let statusErrorText = Box(" ")
//  var showStateAlert: ((RegistrationState) -> Void)?
//
//  func registerUser(with model: RegistrationModel) {
//    Auth.auth().createUser(withEmail: model.email, password: model.password) {authResult, error in
//      if let e = error {
//        let message = e.localizedDescription
//        let model = RegistrationState.RegStatusModel(status: "Error", message: message)
////        self.statusErrorText.value = message
//        self.showStateAlert?(.failure(model))
//      } else {
//        let model = RegistrationState.RegStatusModel(status: "Success!", message: "User registred!")
//        self.showStateAlert?(.success(model))
//      }
//    }
//  }



//struct Input {
//  let emailText: Observable<String>
//  let PasswordText: Observable<String>
//  let registerButtonTap: Observable<Void>
//}
//
//struct Output {
//  let result = Observable<Result<Void, Error>>.self
//}
//
//let emailValue = PublishSubject<String>()
//let passwordValue = PublishSubject<String>()
//
//public func transform(with input: Input) -> Output {
//
//}
