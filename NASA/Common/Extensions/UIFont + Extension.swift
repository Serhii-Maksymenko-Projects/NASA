//
//  UIFont + Extension.swift
//  NASA
//
//  Created by    Sergey on 22.01.2024.
//

import UIKit

extension UIFont {

    static let nasaDescription: UIFont = {
        let font = UIFont(name: "SFProText-Regular", size: 13)
        return font ?? .systemFont(ofSize: 13, weight: .bold)
    }()

    static let nasaBodyBold: UIFont = {
        let font = UIFont(name: "SFProText-Bold", size: 16)
        return font ?? .systemFont(ofSize: 16, weight: .bold)
    }()

    static let nasaBodyTwoBold: UIFont = {
        let font = UIFont(name: "SFProText-Bold", size: 17)
        return font ?? .systemFont(ofSize: 17, weight: .bold)
    }()

    static let nasaBodyTwoRegular: UIFont = {
        let font = UIFont(name: "SFProText-Regular", size: 17)
        return font ?? .systemFont(ofSize: 17, weight: .bold)
    }()

    static let nasaTitleBold: UIFont = {
        let font = UIFont(name: "SFProText-Bold", size: 22)
        return font ?? .systemFont(ofSize: 22, weight: .bold)
    }()

}
