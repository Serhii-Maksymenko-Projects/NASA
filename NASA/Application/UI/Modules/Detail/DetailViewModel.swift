//
//  DetailViewModel.swift
//  NASA
//
//  Created by    Sergey on 23.01.2024.
//

import UIKit

protocol DetailViewModelProtocol: AnyObject {
    func dismiss()
}

final class DetailViewModel: DetailViewModelProtocol {

    private weak var coordinator: DetailCoordinator?

    init(coordinator: DetailCoordinator? = nil) {
        self.coordinator = coordinator
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
