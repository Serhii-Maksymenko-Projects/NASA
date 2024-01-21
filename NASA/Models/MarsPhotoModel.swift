//
//  MarsPhotoModel.swift
//  NASA
//
//  Created by    Sergey on 21.01.2024.
//

import Foundation

struct MarsPhotoModels: Codable {
    let photos: [MarsPhotoModel]
}

struct MarsPhotoModel: Codable {
    let roverName: String
    let cameraName: String
    let dateString: String
    let photoUrl: String

    private enum ParseKey: CodingKey {
        case rover
        case camera
        case earthDate
        case imgSrc
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ParseKey.self)
        self.roverName = try container.decode(Self.Rover.self, forKey: .rover).name
        self.cameraName = try container.decode(Self.Camera.self, forKey: .camera).fullName
        self.dateString = try container.decode(String.self, forKey: .earthDate)
        self.photoUrl = try container.decode(String.self, forKey: .imgSrc)
    }

    private struct Camera: Codable {
        let fullName: String
    }

    private struct Rover: Codable {
        let name: String
    }
}
