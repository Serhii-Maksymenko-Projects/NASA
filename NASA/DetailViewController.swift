//
//  DetailViewController.swift
//  NASA
//
//  Created by    Sergey on 22.01.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!

    private var viewModel: DetailViewModelProtocol? = DetailViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        closeButton.rx.tap.subscribe { _ in
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }

}
