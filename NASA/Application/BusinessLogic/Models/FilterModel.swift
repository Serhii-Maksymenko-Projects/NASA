//
//  FilterModel.swift
//  NASA
//
//  Created by    Sergey on 28.01.2024.
//

import Foundation

protocol FilterModelDescription {
    var roverType: RoverType { get set }
    var cameraType: CameraType { get set }
    var date: Date? { get set }
}

struct FilterModel: FilterModelDescription {
    var roverType: RoverType
    var cameraType: CameraType
    var date: Date?
}
