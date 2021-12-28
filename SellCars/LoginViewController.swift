//
//  LoginViewController.swift
//  SellCars
//
//  Created by Артем Соловьев on 28.12.2021.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {
    
    private var users: Results<UserIn>!
    
    private lazy var container: UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "IconCar"))
        
        return image
    }()

    private lazy var loginTextView: UITextField = {
        var view = UITextField()
        view.backgroundColor = .secondarySystemBackground
        view.tintColor = UIColor.red
        view.placeholder = "Логин"
        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 5, height: 8)
        return view
    }()

    private lazy var passwordTextView: UITextField = {
        var view = UITextField()
        view.backgroundColor = .secondarySystemBackground
        view.tintColor = UIColor.red
        view.placeholder = "Пароль"
        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 5, height: 8)
        return view
    }()

    private lazy var loginButton: UIButton = {
        var view = UIButton(type: .system)
        view.tintColor = .hexStringToUIColor(hex: Constants.Color.black)
        view.backgroundColor = .hexStringToUIColor(hex: Constants.Color.red)
        view.setTitle("Авторизоваться", for: .normal)
        view.addTarget(self, action: #selector(self.onLoginClick), for: .touchUpInside)
        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 5, height: 8)
        return view
    }()

    private lazy var signinButton: UIButton = {
        var view = UIButton(type: .system)
        view.tintColor = .hexStringToUIColor(hex: Constants.Color.black)
        view.backgroundColor = .hexStringToUIColor(hex: Constants.Color.red)
        view.setTitle("Зарегистрироваться", for: .normal)
        view.addTarget(self, action: #selector(self.onSignClick), for: .touchUpInside)
        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 5, height: 8)
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .hexStringToUIColor(hex: Constants.Color.white)
        
        users = realm.objects(UserIn.self)
        
        let userDefaults = UserDefaults.standard
        let appWasViewed = userDefaults.bool(forKey: "firstDownload")
        if appWasViewed == false{ //поменять на false
            print("Save first data")
            userDefaults.set(true, forKey: "firstDownload")
            DispatchQueue.main.async {
                let admin = UserIn()
                admin.login = "admin"
                admin.password = "admin"
                StorageManager.saveObject(admin)
            }
        }
        
        image.frame = CGRect(x: 0, y: view.bounds.size.height/4, width: view.bounds.size.width, height: view.bounds.size.width)
        view.addSubview(image)
        self.title = "Авторизация"
        self.container.addArrangedSubview(self.loginTextView)
        self.container.addArrangedSubview(self.passwordTextView)
        self.container.addArrangedSubview(self.signinButton)
        self.container.addArrangedSubview(self.loginButton)
        view.addSubview(container)
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
       
    @objc func onLoginClick() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func onSignClick() {
//        self.delagate?.signin(login: self.loginTextView.text, password: self.passwordTextView.text)
    }
}
