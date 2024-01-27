//
//  CardTableViewCell.swift
//  NASA
//
//  Created by    Sergey on 20.01.2024.
//

import UIKit
import RxSwift
import SDWebImage

final class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var roverLabel: CardLabel!
    @IBOutlet weak var cameraLabel: CardLabel!
    @IBOutlet weak var dateLabel: CardLabel!
    @IBOutlet weak var photoImageView: UIImageView!

    private let disposeBag = DisposeBag()
    private var viewModel: CardCellViewModelProtocol?

    func setViewModel(viewModel: CardCellViewModelProtocol) {
        self.viewModel = viewModel
        bind()
    }

    private func bind() {
        viewModel?.roverName.bind(to: roverLabel.rx.text).disposed(by: disposeBag)
        viewModel?.cameraName.bind(to: cameraLabel.rx.text).disposed(by: disposeBag)
        viewModel?.dateName.bind(to: dateLabel.rx.text).disposed(by: disposeBag)
        viewModel?.photoUrl.subscribe { [weak self] event in
            self?.photoImageView.sd_setImage(with: event.element as? URL)
        }.disposed(by: disposeBag)
    }
}
