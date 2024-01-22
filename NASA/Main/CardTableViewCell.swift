//
//  CardTableViewCell.swift
//  NASA
//
//  Created by    Sergey on 20.01.2024.
//

import UIKit
import SDWebImage

final class CardTableViewCell: UITableViewCell {
    @IBOutlet weak var roverLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    func configureCell(marsPhoto: MarsPhotoModel) {
        roverLabel.text = marsPhoto.roverName
        cameraLabel.text = marsPhoto.cameraName
        dateLabel.text = marsPhoto.dateString
        photoImageView.sd_setImage(with: marsPhoto.photoUrl)
    }
}
