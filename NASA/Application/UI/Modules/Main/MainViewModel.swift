//
//  MainViewModel.swift
//  NASA
//
//  Created by    Sergey on 21.01.2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainViewModelProtocol: AnyObject {
    var photos: PublishSubject<[MarsPhotoModel]> { get }

    func fetchData(roverType: RoverType)
    func presentDetailPhoto(photoUrl: URL)
}

class MainViewModel: MainViewModelProtocol {

    private weak var coordinator: MainCoordinatorProtocol?
    var photos = PublishSubject<[MarsPhotoModel]>()
    private let service = NetworkService(session: URLSession.shared)
    private let config = NetworkConfiguration()
    private let disposeBag = DisposeBag()

    init(coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func fetchData(roverType: RoverType) {
        let urls = config.getUrls(roverType: roverType)
        mergeData(urls: urls).subscribe { [weak self] event in
            if let result = event.element {
                self?.photos.on(.next(result))
            }
            if let error = event.error {
                print("Error: \(error)")
            }
        }.disposed(by: disposeBag)
    }

    func presentDetailPhoto(photoUrl: URL) {
        coordinator?.presentDetailController(photoUrl: photoUrl)
    }

    private func mergeData(urls: [URL?]) -> Observable<[MarsPhotoModel]> {
        let observers: [Observable] = urls.map { url in
            return service.fetchData(url: url, type: MarsPhotoModels.self)
        }
        return Observable.concat(observers)
            .scan(into: []) { test, models in
                test.append(contentsOf: models.photos)
            }
    }
}
