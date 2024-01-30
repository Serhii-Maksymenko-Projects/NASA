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
    @IBOutlet weak var zoomScrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!

    static let storyboardName = "Detail"
    private let viewModel: DetailViewModelProtocol
    private let disposeBag = DisposeBag()

    init?(coder: NSCoder, viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.sd_setImage(with: viewModel.photoUrl)
        zoomScrollView.delegate = self
        bind()
    }

    private func bind() {
        closeButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.dismiss()
        }.disposed(by: disposeBag)
    }

}

extension DetailViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        zoomScrollView.isScrollEnabled = scale > 1.3
    }

}
