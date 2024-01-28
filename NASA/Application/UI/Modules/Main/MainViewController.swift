//
//  MainViewController.swift
//  NASA
//
//  Created by    Sergey on 20.01.2024.
//

import UIKit
import RxSwift

final class MainViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var roverButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    private let viewModel: MainViewModelProtocol
    private let disposeBag = DisposeBag()

    init?(coder: NSCoder, viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribing()
        bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData()
    }

    private func subscribing() {
        roverButton.rx.tap.subscribe { [weak self] _ in
            self?.showFilterTypeAlert(values: RoverType.allCases) { selectedValue in
                guard let roverType = selectedValue as? RoverType else { return }
                self?.viewModel.roverFilter.onNext(roverType)
            }
        }.disposed(by: disposeBag)

        cameraButton.rx.tap.subscribe { [weak self] _ in
            self?.showFilterTypeAlert(values: CameraType.allCases) { selectedValue in
                guard let cameraType = selectedValue as? CameraType else { return }
                self?.viewModel.cameraFilter.onNext(cameraType)
            }
        }.disposed(by: disposeBag)

        calendarButton.rx.tap.subscribe { [weak self] _ in
            let dateAlertContent = DateFilterAlertView()
            let alert = NasaAlert(content: dateAlertContent, style: .alert, on: self)
            dateAlertContent.addSaveAction { date in
                guard let date = date as? Date else { return }
                self?.viewModel.dateFilter.onNext(date)
            }
            alert.show()
        }.disposed(by: disposeBag)

        saveButton.rx.tap.subscribe { [weak self] _ in
            self?.createSaveFilterAlert()
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(MarsPhotoModel.self).subscribe { [weak self] event in
            guard let url = event.element?.photoUrl else { return }
            self?.viewModel.presentDetailPhoto(photoUrl: url)
        }.disposed(by: disposeBag)

        historyButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.presentHistory()
        }.disposed(by: disposeBag)
    }

    private func bind() {
        viewModel.roverFilter
            .map { $0.rawValue.capitalized }
            .bind(to: roverButton.rx.title(for: .normal))
            .disposed(by: disposeBag)

        viewModel.cameraFilter
            .map { $0.rawValue }
            .bind(to: cameraButton.rx.title(for: .normal))
            .disposed(by: disposeBag)

        viewModel.photos
            .bind(to: tableView.rx.items(cellIdentifier: "cardCell",
                                         cellType: CardTableViewCell.self)) { _, item, cell in
                let cardViewModel = CardCellViewModel(marsPhoto: item)
                cell.setViewModel(viewModel: cardViewModel)
        }.disposed(by: disposeBag)
    }

    private func showFilterTypeAlert(values: [TypeFilterProtocol], _ completion: ((_ selectedValue: Any) -> Void)?) {
        let typeAlertContent = TypeFilterAlertView()
        typeAlertContent.contentText = values
        typeAlertContent.addSaveAction(completion)
        let alert = NasaAlert(content: typeAlertContent, style: .alertSheet, on: self)
        alert.show()
    }

    private func createSaveFilterAlert() {
        let saveAlertContent = NasaAlertContentBuilder(
            title: "Save Filter",
            message: "The current filters and the date you have chosen can be saved to the filter history.")
        let saveAction = NasaAlertAction(title: "Save", style: .bold, size: .small) { [weak self] in
            self?.viewModel.saveFilter()
        }
        let cancelAction = NasaAlertAction(title: "Cancel", style: .default, size: .small)
        saveAlertContent.addAction(action: saveAction, at: .main)
        saveAlertContent.addAction(action: cancelAction, at: .main)
        saveAlertContent.setContentPadding(62)
        saveAlertContent.build()
        let alert = NasaAlert(content: saveAlertContent, style: .alert, on: self)
        alert.show()
    }

}
