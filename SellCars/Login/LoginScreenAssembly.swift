//
//  LoginScreenAssembly.swift
//  SellCars
//
//  Created by Артем Соловьев on 28.12.2021.
//

import UIKit

final class LoginScreenAssembly {
    func build() -> UIViewController {
        let userDefaultsStorage = 0 //AppDelegate.container.resolve(IUserDefaultsStorage.self)!
        let userStorage = 0 //AppDelegate.container.resolve(IUserStorage.self)!
        let router = LoginScreenRouter()
        let presenter = LoginScreenPresenter(userStorage: userStorage as! IUserStorage,
                                             userDefaultsStorage: userDefaultsStorage as! IUserDefaultsStorage,
                                             router: router)
        let controller = LoginScreenViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}

