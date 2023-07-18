//
//  ProfileViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.05.2023.
//

import UIKit

class ProfileViewController: CustomVC {
  // MARK: - UI
  
  // MARK: - Variables
  var viewModel: ProfileViewModel?

  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupNavBar(titleName: TabBarNames.profile)
  }
}

// MARK: - Private Methods
private extension ProfileViewController {}
