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
    @IBOutlet weak var filtersTableView: UITableView!
    @IBOutlet weak var emptyLogoView: UIView!

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

        viewModel.filters.bind(to: filtersTableView.rx.items(
            cellIdentifier: "filterCell",
            cellType: FilterTableViewCell.self)) { _, item, cell in
                cell.roverLabel.text = item
                cell.cameraLabel.text = item
                cell.dateLabel.text = item
        }.disposed(by: disposeBag)

        viewModel.filters.map { $0.count > 1 }
            .bind(to: emptyLogoView.rx.isHidden)
            .disposed(by: disposeBag)

        filtersTableView.rx.modelSelected(String.self).subscribe { [weak self] event in
            self?.createFilterMenuAlert()
        }.disposed(by: disposeBag)
    }

    func createFilterMenuAlert() {
        let saveAlertContent = NasaAlertContentBuilder(
            title: nil,
            message: "Menu Filter", messageColor: .layerTwo)
        let useAction = NasaAlertAction(title: "Use", style: .default)
        saveAlertContent.addAction(action: useAction, at: .main)
        let deleteAction = NasaAlertAction(title: "Delete", style: .destructive)
        saveAlertContent.addAction(action: deleteAction, at: .main)
        let cancelAction = NasaAlertAction(title: "Cancel", style: .bold)
        saveAlertContent.addAction(action: cancelAction, at: .other)
        saveAlertContent.build()
        let alert = NasaAlert(content: saveAlertContent, style: .alertSheet, on: self)
        alert.show()
    }

}
