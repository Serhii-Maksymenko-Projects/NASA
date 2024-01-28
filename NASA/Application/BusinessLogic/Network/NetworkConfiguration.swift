//
//  NetworkConfiguration.swift
//  NASA
//
//  Created by    Sergey on 21.01.2024.
//

import Foundation

protocol NetworkConfigurationProtocol {
    func getUrls(filter: FilterModelDescription) -> [URL?]
}

class NetworkConfiguration: NetworkConfigurationProtocol {

    private let apiKey = "RCUzwyfE16TMcGpmOle0hTBi9gep7ap6LJaICmif"
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        return dateFormatter
    }()

    func getUrls(filter: FilterModelDescription) -> [URL?] {
        var urls = [URL?]()
        if filter.roverType == .all {
            for type in RoverType.allCases where type != .all {
                urls.append(createUrl(roverType: type,
                                      cameraType: filter.cameraType,
                                      date: filter.date))
            }
        } else {
            urls.append(createUrl(roverType: filter.roverType, cameraType: filter.cameraType, date: filter.date))
        }
        return urls
    }

    private func createUrl(roverType: RoverType, cameraType: CameraType, date: Date?) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = "/mars-photos/api/v1/rovers/\(roverType.rawValue)/photos"
        components.queryItems = [
            URLQueryItem(name: "sol", value: "1000"),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        if cameraType != .all {
            components.queryItems?.append(URLQueryItem(name: "camera", value: cameraType.rawValue))
        }
        if let date {
            components.queryItems?.append(URLQueryItem(name: "date", value: dateFormatter.string(from: date)))
        }
        return components.url
    }

}
