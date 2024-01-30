//
//  MainViewControllerCoordinator.swift
//  NASA
//
//  Created by    Sergey on 23.01.2024.
//

import UIKit

protocol MainCoordinatorProtocol: Coordinator {
    func presentDetailController(photoUrl: URL)
    func presentHistoryController()
    func mainViewControllerDidLoaded()
}

final class MainCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController
    private var loadedCompletionHandler: (() -> Void)?

    init(navigationController: UINavigationController, loadedCompletionHandler: (() -> Void)?) {
        self.navigationController = navigationController
        self.loadedCompletionHandler = loadedCompletionHandler
    }

    override func present() {
        let storyboard = UIStoryboard(name: MainViewController.storyboardName, bundle: nil)
        let viewModel = MainViewModel(coordinator: self)
        let viewControllerName = String(describing: MainViewController.self)
        let viewController = storyboard.instantiateViewController(identifier: viewControllerName) { coder in
            return MainViewController(coder: coder, viewModel: viewModel)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

}

extension MainCoordinator: MainCoordinatorProtocol {

    func presentDetailController(photoUrl: URL) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, photoUrl: photoUrl)
        add(coordinator: detailCoordinator)
        detailCoordinator.present()
    }

    func presentHistoryController() {
        let historyCoordinator = HistoryCoordinator(navigationController: navigationController)
        add(coordinator: historyCoordinator)
        historyCoordinator.present()
    }

    func mainViewControllerDidLoaded() {
        guard let completion = loadedCompletionHandler else { return }
        completion()
        loadedCompletionHandler = nil
    }
}
