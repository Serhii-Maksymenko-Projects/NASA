//
//  RoverType.swift
//  NASA
//
//  Created by    Sergey on 21.01.2024.
//

import Foundation

enum RoverType: String, CaseIterable, TypeFilterProtocol {
    case all
    case curiosity
    case opportunity
    case spirit

    var description: String {
        self.rawValue.capitalized
    }
}
