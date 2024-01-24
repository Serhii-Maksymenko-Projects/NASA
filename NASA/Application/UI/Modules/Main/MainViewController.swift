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
        viewModel.fetchData(roverType: .spirit)
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
    }
}
