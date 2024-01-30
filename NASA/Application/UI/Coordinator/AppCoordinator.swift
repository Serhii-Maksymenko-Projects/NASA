//
//  AppCoordinator.swift
//  NASA
//
//  Created by    Sergey on 23.01.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

    private var splashPresenter: SplashPresenterDescription?
    private var window: UIWindow
    private let navigationController: UINavigationController = {
        let controller = UINavigationController()
        controller.isNavigationBarHidden = true
        return controller
    }()

    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }

    override func present() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController,
                                              loadedCompletionHandler: hideSplashViewController)
        add(coordinator: mainCoordinator)
        mainCoordinator.present()
        guard let windowScene = window.windowScene else { return }
        presentSplashViewController(scene: windowScene)
    }

    private func presentSplashViewController(scene: UIWindowScene) {
        let storyboard = UIStoryboard(name: SplashViewController.storyboardName, bundle: nil)
        let viewControllerName = String(describing: SplashViewController.self)
        let viewController = storyboard.instantiateViewController(identifier: viewControllerName)
        splashPresenter = SplashPresenter(scene: scene, viewController: viewController)
        splashPresenter?.present()
    }

    private func hideSplashViewController() {
        splashPresenter?.dismiss(completion: {
            self.splashPresenter = nil
        })
    }

}
