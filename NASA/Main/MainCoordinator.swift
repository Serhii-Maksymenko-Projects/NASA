//
//  MainViewControllerCoordinator.swift
//  NASA
//
//  Created by    Sergey on 23.01.2024.
//

import UIKit

protocol MainCoordinatorProtocol: Coordinator {
    func presentDetailController()
    func presentHistoryController()
}

final class MainCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func present() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewModel = MainViewModel(coordinator: self)
        let viewController = storyboard.instantiateViewController(identifier: "MainViewController") { coder in
            return MainViewController(coder: coder, viewModel: viewModel)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

}

extension MainCoordinator: MainCoordinatorProtocol {

    func presentDetailController() {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController)
        add(coordinator: detailCoordinator)
        detailCoordinator.present()
    }

    func presentHistoryController() {
        // TODO: - Present History Controller
    }

}
