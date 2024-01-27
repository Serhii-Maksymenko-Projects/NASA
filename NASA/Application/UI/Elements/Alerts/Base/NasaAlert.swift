//
//  BaseAlert.swift
//  NASA
//
//  Created by    Sergey on 26.01.2024.
//

import UIKit

final class NasaAlert {

    enum Style {
        case alert
        case alertSheet

        func getConstraint(content: UIView, background: UIView) -> NSLayoutConstraint {
            switch self {
            case .alert:
                content.centerYAnchor.constraint(equalTo: background.centerYAnchor)
            case .alertSheet:
                content.bottomAnchor.constraint(equalTo: background.bottomAnchor)
            }
        }
    }

    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()

    private let style: Style
    private var contentView: BaseNasaAlertContentView = BaseNasaAlertContentView()

    init(content: BaseNasaAlertContentView, style: Style, on viewController: UIViewController?) {
        self.style = style
        self.contentView = content
        guard let targetView = viewController?.view else { return }
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        targetView.addSubview(content)
        setupContentViewConstraints()
        contentView.delegate = self
        setupTapGestureRecognizer()
    }

    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeTap))
        backgroundView.addGestureRecognizer(tapGesture)
    }

    func show() {
        contentView.transform = CGAffineTransform(translationX: 0, y: 1000)
        animate(isShow: true)

    }

    @objc private func closeTap() {
        dismiss()
    }

    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                 constant: contentView.padding),
            contentView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                  constant: -contentView.padding),
            style.getConstraint(content: contentView, background: backgroundView)
        ])
    }

    private func animate(isShow: Bool) {
        let startBlur: CGFloat = isShow ? 0.0 : 0.7
        let startMove: CGFloat = isShow ? 0.3 : 0.0
        let newAlpha: CGFloat = isShow ? 0.4 : 0.0
        let newPosition: CGFloat = isShow ? 0 : 1000
        UIView.animateKeyframes(withDuration: 0.4,
                                delay: 0,
                                options: [.calculationModeLinear]) { [weak self] in
            UIView.addKeyframe(withRelativeStartTime: startBlur, relativeDuration: 0.3) {
                self?.backgroundView.alpha = newAlpha
            }
            UIView.addKeyframe(withRelativeStartTime: startMove, relativeDuration: 0.7) {
                self?.contentView.transform = CGAffineTransform(translationX: 0, y: newPosition)
            }
        }
    }

}

extension NasaAlert: NasaAlertContentViewDelegate {

    func dismiss() {
        animate(isShow: false)
    }

}
