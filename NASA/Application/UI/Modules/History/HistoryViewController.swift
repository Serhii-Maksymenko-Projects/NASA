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
                cell.roverLabel.text = item.roverType.rawValue.capitalized
                cell.cameraLabel.text = item.cameraType.description
                cell.dateLabel.text = item.date?.description ?? "All date"
        }.disposed(by: disposeBag)

        viewModel.filters.map { $0.count > 0 }
            .bind(to: emptyLogoView.rx.isHidden)
            .disposed(by: disposeBag)

        filtersTableView.rx.modelSelected(RawFilterModel.self).subscribe { [weak self] event in
            print("Tap Filter Cell")
            guard let filterModel = event.element else { return }
            print("Filter cell model: \(filterModel)")
            self?.createFilterMenuAlert(filterModel: filterModel)
        }.disposed(by: disposeBag)
    }

    func createFilterMenuAlert(filterModel: FilterModelDescription) {
        let saveAlertContent = NasaAlertContentBuilder(
            title: nil,
            message: "Menu Filter", messageColor: .layerTwo)
        let useAction = NasaAlertAction(title: "Use", style: .default)
        saveAlertContent.addAction(action: useAction, at: .main)
        let deleteAction = NasaAlertAction(title: "Delete", style: .destructive)
        saveAlertContent.addAction(action: deleteAction, at: .main)
        deleteAction.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.removeFilter(filter: filterModel)
        }.disposed(by: disposeBag)
        let cancelAction = NasaAlertAction(title: "Cancel", style: .bold)
        saveAlertContent.addAction(action: cancelAction, at: .other)
        saveAlertContent.build()
        let alert = NasaAlert(content: saveAlertContent, style: .alertSheet, on: self)
        alert.show()
    }

}
