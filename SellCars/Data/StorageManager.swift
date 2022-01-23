//
//  StorageManager.swift
//  SellCars
//
//  Created by Артем Соловьев on 28.12.2021.
//

import RealmSwift

let realm = try! Realm()

final class StorageManager {
    static func saveObject(_ continent: UserIn ){
        try! realm.write({
            realm.add(continent)
        })
    }
}

