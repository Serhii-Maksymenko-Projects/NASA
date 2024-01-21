//
//  NetworkService.swift
//  NASA
//
//  Created by    Sergey on 21.01.2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol NetworkServiceProtocol: AnyObject {
    func fetchData<T: Decodable>(url: URL?, type: T.Type) -> Observable<T>
}

class NetworkService: NetworkServiceProtocol {

    private let session: URLSession
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    init(session: URLSession) {
        self.session = session
    }

    func fetchData<T: Decodable>(url: URL?, type: T.Type) -> Observable<T> {
        return Observable<T>.create { [weak self] observer in
            guard let url, let self else {
                observer.on(.error(NetworkError.urlIsNotCorrect))
                return Disposables.create {}
            }
            let task = self.session.dataTask(with: url) { data, response, error in
                guard let response, let data else {
                    observer.on(.error(error ?? RxCocoaURLError.unknown))
                    return
                }

                guard response is HTTPURLResponse else {
                    observer.on(.error(RxCocoaURLError.nonHTTPResponse(response: response)))
                    return
                }
                do {
                    let result = try self.decoder.decode(T.self, from: data)
                    observer.on(.next(result))
                    observer.on(.completed)
                } catch {
                    observer.on(.error(NetworkError.canNotParse))
                }
            }
            task.resume()
            return Disposables.create(with: task.cancel)
        }
    }

}
