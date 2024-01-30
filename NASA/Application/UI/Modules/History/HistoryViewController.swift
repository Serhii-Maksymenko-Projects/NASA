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

    static let storyboardName = "History"
    private let viewModel: HistoryViewModelProtocol
    private let disposeBag = DisposeBag()

    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        return dateFormatter
    }()

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
            cellIdentifier: FilterTableViewCell.cellId,
            cellType: FilterTableViewCell.self)) { [weak self] _, item, cell in
                cell.roverLabel.text = item.roverType.rawValue.capitalized
                cell.cameraLabel.text = item.cameraType.description
                cell.dateLabel.text = StringResource.allDate
                guard let date = item.date else { return }
                cell.dateLabel.text = self?.dateFormatter.string(from: date)
        }.disposed(by: disposeBag)

        viewModel.filters.map { $0.count > 0 }
            .bind(to: emptyLogoView.rx.isHidden)
            .disposed(by: disposeBag)

        filtersTableView.rx.modelSelected(RawFilterModel.self).subscribe { [weak self] event in
            guard let filterModel = event.element else { return }
            self?.createFilterMenuAlert(filterModel: filterModel)
        }.disposed(by: disposeBag)
    }

    func createFilterMenuAlert(filterModel: FilterModelDescription) {
        let menuFilterAlert = NasaAlertContentBuilder(
            title: nil,
            message: StringResource.menuFilterMessage, messageColor: .layerTwo)
        let useAction = NasaAlertAction(title: StringResource.use, style: .default) { [weak self] in
            self?.viewModel.useFilter(filter: filterModel)
        }
        let deleteAction = NasaAlertAction(title: StringResource.delete, style: .destructive) { [weak self] in
            self?.viewModel.removeFilter(filter: filterModel)
        }
        let cancelAction = NasaAlertAction(title: StringResource.cancel, style: .bold)
        menuFilterAlert.addAction(action: useAction, at: .main)
        menuFilterAlert.addAction(action: deleteAction, at: .main)
        menuFilterAlert.addAction(action: cancelAction, at: .other)
        menuFilterAlert.build()
        let alert = NasaAlert(content: menuFilterAlert, style: .alertSheet, on: self)
        alert.show()
    }

}
