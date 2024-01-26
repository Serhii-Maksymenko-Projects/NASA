//
//  TypeFilterAlertView.swift
//  NASA
//
//  Created by    Sergey on 26.01.2024.
//

import UIKit

final class TypeFilterAlertView: BaseFilterAlertView {

    private lazy var typePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            typePicker.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 20),
            typePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            typePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            typePicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }

    override func configureContentView() {
        super.configureContentView()
        addSubview(typePicker)
        setContentPadding(0)
        layer.cornerRadius = 50
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
    }

}

extension TypeFilterAlertView: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }

}

extension TypeFilterAlertView: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Test text: \(row)"
    }

}
