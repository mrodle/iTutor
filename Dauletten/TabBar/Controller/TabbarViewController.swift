//
//  TabbarViewController.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate {
    //    MARK: - Properties
    
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .mainColor
        tabBar.barTintColor = .backColor

        let main = CoursesViewController().inNavigation()
        main.tabBarItem = UITabBarItem.init(title: "Сабақтар", image: #imageLiteral(resourceName: "Combined Shape-3"), tag: 0)
        
        let meditation = NewsViewController().inNavigation()
        meditation.tabBarItem = UITabBarItem.init(title: "Жаңалықтар", image: #imageLiteral(resourceName: "Combined Shape"), tag: 1)
        
        let forum = FrequentlyAskedQuestion().inNavigation()
        forum.tabBarItem = UITabBarItem.init(title: "Сұрақ-жауап", image: #imageLiteral(resourceName: "Combined Shape-1"), tag: 2)
        
        let profile = ProfileViewController().inNavigation()
        profile.tabBarItem = UITabBarItem.init(title: "Профиль", image:     #imageLiteral(resourceName: "Combined Shape-2"), tag: 3)
        
        
        self.viewControllers = [main, meditation, forum, profile]
        
        self.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.navigationBar.barTintColor = .backColor
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.backgroundColor = .backColor
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Group 242"), style: .plain, target: self, action: #selector(restartAction))
//        self.navigationController?.navigationBar.tintColor = .mainColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.title = ""
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }

    @objc func restartAction() {
        AppCenter.shared.makeRootController()
    }
}
