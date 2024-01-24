//
//  NetworkError.swift
//  NASA
//
//  Created by    Sergey on 21.01.2024.
//

enum NetworkError: Error {
    case urlIsNotCorrect
    case dataIsNotCorrect
    case pageNotFound
    case canNotParse
}
