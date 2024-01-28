//
//  RawFilterModel + Extension.swift
//  NASA
//
//  Created by    Sergey on 28.01.2024.
//

extension RawFilterModel: FilterModelDescription {

    var roverType: RoverType {
        get { RoverType(rawValue: rawRoverType ?? "all") ?? .all }
        set { self.rawRoverType = newValue.rawValue }
    }

    var cameraType: CameraType {
        get { CameraType(rawValue: rawCameraType ?? "all") ?? .all }
        set { self.rawCameraType = newValue.rawValue }
    }

}
