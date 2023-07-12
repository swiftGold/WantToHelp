//
//  ProfileViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {}

class ProfileViewController: CustomVC {
  // MARK: - UI
  
  // MARK: - Variables
  var presenter: ProfilePresenterProtocol?
  
  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBar(titleName: TabBarNames.profile)
  }
}

// MARK: - ViewControllerProtocol impl
extension ProfileViewController: ProfileViewControllerProtocol {}

// MARK: - Private Methods
private extension ProfileViewController {}
