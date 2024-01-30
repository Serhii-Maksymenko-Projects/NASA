//
//  DetailViewControllerCoordinator.swift
//  NASA
//
//  Created by    Sergey on 23.01.2024.
//

import UIKit

final class DetailCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController
    private let photoUrl: URL

    init(navigationController: UINavigationController, photoUrl: URL) {
        self.navigationController = navigationController
        self.photoUrl = photoUrl
    }

    override func present() {
        let storyboard = UIStoryboard(name: DetailViewController.storyboardName, bundle: nil)
        let viewModel = DetailViewModel(coordinator: self, photoUrl: photoUrl)
        let viewControllerName = String(describing: DetailViewController.self)
        let viewController = storyboard.instantiateViewController(identifier: viewControllerName) { coder in
            return DetailViewController(coder: coder, viewModel: viewModel)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    override func dismiss() {
        navigationController.popViewController(animated: true)
    }

}
