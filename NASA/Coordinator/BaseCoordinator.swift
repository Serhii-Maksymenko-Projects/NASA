//
//  BaseCoordinator.swift
//  NASA
//
//  Created by    Sergey on 23.01.2024.
//

import Foundation

class BaseCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    func present() {
        fatalError("Child should implement func start")
    }

    func dismiss() {}

}
