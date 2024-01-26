//
//  UIFont + Extension.swift
//  NASA
//
//  Created by    Sergey on 22.01.2024.
//

import UIKit

extension UIFont {

    static let nasaBodyBold: UIFont = {
        let font = UIFont(name: "SFProText-Bold", size: 16)
        return font ?? .systemFont(ofSize: 16, weight: .bold)
    }()

    static let nasaTitleBold: UIFont = {
        let font = UIFont(name: "SFProText-Bold", size: 22)
        return font ?? .systemFont(ofSize: 22, weight: .bold)
    }()

}
