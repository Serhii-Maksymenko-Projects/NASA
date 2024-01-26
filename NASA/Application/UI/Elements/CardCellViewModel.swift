//
//  CardCellViewModel.swift
//  NASA
//
//  Created by    Sergey on 22.01.2024.
//

import Foundation
import RxSwift

protocol CardCellViewModelProtocol: AnyObject {
    var roverName: BehaviorSubject<String> { get }
    var cameraName: BehaviorSubject<String> { get }
    var dateName: BehaviorSubject<String> { get }
    var photoUrl: BehaviorSubject<URL?> { get }
}

final class CardCellViewModel: CardCellViewModelProtocol {

    var roverName = BehaviorSubject<String>(value: "")
    var cameraName = BehaviorSubject<String>(value: "")
    var dateName = BehaviorSubject<String>(value: "")
    var photoUrl = BehaviorSubject<URL?>(value: nil)

    init(marsPhoto: MarsPhotoModel) {
        roverName.on(.next(marsPhoto.roverName))
        cameraName.on(.next(marsPhoto.cameraName))
        dateName.on(.next(marsPhoto.dateString))
        photoUrl.on(.next(marsPhoto.photoUrl))
    }

}
