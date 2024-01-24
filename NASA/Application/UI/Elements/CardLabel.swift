//
//  CardLabel.swift
//  NASA
//
//  Created by    Sergey on 22.01.2024.
//

import UIKit

@IBDesignable
final class CardLabel: UILabel {

    @IBInspectable private var prefix: String = ""
    let ncBodyBold: UIFont = UIFont(name: "SFProText-Bold", size: 16) ?? .systemFont(ofSize: 16, weight: .bold)

    override var text: String? {
        didSet { updateAttributed() }
    }

    private func updateAttributed() {
        guard let text else { return }
        let resultTextAttributed = NSAttributedString(string: text,
                                                      attributes: [.font: UIFont.ncBodyBold])
        let newAttributed = NSMutableAttributedString(string: prefix)
        newAttributed.append(resultTextAttributed)
        attributedText = newAttributed
    }

}
