//
//  HistoryViewModel.swift
//  NASA
//
//  Created by    Sergey on 24.01.2024.
//

import Foundation
import RxSwift

protocol HistoryViewModelProtocol: AnyObject {
    var filters: BehaviorSubject<[FilterModelDescription]> { get }
    func dismissHistory()
    func fetchData()
    func removeFilter(filter: FilterModelDescription)
    func useFilter(filter: FilterModelDescription)
}

final class HistoryViewModel: HistoryViewModelProtocol {

    var filters = BehaviorSubject<[FilterModelDescription]>(value: [])
    private weak var coordinator: Coordinator?
    private let storageManager = FilterStorageManager()
    private let disposeBag = DisposeBag()

    init(coordinator: Coordinator? = nil) {
        self.coordinator = coordinator
        fetchData()
    }

    func dismissHistory() {
        coordinator?.dismiss()
    }

    func fetchData() {
        storageManager.fetchData().subscribe { [weak self] event in
            guard let resultFilters = event.element else { return }
            self?.filters.onNext(resultFilters)
        }.disposed(by: disposeBag)
    }

    func removeFilter(filter: FilterModelDescription) {
        guard storageManager.remove(filter: filter) else { return }
        fetchData()
    }

    func useFilter(filter: FilterModelDescription) {
        NotificationCenter.default.post(name: .useFilter, object: filter)
    }

}
