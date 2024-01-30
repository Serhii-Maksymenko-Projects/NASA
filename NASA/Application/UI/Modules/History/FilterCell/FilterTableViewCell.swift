//
//  FilterTableViewCell.swift
//  NASA
//
//  Created by    Sergey on 27.01.2024.
//

import UIKit

final class FilterTableViewCell: UITableViewCell {
    static let cellId = "filterCell"

    @IBOutlet weak var roverLabel: CardLabel!
    @IBOutlet weak var cameraLabel: CardLabel!
    @IBOutlet weak var dateLabel: CardLabel!

}
