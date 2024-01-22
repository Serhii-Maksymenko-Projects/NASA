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
    @IBOutlet weak var tableView: UITableView!

    private let viewModel: MainViewModelProtocol = MainViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData(roverType: .curiosity)
    }

    private func bind() {
        viewModel.photos
            .bind(to: tableView.rx.items(cellIdentifier: "cardCell",
                                         cellType: CardTableViewCell.self)) { _, item, cell in
            cell.configureCell(marsPhoto: item)
        }.disposed(by: disposeBag)
    }
}
