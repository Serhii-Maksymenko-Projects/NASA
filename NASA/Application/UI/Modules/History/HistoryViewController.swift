//
//  HistoryViewController.swift
//  NASA
//
//  Created by    Sergey on 24.01.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class HistoryViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!

    private let viewModel: HistoryViewModelProtocol
    private let disposeBag = DisposeBag()

    init?(coder: NSCoder, viewModel: HistoryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        closeButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.dismissHistory()
        }.disposed(by: disposeBag)
    }

}
