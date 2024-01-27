//
//  NasaAlertContentView.swift
//  NASA
//
//  Created by    Sergey on 26.01.2024.
//

import UIKit

protocol NasaAlertContentViewDelegate: AnyObject {
    func dismiss()
}

class BaseNasaAlertContentView: UIView {

    var delegate: NasaAlertContentViewDelegate?
    private(set) var padding: CGFloat = 20.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContentView()
    }

    func configureContentView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .backgroundOne
    }

    func setContentPadding(_ padding: CGFloat) {
        self.padding = padding
    }

}
