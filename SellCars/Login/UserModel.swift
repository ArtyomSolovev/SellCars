//
//  UserModel.swift
//  SellCars
//
//  Created by Артем Соловьев on 28.12.2021.
//

import Foundation
import CryptoKit

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}

struct UserModel {
    let uid: UUID
    let login: String
    let password: String

    init(login: String, password: String) {
        self.uid = UUID()
        self.login = login
        self.password = MD5(string: password)
    }

    init?(user: User) {
        guard let uid = user.uid,
              let login = user.login,
              let password = user.password
        else { return nil }
        self.uid = uid
        self.login = login
        self.password = password
    }
}

