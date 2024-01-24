//
//  SplashPresenter.swift
//  NASA
//
//  Created by    Sergey on 23.01.2024.
//

import UIKit

protocol SplashPresenterDescription: AnyObject {
    func present()
    func dismiss(completion: @escaping () -> Void?)
}

final class SplashPresenter: SplashPresenterDescription {

    private let foregroundSplashWindow: UIWindow

    init(scene: UIWindowScene, viewController: UIViewController) {
        self.foregroundSplashWindow = UIWindow(windowScene: scene)
        self.foregroundSplashWindow.windowLevel = .normal + 1
        self.foregroundSplashWindow.rootViewController = viewController
    }

    private func createForegroundWindow(scene: UIWindowScene, viewController: SplashViewController) -> UIWindow {
        let window = UIWindow(windowScene: scene)
        window.windowLevel = .normal + 1
        window.rootViewController = viewController
        return window
    }

    func present() {
        foregroundSplashWindow.isHidden = false
    }

    func dismiss(completion: @escaping () -> Void?) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.foregroundSplashWindow.alpha = 0
        } completion: { _ in
            completion()
        }
    }

}
