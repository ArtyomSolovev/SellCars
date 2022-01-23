//
//  LoginScreenPresenter.swift
//  SellCars
//
//  Created by Артем Соловьев on 23.01.2022.
//

import Foundation
import RealmSwift

protocol ILoginScreenPresenter: ILoginScreenViewDelegate {
    func viewDidLoad(uiView: ILoginScreenView)
}

final class LoginScreenPresenter: ILoginScreenPresenter {
    
    private weak var uiView: ILoginScreenView?
    private let router: ILoginScreenRouter
    
    private var users: Results<UserIn>!

    init(router: ILoginScreenRouter) {
        self.router = router
    }

    func viewDidLoad(uiView: ILoginScreenView) {
        users = realm.objects(UserIn.self)
        
        let userDefaults = UserDefaults.standard
        let appWasViewed = userDefaults.bool(forKey: "firstDownload")
        if appWasViewed == false{ //поменять на false
            print("Save first data")
            userDefaults.set(true, forKey: "firstDownload")
            DispatchQueue.main.async {
                let admin = UserIn()
                admin.login = "Admin"
                admin.password = "12345"
                StorageManager.saveObject(admin)
            }
        }
        
        self.uiView = uiView
    }
}

extension LoginScreenPresenter: ILoginScreenViewDelegate{
    func login(login: String?, password: String?) {
        if login == "" || password == ""{
            return
        }
        users.forEach { UserIn in
            if UserIn.login == login{
                if UserIn.password == password {
                    router.openMainScreen()
                }
            }
        }
    }
    
    func signin(login: String?, password: String?) {
        if login == "" || password == ""{
            return
        }
        let newUser = UserIn()
        newUser.login = login ?? ""
        newUser.password = password ?? ""
        users.forEach { UserIn in
            if UserIn.login == login{
                print("the user has already been created")
                return
            }
        }
        StorageManager.saveObject(newUser)
        router.openMainScreen()
    }
    
    
}
