//
//  ProfileViewController.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProfileViewController: LoaderBaseViewController {

    private var userView = UserView()
    private var myLessonsSelectionView = ProfileSelectionView(icon: #imageLiteral(resourceName: "Group 10484"), title: "Сабақтарым")
    private var feedbackSelectionView = ProfileSelectionView(icon: #imageLiteral(resourceName: "Group 10484-4"), title: "Кері байланыс")
    private var logoutButton = UIButton()
    private var socialAccountsView = SocialAccountsView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavBarWithLarge(title: "Қош келдіңіз, \(UserManager.getCurrentUser()?.name ?? "")!")
    }
    
    override func configureViews() {
        setupViews()
        validateUserToken()
        setupData()
    }

    private func validateUserToken() -> Void {
        if UserManager.getCurrentUser() == nil {
            (tabBarController?.viewControllers![0] as! UINavigationController).popToRootViewController(animated: true)
            let vc = LoginViewController().inNavigation()
            vc.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "Combined Shape-2"), selectedImage: nil)
            tabBarController?.viewControllers![3] = vc
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

    private func setupData() {
        if let user = UserManager.getCurrentUser() {
            userView.usernameLabel.text = user.name
            userView.phoneLabel.text = user.email
            userView.userAvatarView.letterLabel.text = String((user.name ?? " ").prefix(1)).uppercased()
        }
    }

    private func goToLoginPage() -> Void {
        let vc = LoginViewController().inNavigation()
        vc.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "Combined Shape-2"), selectedImage: nil)
        self.tabBarController?.viewControllers![3] = vc
    }

    @objc private func logoutAction() {
        self.showAlertWithAction(title: "Шығу?", message: "") {
            UserManager.deleteCurrentSession()
            self.goToLoginPage()
        }
    }
    
    @objc private func goToMyLessons() -> Void {
        let vc = MyCoursesViewController()
        self.tabBarController!.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func goToFeedback() -> Void {
        self.tabBarController!.navigationController?.pushViewController(FeedbackViewController(), animated: true)
    }
    
    @objc func openUrl(_ sender: UIButton) {
        let urlList = ["https://t.me/joinchat/AAAAAEBHPPKyVGIJdKhCFQ", "https://instagram.com/dauletten?igshid=1xb64ubjzagdu", "https://www.youtube.com/c/Dauletten"]
        
        getOpenUrl(urlString: urlList[sender.tag])
    }


}

extension ProfileViewController {
    private func setupViews() {
        addSubviews()
        addConstraints()
        stylizeViews()
        setupActions()
        setupRecognizer()
    }
    
    private func addSubviews() {
        contentView.addSubview(userView)
        contentView.addSubview(myLessonsSelectionView)
        contentView.addSubview(feedbackSelectionView)
        contentView.addSubview(logoutButton)
        contentView.addSubview(socialAccountsView)
    }
    
    private func addConstraints() {
        userView.snp.makeConstraints { (make) in
            make.top.equalTo(self.navigationController!.navigationBar.bounds.height)
            make.left.right.equalToSuperview()
        }
        
        myLessonsSelectionView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(view.snp.centerX).offset(-8)
            make.top.equalTo(userView.snp.bottom).offset(24)
            
        }
        
        feedbackSelectionView.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.left.equalTo(view.snp.centerX).offset(8)
            make.top.equalTo(userView.snp.bottom).offset(24)
            make.bottom.lessThanOrEqualTo(-40)
        }
        
        logoutButton.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(48)
            make.top.equalTo(myLessonsSelectionView.snp.bottom).offset(100)
        }
        
        socialAccountsView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(logoutButton.snp.bottom).offset(20)
            make.bottom.lessThanOrEqualTo(-40)
        }

    }
    
    private func stylizeViews() {
        view.backgroundColor = .backColor
        
        logoutButton.backgroundColor = .upperColor
        logoutButton.setTitle("Шығу", for: .normal)
        logoutButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        logoutButton.titleLabel?.font = .getMontserratMediumFont(on: 16)
        logoutButton.layer.cornerRadius = 15
    }
    
    private func setupActions() {
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        socialAccountsView.telegaButton.addTarget(self, action: #selector(openUrl(_:)), for: .touchUpInside)
        socialAccountsView.instaButton.addTarget(self, action: #selector(openUrl(_:)), for: .touchUpInside)
        socialAccountsView.youtubeButton.addTarget(self, action: #selector(openUrl(_:)), for: .touchUpInside)

    }
    
    private func setupRecognizer() -> Void {
        let myLessonsRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToMyLessons))
        self.myLessonsSelectionView.addGestureRecognizer(myLessonsRecognizer)
        let feedbackRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToFeedback))
        self.feedbackSelectionView.addGestureRecognizer(feedbackRecognizer)
        
    }

}
