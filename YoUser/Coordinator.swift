//
//  Coordinator.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start()
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {
        // should be open firstView - UsersViewController
    }
    
    func showUserDetailScreen(userItem: UserItem) {
        let viewModel = UserDetailViewModel(userItem: userItem)
        let vc = UserDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
 }
