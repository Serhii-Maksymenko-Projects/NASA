//
//  NasaAlertView.swift
//  NASA
//
//  Created by    Sergey on 27.01.2024.
//

import UIKit

final class NasaAlertContentBuilder: BaseNasaAlertContentView {

    enum Section {
        case main
        case other
    }

    enum TextType {
        case title
        case message
    }

    private var labelsStackView: UIStackView?
    private var mainSection: [UIView] = []
    private var otherSection: [UIView]?

    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .backgroundOne
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.layer.cornerRadius = 30
        stackView.layer.masksToBounds = true
        return stackView
    }()

    init(title: String?, message: String?, titleColor: UIColor? = nil, messageColor: UIColor? = nil) {
        super.init(frame: .zero)
        if let title {
            let titleLabel = createLabel(text: title, type: .title)
            titleLabel.textColor = titleColor ?? .black
            addLabel(label: titleLabel)
        }
        if let message {
            let messageLabel = createLabel(text: message, type: .message)
            messageLabel.textColor = messageColor ?? .black
            addLabel(label: messageLabel)
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func configureContentView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        setContentPadding(8)
        addSubview(mainStackView)
    }

    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }

    func addAction(action: NasaAlertAction, at section: Section) {
        switch section {
        case .main: addActionToMainSection(action: action)
        case .other: addActionToOtherSection(action: action)
        }
    }

    func build() {
        mainSection.forEach { element in
            mainStackView.addArrangedSubview(element)
        }
        guard otherSection != nil else { return }
        createOtherSectionView()
    }

    private func createOtherSectionView() {
        guard let otherSection else { return }
        let stackView = UIStackView(arrangedSubviews: otherSection)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .backgroundOne
        stackView.layer.cornerRadius = 30
        stackView.layer.masksToBounds = true
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }

    private func createLabelsStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }

    private func addLabel(label: UILabel) {
        if labelsStackView == nil {
            let labelsStack = createLabelsStack()
            labelsStackView = labelsStack
            mainSection.append(labelsStack)
        }
        labelsStackView?.addArrangedSubview(label)
    }

    private func addActionToMainSection(action: NasaAlertAction) {
        if mainSection.count == 0 {
            mainSection.append(action)
        } else {
            mainSection.append(createSeparator())
            mainSection.append(action)
        }
    }

    private func addActionToOtherSection(action: NasaAlertAction) {
        if otherSection == nil {
            otherSection = []
            otherSection?.append(action)
        } else if otherSection?.isEmpty ?? false {
            otherSection?.append(action)
        } else {
            otherSection?.append(createSeparator())
            otherSection?.append(action)
        }
    }

    private func createSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .layerTwo.withAlphaComponent(0.5)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }

    private func createLabel(text: String, type: TextType) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center

        switch type {
        case .title: label.font = .nasaBodyTwoBold
        case .message: label.font = .nasaDescription
        }

        return label
    }

}
