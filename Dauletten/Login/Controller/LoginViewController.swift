//
//  LoginViewController.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class LoginViewController: LoaderBaseViewController {
    
    private var viewModel = AuthorizationViewModel()
    private var valuesViewModel = AuthorizationValuesViewModel()
    
    private var warningView = WarningView()
    private var loginInputView = InputView(inputType: .plainText, placeholder: "Логин")
    private var passwrdInputView = InputView(inputType: .secureText, icon: #imageLiteral(resourceName: "feather_eye-off"), placeholder: "Құпия сөз")
    private var loginButton = MainButton(title: "Кіру")
    private var socNetworksView = SocialAccountsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        setNavBarWithLarge(title: "Қош келдіңіз!")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavBarWithLarge(title: "Қош келдіңіз!")
    }
    
    override func configureViews() {
        setupViews()
        bind(to: viewModel)
        getWarningInfo()
    }
    
    private func bind(to viewModel: AuthorizationViewModel) {
        viewModel.error.observe(on: self) { [weak self] in
            guard  let `self` = self else { return }
            self.showAlert(type: .error, $0)}
        viewModel.loading.observe(on: self) { loading in
            if (loading) {
                self.showLoader()
            } else {
                self.view.isHidden = false
                self.hideLoader()
            }
        }
        viewModel.user.observe(on: self) { (user) in
            if let user = user {
                do { try? UserManager.createSessionWithUser(user) }
                self.goToProfilePage()
            }
        }
    }

    private func goToProfilePage() -> Void {
        let vc = ProfileViewController().inNavigation()
        vc.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "Combined Shape-2"), selectedImage: nil)
        self.tabBarController?.viewControllers![3] = vc
    }
    
    private func getSignIn() {
        valuesViewModel.setUser(loginInputView.textField.text!)
        valuesViewModel.setPassword(passwrdInputView.textField.text!)
        let parameters = valuesViewModel.getParameters()
        
        viewModel.getAuthorization(parameters: parameters ?? [:])

    }
    
    private func getWarningInfo() -> Void {
        self.showLoader()
        ParseManager.shared.getRequest(url: AppConstants.API.setting, success: { (result: Warning) in
            self.hideLoader()
            let warningView = self.warningView
            let info = "Егер сізде сабаққа рұқсат жоқ болса, төлем жасап; чеекті whatsapp-қа жіберіңіз. Төлем бағасы туралы мұғалімнен сұраңыз."
            warningView.contextLabel.text = info
            warningView.kaspiCardNumberButton.setTitle("4400 4301 0000 0000", for: .normal)
            warningView.phoneNumberButton.setTitle("+7 (777) 777 77 77", for: .normal)
            warningView.kaspiPhoneNumberButton.setTitle("+7 (777) 777 77 77", for: .normal)
            warningView.whatsappLinkButton.setTitle("https://wa.me/77777777777", for: .normal)

        }) { (error) in
            self.hideLoader()
            self.showAlert(type: .error, error)
        }
    }
    
    private func getOpenUrl(urlString: String) -> Void {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.open(url)
            }
        }
    }

    @objc func openUrl(_ sender: UIButton) {
        let urlList = ["https://t.me/joinchat/AAAAAEBHPPKyVGIJdKhCFQ", "https://instagram.com/dauletten?igshid=1xb64ubjzagdu", "https://www.youtube.com/c/Dauletten"]
        
        getOpenUrl(urlString: urlList[sender.tag])
    }
    
    @objc private func loginAction() -> Void {
        getSignIn()
    }
}

extension LoginViewController {
    private  func setupViews() {
        addSubviews()
        addConstraints()
        stylizeViews()
        setupAction()
    }
    
    private func addSubviews() {
        contentView.addSubview(warningView)
        contentView.addSubview(loginInputView)
        contentView.addSubview(passwrdInputView)
        contentView.addSubview(loginButton)
        contentView.addSubview(socNetworksView)
    }
    
    private func addConstraints() {
        warningView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(40)
            make.right.equalTo(-20)
        }
        
        loginInputView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(44)
            make.top.equalTo(warningView.snp.bottom).offset(32)
        }
        
        passwrdInputView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(44)
            make.top.equalTo(loginInputView.snp.bottom).offset(8)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(48)
            make.top.equalTo(passwrdInputView.snp.bottom).offset(24)
        }
        
        socNetworksView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(40)
            make.bottom.lessThanOrEqualTo(-24)
        }
    }
    
    private func stylizeViews() {
        view.backgroundColor = .backColor
        
        passwrdInputView.iconView.alpha = 0.5
        
    }
    
    private func setupAction() {
        socNetworksView.telegaButton.addTarget(self, action: #selector(openUrl(_:)), for: .touchUpInside)
        socNetworksView.instaButton.addTarget(self, action: #selector(openUrl(_:)), for: .touchUpInside)
        socNetworksView.youtubeButton.addTarget(self, action: #selector(openUrl(_:)), for: .touchUpInside)

        passwrdInputView.iconAction = {
            self.passwrdInputView.textField.isSecureTextEntry = self.passwrdInputView.iconView.alpha == 1.0
            self.passwrdInputView.iconView.alpha = self.passwrdInputView.textField.isSecureTextEntry ? 0.5 : 1.0
        }
        
        warningView.copyboardClosure = {
            self.showSubmitMessage(title: "Номер буферге көшірілді", message: "")
        }
        
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
    
}
