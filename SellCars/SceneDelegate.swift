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
//        let tabs = self.createTabs()
        let tableVC =  UINavigationController(rootViewController: LoginViewController())
        window.rootViewController = tableVC
        window.makeKeyAndVisible()
        self.window = window
    }
    

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

private extension SceneDelegate {
    func createTabs() -> UITabBarController {
        let tabBar = UITabBarController()
        let tableVC =  UINavigationController(rootViewController: ViewController())
        let StorageVC = UINavigationController(rootViewController: LoginViewController())
        tableVC.tabBarItem = self.createTabForTablesVC()
        StorageVC.tabBarItem = self.createTabForCollectionVC()

        tabBar.setViewControllers([tableVC, StorageVC], animated: false)
        return tabBar
    }

    func createTabForTablesVC() -> UITabBarItem {
        let item = UITabBarItem(title: "", image: UIImage(systemName: "car.2.fill"), tag: 0)
        return item
    }

    func createTabForCollectionVC() -> UITabBarItem {
        let item = UITabBarItem(title: "", image: UIImage(systemName: "archivebox"), tag: 1)
        return item
    }
}
