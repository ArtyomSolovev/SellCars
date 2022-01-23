//
//  LoginScreenRouter.swift
//  SellCars
//
//  Created by Артем Соловьев on 23.01.2022.
//

import UIKit

protocol ILoginScreenRouter: AnyObject {
    func openMainScreen()
}

final class LoginScreenRouter: ILoginScreenRouter {
    
    weak var controller: UIViewController?

    func openMainScreen() {
                let vc = ViewController()
        controller?.navigationController?.pushViewController(vc, animated: true)
//        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
//        let viewController = ViewController()//MainScreenAssembly().build(user: user)
//        let navigationVC = UINavigationController(rootViewController: viewController)
//        window.rootViewController = navigationVC
//        window.makeKeyAndVisible()
//        window.overrideUserInterfaceStyle = .light
//        let options: UIView.AnimationOptions = .transitionCrossDissolve
//        let duration: TimeInterval = 0.3
//        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
    }
}

