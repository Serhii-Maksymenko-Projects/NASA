//
//  HistoryViewModel.swift
//  NASA
//
//  Created by    Sergey on 24.01.2024.
//

import Foundation

protocol HistoryViewModelProtocol: AnyObject {
    func dismissHistory()
}

final class HistoryViewModel: HistoryViewModelProtocol {
    
    private weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func dismissHistory() {
        coordinator?.dismiss()
    }
}
