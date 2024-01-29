//
//  NasaAlertAction.swift
//  NASA
//
//  Created by    Sergey on 27.01.2024.
//

import UIKit

final class NasaAlertAction: UIButton {

    enum Style {
        case `default`
        case bold
        case destructive
    }

    enum Size: CGFloat {
        case `default` = 60
        case small = 44
    }

    private var completionHandler: (() -> Void)?

    convenience init(title: String, style: Style, size: Size = .default, completionHandler: (() -> Void)? = nil) {
        self.init(type: .system)
        self.completionHandler = completionHandler
        setTitle(title, for: .normal)
        heightAnchor.constraint(equalToConstant: size.rawValue).isActive = true
        switch style {
        case .default:
            titleLabel?.font = .nasaBodyTwoRegular
        case .bold:
            titleLabel?.font = .nasaBodyTwoBold
        case .destructive:
            titleLabel?.font = .nasaBodyTwoRegular
            tintColor = .systemThree
        }
        self.addTarget(self, action: #selector(completion), for: .touchUpInside)
    }

    @objc private func completion() {
        completionHandler?()
    }

}
