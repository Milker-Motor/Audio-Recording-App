////
////  Fetcher.swift
////  Audio Recording App
////
////  Created by Oleksii Lytvynov-Bohdanov on 24.11.2025.
////
//
//import CoreData
//
//public class Fetcher<ManagedObject: NSManagedObject> {
//    private let store: CoreDataRecordingStore
//    private let fetchController: NSFetchedResultsController<ManagedObject>
//    
//    public init(store: CoreDataRecordingStore, predicate: NSPredicate? = nil, sort: [String]? = nil, ascending: Bool = true, limit: Int? = nil) {
//        self.store = store
//        let fetchRequest = NSFetchRequest<ManagedObject>(entityName: ManagedObject.coreDataName)
//
//        if let sort = sort {
//            fetchRequest.sortDescriptors = sort.map { NSSortDescriptor(key: $0, ascending: ascending) }
//        } else {
//            fetchRequest.sortDescriptors = []
//        }
//        if let predicate = predicate {
//            fetchRequest.predicate = predicate
//        }
//        if let limit = limit {
//            fetchRequest.fetchLimit = limit
//        }
//        
//        store.perform { context in
//            try context.fetch(fetchRequest)
//        }
//        
//    }
//    
//    fu
//}
//
//extension Fetcher: Fetchable {
//    
//    
//    public func fetch() throws {
//        try fetchController.performFetch()
//    }
//}
//
//private extension NSManagedObject {
//    class var coreDataName: String {
//        Self.classString
//    }
//}
//
//private extension NSObject {
//    static var classString: String {
//        String(describing: self.self)
//    }
//}
