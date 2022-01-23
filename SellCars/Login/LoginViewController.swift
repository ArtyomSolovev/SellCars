//
//  LoginViewController.swift
//  SellCars
//
//  Created by Артем Соловьев on 28.12.2021.
//

import UIKit
import RealmSwift

protocol ILoginScreenView: AnyObject {
    func showAlert(message: String)
}

final class LoginViewController: UIViewController {
    
    private let presenter: ILoginScreenPresenter
    private let customView: LoginScreenView
    
    init(presenter: ILoginScreenPresenter) {
        self.presenter = presenter
        self.customView = LoginScreenView()
        super.init(nibName: nil, bundle: nil)
        self.customView.delagate = self.presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad(uiView: self)
    }

}

extension LoginViewController: ILoginScreenView{
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
