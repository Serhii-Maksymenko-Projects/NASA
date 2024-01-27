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
    var roverFilter: PublishSubject<RoverType> { get }
    var cameraFilter: PublishSubject<CameraType> { get }
    var dateFilter: PublishSubject<Date?> { get }

    func fetchData(roverType: RoverType)
    func presentDetailPhoto(photoUrl: URL)
    func presentHistory()
}

class MainViewModel: MainViewModelProtocol {

    var roverFilter = PublishSubject<RoverType>()
    var cameraFilter = PublishSubject<CameraType>()
    var dateFilter = PublishSubject<Date?>()
    var photos = PublishSubject<[MarsPhotoModel]>()

    private weak var coordinator: MainCoordinatorProtocol?
    private let service = NetworkService(session: URLSession.shared)
    private let config = NetworkConfiguration()
    private let disposeBag = DisposeBag()

    init(coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
        testValues()
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
            self?.coordinator?.mainViewControllerDidLoaded()
        }.disposed(by: disposeBag)
    }

    func presentDetailPhoto(photoUrl: URL) {
        coordinator?.presentDetailController(photoUrl: photoUrl)
    }

    func presentHistory() {
        coordinator?.presentHistoryController()
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

    private func testValues() {
        roverFilter.subscribe { event in
            print("testValue RoverType: \(String(describing: event.element))")
        }.disposed(by: disposeBag)

        cameraFilter.subscribe { event in
            print("testValue CameraType: \(String(describing: event.element))")
        }.disposed(by: disposeBag)

        dateFilter.subscribe { event in
            print("testValue Date: \(String(describing: event.element))")
        }.disposed(by: disposeBag)
    }
}
