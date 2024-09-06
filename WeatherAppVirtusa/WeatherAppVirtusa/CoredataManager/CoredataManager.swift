//
//  CoredataManager.swift
//  WeatherAppVirtusa
//
//  Created by Aadi on 9/5/24.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let mainContext: NSManagedObjectContext

    private init() {
        mainContext = PersistenceController.shared.container.viewContext
    }
    
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: objectType))
        
        do {
            return try mainContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch \(objectType): \(error)")
            return []
        }
    }
    
    func insertCity(_ name: String) {
        let objects = CoreDataManager.shared.fetch(City.self)
        for object in objects {
            CoreDataManager.shared.delete(object)
        }
        let city = City(context: mainContext)
        city.name = name
       saveContext()
    }
    
    func delete<T: NSManagedObject>(_ object: T) {
        mainContext.delete(object)
        saveContext()
    }
}
