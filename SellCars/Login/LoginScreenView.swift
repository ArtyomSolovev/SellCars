//
//  LoginScreenView.swift
//  SellCars
//
//  Created by Артем Соловьев on 28.12.2021.
//

import UIKit
//import SnapKit

protocol ILoginScreenViewDelegate: AnyObject {
    func login(login: String?, password: String?)
    func signin(login: String?, password: String?)
}

final class LoginScreenView: UIView {

    weak var delagate: ILoginScreenViewDelegate?

    private lazy var container: UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        return view
    }()

    private lazy var loginTextView: UITextField = {
        var view = TextFieldWithPadding()
        view.backgroundColor = .secondarySystemBackground
        view.tintColor = UIColor.red
        view.placeholder = "Логин"
        return view
    }()

    private lazy var passwordTextView: UITextField = {
        var view = TextFieldWithPadding()
        view.backgroundColor = .secondarySystemBackground
        view.tintColor = UIColor.red
        view.placeholder = "Пароль"
        return view
    }()

    private lazy var loginButton: UIButton = {
        var view = UIButton(type: .system)
        view.setTitle("Авторизоваться", for: .normal)
        view.addTarget(self, action: #selector(self.onLoginClick), for: .touchUpInside)
        return view
    }()

    private lazy var signinButton: UIButton = {
        var view = UIButton(type: .system)
        view.setTitle("Зарегистрироваться", for: .normal)
        view.addTarget(self, action: #selector(self.onSignClick), for: .touchUpInside)
        return view
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(style: .large)
        view.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()
    
    private lazy var countUserLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubviews()
//        self.makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(progress: Bool) {
        self.spinner.isHidden = progress == false
        progress ? self.spinner.startAnimating() : self.spinner.stopAnimating()
    }
}

private extension LoginScreenView {
    func addSubviews() {
        self.addSubview(self.container)
        self.container.addArrangedSubview(self.countUserLabel)
        self.container.addArrangedSubview(self.loginTextView)
        self.container.addArrangedSubview(self.passwordTextView)
        self.container.addArrangedSubview(self.signinButton)
        self.container.addArrangedSubview(self.loginButton)
        self.addSubview(self.spinner)
    }

//    private func makeConstraints() {
//        self.container.snp.makeConstraints { maker in
//            maker.center.equalToSuperview()
//            maker.left.right.equalToSuperview().inset(50)
//        }
//        self.spinner.snp.makeConstraints { maker in
//            maker.size.equalToSuperview()
//            maker.center.equalToSuperview()
//        }
//    }

    @objc func onLoginClick() {
        self.delagate?.login(login: self.loginTextView.text, password: self.passwordTextView.text)
    }

    @objc func onSignClick() {
        self.delagate?.signin(login: self.loginTextView.text, password: self.passwordTextView.text)
    }
}

private class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

 override func textRect(forBounds bounds: CGRect) -> CGRect {
     let rect = super.textRect(forBounds: bounds)
     return rect.inset(by: textPadding)
 }

 override func editingRect(forBounds bounds: CGRect) -> CGRect {
     let rect = super.editingRect(forBounds: bounds)
     return rect.inset(by: textPadding)
 }
}
