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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewModel = MainViewModel(coordinator: self)
        let viewController = storyboard.instantiateViewController(identifier: "MainViewController") { coder in
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
        // TODO: - Present History Controller
    }

    func mainViewControllerDidLoaded() {
        guard let completion = loadedCompletionHandler else { return }
        completion()
        loadedCompletionHandler = nil
    }
}
