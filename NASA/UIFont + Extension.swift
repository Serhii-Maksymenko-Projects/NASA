//
//  UIFont + Extension.swift
//  NASA
//
//  Created by    Sergey on 22.01.2024.
//

import UIKit

extension UIFont {

    static let ncBodyBold: UIFont = {
        let font = UIFont(name: "SFProText-Bold", size: 16)
        return font ?? .systemFont(ofSize: 16, weight: .bold)
    }()

}
