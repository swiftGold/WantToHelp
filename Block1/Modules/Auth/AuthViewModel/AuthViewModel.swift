//
//  AuthViewModel.swift
//  Block1
//
//  Created by Сергей Золотухин on 09.07.2023.
//

import Foundation
import FirebaseAuth
import RxSwift

class AuthViewModel {
  let emailText = BehaviorSubject<String>(value: "")
  let passwordText = BehaviorSubject<String>(value: "")
  let didTapOkButton = PublishSubject<Void>()
//  let coordinator: AuthCoordinator
  
//  init(coordinator: AuthCoordinator) {
//    self.coordinator = coordinator
//    routeToTabBarVC()
//  }
//
//  private func routeToTabBarVC() {
//    didTapOkButton
//      .subscribe(onNext: { [weak self] in
//        self?.coordinator.routeToMainTabBarVC()
//      })
//      .disposed(by: DisposeBag())
//  }
  
  func loginUser() -> Observable<Bool> {
    return Observable.create { observer in
      guard let email = try? self.emailText.value(),
            let password = try? self.passwordText.value() else {
        observer.onNext(false)
        return Disposables.create()
      }
      
      Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
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



//func enterButtonDidTap(with model: RegistrationModel) {
//  Auth.auth().signIn(withEmail: model.email, password: model.password) {authResult, error in
//    if let e = error {
//      let message = e.localizedDescription
//      let model = RegistrationState.RegStatusModel(status: "Error", message: message)
//      self.showStateAlert?(.failure(model))
//    } else {
//      let model = RegistrationState.RegStatusModel(status: "Success!", message: "User registred!")
//      self.showStateAlert?(.success(model))
//    }
//  }
//}
