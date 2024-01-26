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
        bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData(roverType: .opportunity)
    }

    private func bind() {
        viewModel.photos
            .bind(to: tableView.rx.items(cellIdentifier: "cardCell",
                                         cellType: CardTableViewCell.self)) { _, item, cell in
                let cardViewModel = CardCellViewModel(marsPhoto: item)
                cell.setViewModel(viewModel: cardViewModel)
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(MarsPhotoModel.self).subscribe { [weak self] event in
            guard let url = event.element?.photoUrl else { return }
            self?.viewModel.presentDetailPhoto(photoUrl: url)
        }.disposed(by: disposeBag)

        historyButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.presentHistory()
        }.disposed(by: disposeBag)

        roverButton.rx.tap.subscribe { _ in
            let typeAlertContent = TypeFilterAlertView()
            let alert = NasaAlert(content: typeAlertContent, style: .alertSheet, on: self)
            alert.show()
        }.disposed(by: disposeBag)

        cameraButton.rx.tap.subscribe { _ in
            let typeAlertContent = TypeFilterAlertView()
            let alert = NasaAlert(content: typeAlertContent, style: .alertSheet, on: self)
            alert.show()
        }.disposed(by: disposeBag)

        calendarButton.rx.tap.subscribe { _ in
            let dateAlertContent = DateFilterAlertView()
            let alert = NasaAlert(content: dateAlertContent, style: .alert, on: self)
            alert.show()
        }.disposed(by: disposeBag)
    }

}