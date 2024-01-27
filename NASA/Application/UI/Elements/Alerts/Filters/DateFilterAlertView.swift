//
//  DateFilterAlertView.swift
//  NASA
//
//  Created by    Sergey on 26.01.2024.
//

import UIKit

final class DateFilterAlertView: BaseFilterAlertView<Any> {

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }

    override func configureContentView() {
        super.configureContentView()
        addSubview(datePicker)
        layer.cornerRadius = 50
        layer.masksToBounds = true
    }

    override func save() {
        resultValue = datePicker.date
        super.save()
    }

}
