//
//  LoaderElementView.swift
//  NASA
//
//  Created by    Sergey on 20.01.2024.
//

import UIKit

@IBDesignable
final class LoaderElementView: UIView {

    private enum LoadElementPosition {
        case top
        case center
        case bottom
    }

    private let diameterConstant: CGFloat = 14
    private lazy var startConstraint = circleView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    private lazy var circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .layerOne
        view.layer.cornerRadius = diameterConstant / 2
        self.addSubview(view)
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            circleView.heightAnchor.constraint(equalToConstant: diameterConstant),
            circleView.widthAnchor.constraint(equalToConstant: diameterConstant),
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            startConstraint
        ])
    }

    func animate(delay: TimeInterval) {
        UIView.animateKeyframes(withDuration: 2,
                                delay: delay,
                                options: [.calculationModeLinear, .repeat]) { [weak self] in
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1) {
                self?.updatePosition(at: .top)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1) {
                self?.updatePosition(at: .center)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.1) {
                self?.updatePosition(at: .bottom)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1) {
                self?.updatePosition(at: .center)
            }
        }
    }

    private func updatePosition(at position: LoadElementPosition) {
        switch position {
        case .top: startConstraint.constant = -12
        case .center: startConstraint.constant = 0
        case .bottom: startConstraint.constant = +12
        }
        self.layoutIfNeeded()
    }

}
