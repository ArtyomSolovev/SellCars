//
//  User.swift
//  SellCars
//
//  Created by Артем Соловьев on 28.12.2021.
//

import RealmSwift

class UserIn: Object {
    @objc dynamic var login = ""
    @objc dynamic var password = ""
}
