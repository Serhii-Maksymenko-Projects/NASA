//
//  DetailViewModel.swift
//  NASA
//
//  Created by    Sergey on 23.01.2024.
//

import UIKit

protocol DetailViewModelProtocol: AnyObject {
    var photoUrl: URL { get }
    func dismiss()
}

final class DetailViewModel: DetailViewModelProtocol {

    private weak var coordinator: DetailCoordinator?
    let photoUrl: URL

    init(coordinator: DetailCoordinator, photoUrl: URL) {
        self.coordinator = coordinator
        self.photoUrl = photoUrl
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
