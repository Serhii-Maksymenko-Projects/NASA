//
//  Coordinator.swift
//  NASA
//
//  Created by    Sergey on 23.01.2024.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func present()
    func dismiss()
}

extension Coordinator {

    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
