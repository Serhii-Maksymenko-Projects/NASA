//
//  SceneDelegate.swift
//  NASA
//
//  Created by    Sergey on 20.01.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var foregroundWindow: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        if let window {
            appCoordinator = AppCoordinator(window: window)
            appCoordinator?.present()
        }
    }

}
