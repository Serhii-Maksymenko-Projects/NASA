//
//  NetworkConfiguration.swift
//  NASA
//
//  Created by    Sergey on 21.01.2024.
//

import Foundation

protocol NetworkConfigurationProtocol {
    func getUrls(roverType: RoverType, cameraType: CameraType?, date: Date?) -> [URL?]
}

class NetworkConfiguration: NetworkConfigurationProtocol {

    private let apiKey = "RCUzwyfE16TMcGpmOle0hTBi9gep7ap6LJaICmif"
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        return dateFormatter
    }()

    func getUrls(roverType: RoverType, cameraType: CameraType? = nil, date: Date? = nil) -> [URL?] {
        var urls = [URL?]()
        if roverType == .all {
            for type in RoverType.allCases where type != .all {
                urls.append(createUrl(roverType: type, cameraType: cameraType, date: date))
            }
        } else {
            urls.append(createUrl(roverType: roverType, cameraType: cameraType, date: date))
        }
        return urls
    }

    private func createUrl(roverType: RoverType, cameraType: CameraType? = nil, date: Date? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = "/mars-photos/api/v1/rovers/\(roverType.rawValue)/photos"
        components.queryItems = [
            URLQueryItem(name: "sol", value: "1000"),
            URLQueryItem(name: "camera", value: cameraType?.rawValue),
            URLQueryItem(name: "date", value: getStringDate(date: date)),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        return components.url
    }

    private func getStringDate(date: Date?) -> String? {
        guard let date else { return nil }
        return dateFormatter.string(from: date)
    }

}
