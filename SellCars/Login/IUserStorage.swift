//
//  IUserStorage.swift
//  SellCars
//
//  Created by Артем Соловьев on 28.12.2021.
//

import Foundation

protocol IUserStorage {
    func getUser(login: String, password: String) -> UserModel?
    func saveUser(user: UserModel, completion: @escaping () -> Void)
    func usersCount() -> Int
}
