//
//  DBManager.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/26/21.
//

import Foundation
import RealmSwift

class DBManager: NSObject {
    static let shared = DBManager()
    
    private override init() {
        super.init()
        let documentsPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print("************ Document path ==>>", documentsPath, "************" )
    }
    
    func clearTable<T: Object>(_ table: T.Type, filter: NSPredicate? = nil) {
        do {
            let realm = try? Realm()
            if let filter = filter {
                let object = realm?.objects(table.self).filter(filter).first
                try? realm?.write {
                    if let obj = object {
                        realm?.delete(obj)
                    }
                }
            } else {
                try? realm?.write {
                    if let allFields = realm?.objects(table) {
                        realm?.delete(allFields)
                    }
                }
            }
        } catch let error as NSError {
            // handle error
            print("error - \(error.localizedDescription)")
        }
    }
    
    func saveObject(objects: [Object]? = nil, singleObject: Object? = nil ) {
        do {
            let realm = try? Realm()
            try? realm?.write {
                if let objs = objects, objs.count > 0 {
                    realm?.add(objs, update: .modified)
                } else if let singleObj = singleObject {
                    realm?.add(singleObj, update: .modified)
                }
            }
        }
    }
    
    func getObjects<T: Object>(_ table: T.Type, filter: NSPredicate? = nil, sortedKey: String? = nil, ascending: Bool? = nil, fetchLimit: Int? = nil) -> [T]? {
        do {
            let realm = try? Realm()
            var realmResults: Results<T>?
            
            if let filter = filter {
                realmResults = realm?.objects(table).filter(filter)
            }
            if let sortedKey = sortedKey {
                realmResults = realm?.objects(table).sorted(byKeyPath: sortedKey)
            }
            if let ascending = ascending, let sortedKey = sortedKey {
                realmResults = realm?.objects(table).sorted(byKeyPath: sortedKey, ascending: ascending)
            }
            if let ascending = ascending, let sortedKey = sortedKey, let filter = filter {
                realmResults = realm?.objects(table).filter(filter).sorted(byKeyPath: sortedKey, ascending: ascending)
            }
            if filter == nil && sortedKey == nil {
                realmResults = realm?.objects(table)
            }
            if let fetchLimit = fetchLimit {
                if let results = realmResults, results.count > 0 {
                    return Array((results.prefix(fetchLimit)))
                }
            }
            if let results = realmResults, results.count > 0 {
                return Array(results)
                
            }
            return nil
        }
    }
}
