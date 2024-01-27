//
//  HistoryViewModel.swift
//  NASA
//
//  Created by    Sergey on 24.01.2024.
//

import Foundation
import RxSwift

protocol HistoryViewModelProtocol: AnyObject {
    var filters: PublishSubject<[String]> { get }
    func dismissHistory()
}

final class HistoryViewModel: HistoryViewModelProtocol {

    var filters = PublishSubject<[String]>()
    private weak var coordinator: Coordinator?

    init(coordinator: Coordinator? = nil) {
        self.coordinator = coordinator
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            let arrays = (1...10).map { "Test text: \($0)" }
            self?.filters.onNext(arrays)
        }
    }

    func dismissHistory() {
        coordinator?.dismiss()
    }
}
