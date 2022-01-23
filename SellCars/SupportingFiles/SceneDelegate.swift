//
//  SceneDelegate.swift
//  SellCars
//
//  Created by Артем Соловьев on 26.12.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let loginVC = LoginScreenAssembly().build()
        let navigationVC =  UINavigationController(rootViewController: loginVC)
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
        self.window = window
    }

}
