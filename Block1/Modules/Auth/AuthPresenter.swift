//
//  AuthPresenter.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

//import Foundation
//import FirebaseAuth
//
//protocol AuthPresenterProtocol {
//  func registrationButtonDidTap()
//  func enterButtonDidTap(with model: RegistrationModel)
//  func vkButtonDidTap()
//  func fbButtonDidTap()
//}
//
//final class AuthPresenter {
//  weak var viewController: AuthViewControllerProtocol?
//  private let router: Router
//  private let moduleBuilder: ModuleBuilderProtocol
//  private let alertManager: AlertManagerProtocol
//  
//  init(
//    router: Router,
//    moduleBuilder: ModuleBuilderProtocol,
//    alertManager: AlertManagerProtocol
//  ) {
//    self.router = router
//    self.moduleBuilder = moduleBuilder
//    self.alertManager = alertManager
//  }
//}
//
//extension AuthPresenter: AuthPresenterProtocol {
//  func fbButtonDidTap() {
//    let tabBar = self.moduleBuilder.buildTabBarController()
//    self.router.setRoot(tabBar, embedNavBar: false, isNavigationBarHidden: true)
//  }
//  
//  func vkButtonDidTap() {
//    let vc = moduleBuilder.buildWebViewViewController()
//    viewController?.routeToVkWebViewVC(to: vc)
//  }
//  
//  func enterButtonDidTap(with model: RegistrationModel) {
//    Auth.auth().signIn(withEmail: model.email, password: model.password) {authResult, error in
//      if let e = error {
//        let vc = self.alertManager.showAlertWith(title: "Error",
//                                                 message: e.localizedDescription
//        )
//        self.viewController?.showAlert(with: vc)
//      } else {
//        let tabBar = self.moduleBuilder.buildTabBarController()
//        self.router.setRoot(tabBar, embedNavBar: false, isNavigationBarHidden: true)
//      }
//    }
//  }
//  
//  func registrationButtonDidTap() {
////    let vc = moduleBuilder.buildRegistrationViewController()
//    let vc = moduleBuilder.buildRegistrationMVVMVC()
//    viewController?.routeToRegistrationVC(to: vc)
//  }
//}
//
//private extension AuthPresenter {}
