//
//  CameraType.swift
//  NASA
//
//  Created by    Sergey on 21.01.2024.
//

enum CameraType: String, CaseIterable, TypeFilterProtocol {
    case all
    case fhaz
    case rhaz
    case mast
    case chemcam
    case mahli
    case mardi
    case navcam
    case pancam
    case minites

    var description: String {
        switch self {
        case .all: "All"
        case .fhaz: "Front Hazard Avoidance Camera"
        case .rhaz: "Rear Hazard Avoidance Camera"
        case .mast: "Mast Camera"
        case .chemcam: "Chemistry and Camera Complex"
        case .mahli: "Mars Hand Lens Imager"
        case .mardi: "Mars Descent Imager"
        case .navcam: "Navigation Camera"
        case .pancam: "Panoramic Camera"
        case .minites: "Miniature Thermal Emission Spectrometer (Mini-TES)"
        }
    }
}
