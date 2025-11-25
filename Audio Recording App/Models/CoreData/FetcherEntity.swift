////
////  FetcherEntity.swift
////  Audio Recording App
////
////  Created by Oleksii Lytvynov-Bohdanov on 24.11.2025.
////
//
//import CoreData
//
//public class FetcherEntity<ManagedObject: NSManagedObject, EntityType: CoreDataEntity> {
//    
//    private let fetcher: Fetcher<ManagedObject>
//    
//    required init(predicate: NSPredicate? = nil, sort: [String]? = nil, ascending: Bool? = nil, limit: Int? = nil) {
//        
//        fetcher = Fetcher(predicate: predicate, sort: sort, ascending: ascending, limit: limit)
//    }
//    
//    public var items: [EntityType] {
//        fetcher.items
//            .compactMap { $0 as? EntityType.ManagedObject }
//            .map { EntityType(object: $0) }
//    }
//}
