//
//  CameraType.swift
//  NASA
//
//  Created by    Sergey on 21.01.2024.
//

enum CameraType: String, CaseIterable, TypeFilterProtocol {

    case all = "All"
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
        case .all: StringResource.all
        case .fhaz: StringResource.fhaz
        case .rhaz: StringResource.rhaz
        case .mast: StringResource.mast
        case .chemcam: StringResource.chemcam
        case .mahli: StringResource.mahli
        case .mardi: StringResource.mardi
        case .navcam: StringResource.navcam
        case .pancam: StringResource.pancam
        case .minites: StringResource.minites
        }
    }
}
