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
    var dateFilter: PublishSubject<Date> { get }

    func fetchData(roverType: RoverType)
    func saveFilter()
    func presentDetailPhoto(photoUrl: URL)
    func presentHistory()
}

class MainViewModel: MainViewModelProtocol {

    var photos = PublishSubject<[MarsPhotoModel]>()
    var roverFilter = PublishSubject<RoverType>()
    var cameraFilter = PublishSubject<CameraType>()
    var dateFilter = PublishSubject<Date>()
    private var filter: FilterModelDescription

    private weak var coordinator: MainCoordinatorProtocol?
    private let service = NetworkService(session: URLSession.shared)
    private let config = NetworkConfiguration()
    private let disposeBag = DisposeBag()

    init(coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
        self.filter = TestClass(roverType: .all, cameraType: .all, date: nil)
        self.subscribing()
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

    func saveFilter() {
        print("Save filter")
        let storageManager = FilterStorageManager()
        storageManager.add(filter: filter)
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

    private func subscribing() {
        roverFilter.subscribe { event in
            self.filter.roverType = event.element ?? .all
        }.disposed(by: disposeBag)

        cameraFilter.subscribe { event in
            self.filter.cameraType = event.element ?? .all
        }.disposed(by: disposeBag)

        dateFilter.subscribe { event in
            self.filter.date = event.element
        }.disposed(by: disposeBag)
    }

}

protocol FilterModelDescription {
    var roverType: RoverType { get set }
    var cameraType: CameraType { get set }
    var date: Date? { get set }
}

struct TestClass: FilterModelDescription {
    var roverType: RoverType
    var cameraType: CameraType
    var date: Date?
}

extension RawFilterModel: FilterModelDescription {
    var roverType: RoverType {
        get { RoverType(rawValue: rawRoverType ?? "all") ?? .all }
        set {}
    }

    var cameraType: CameraType {
        get { CameraType(rawValue: rawCameraType ?? "all") ?? .all }
        set {}
    }
}
