//
//  FilterStorageManager.swift
//  NASA
//
//  Created by    Sergey on 28.01.2024.
//

import Foundation
import RxSwift
import CoreData

protocol FilterStorageManagerProtocol: AnyObject {
    func fetchData() -> Observable<[FilterModelDescription]>
    func add(filter: FilterModelDescription)
    func remove(filter: FilterModelDescription) -> Bool
}

final class FilterStorageManager: FilterStorageManagerProtocol {

    private let entityName = "RawFilterModel"
    private let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "NasaDataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()

    func fetchData() -> Observable<[FilterModelDescription]> {
        return Observable<[FilterModelDescription]>.create { [weak self] observer in
            let fetchRequest = RawFilterModel.fetchRequest()
            do {
                guard let resultFilters = try self?.context.fetch(fetchRequest) else {
                    observer.onError(FilterStorageError.contextIsNil)
                    return Disposables.create()
                }
                observer.onNext(resultFilters)
                observer.onCompleted()
            } catch let error as NSError {
                print("CoreData error: \(error.localizedDescription)")
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func add(filter: FilterModelDescription) {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName,
                                                      in: context)
        else { return }

        let filterObject = RawFilterModel(entity: entity, insertInto: context)
        filterObject.rawRoverType = filter.roverType.rawValue
        filterObject.rawCameraType = filter.cameraType.rawValue
        filterObject.date = filter.date
        saveChanged()
    }

    func remove(filter: FilterModelDescription) -> Bool {
        guard let filterObject = filter as? RawFilterModel else { return false }
        let test = context.object(with: filterObject.objectID)
        context.delete(test)
        saveChanged()
        return true
    }

    private func saveChanged() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("CoreData error: \(error.localizedDescription)")
        }
    }

}
