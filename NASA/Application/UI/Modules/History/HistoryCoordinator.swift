//
//  HistoryCoordinator.swift
//  NASA
//
//  Created by    Sergey on 24.01.2024.
//

import UIKit

final class HistoryCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func present() {
        let viewModel = HistoryViewModel(coordinator: self)
        let storyboard = UIStoryboard(name: "History", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "HistoryViewController") { coder in
            return HistoryViewController(coder: coder, viewModel: viewModel)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    override func dismiss() {
        navigationController.popViewController(animated: true)
    }

}
