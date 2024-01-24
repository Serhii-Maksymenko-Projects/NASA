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
        let mainViewControllerCoordinator = MainCoordinator(navigationController: navigationController)
        add(coordinator: mainViewControllerCoordinator)
        mainViewControllerCoordinator.present()
        guard let windowScene = window.windowScene else { return }
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SplashViewController")
        splashPresenter = SplashPresenter(scene: windowScene, viewController: viewController)
        splashPresenter?.present()

        // TODO: Logit to hide SplashScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.splashPresenter?.dismiss(completion: {
                self?.splashPresenter = nil
            })
        }
    }

}
