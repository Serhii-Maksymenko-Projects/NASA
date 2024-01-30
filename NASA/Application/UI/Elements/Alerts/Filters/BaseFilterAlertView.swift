//
//  BaseFilterAlertView.swift
//  NASA
//
//  Created by    Sergey on 25.01.2024.
//

import UIKit

class BaseFilterAlertView<T>: BaseNasaAlertContentView {

    private var completionHandler: ((_ filterValue: T) -> Void)?
    var resultValue: T?

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close_dark"), for: .normal)
        button.tintColor = .black
        button.setTitle(nil, for: .normal)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.nasaTitleBold
        return label
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "tick"), for: .normal)
        button.tintColor = .accentOne
        button.setTitle(nil, for: .normal)
        return button
    }()

    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [closeButton, titleLabel, saveButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        return stackView
    }()

    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            headerStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            saveButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }

    override func configureContentView() {
        super.configureContentView()
        addSubview(headerStackView)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
    }

    func addSaveAction(_ completion: ((_ filterValue: T) -> Void)?) {
        completionHandler = completion
    }

    func setTitle(title: String) {
        titleLabel.text = title
    }

    @objc func save() {
        if let resultValue {
            completionHandler?(resultValue)
        }
        close()
    }

}
