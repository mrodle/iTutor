//
//  AppCenter.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class AppCenter{
    
    //MARK: - Properties
    var window: UIWindow = UIWindow()
    static let shared = AppCenter()
    private var currentViewController: UIViewController = UIViewController()
    private var width = UIScreen.main.bounds.width
    
    
    //MARK: - Start functions
    func createWindow(_ window: UIWindow) -> Void {
        window.backgroundColor = .backColor
        self.window = window
    }
    
    func start() -> Void {
        makeKeyAndVisible()
        makeRootController()
    }
        
    private func makeKeyAndVisible() -> Void {
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }
    
    func setRootController(_ controller: UIViewController) -> Void {
        currentViewController = controller
        window.rootViewController = currentViewController
    }
     
    func makeRootController() -> Void {
        let vc = TabbarController()
        setRootController(vc.inNavigation())
    }
    
    func getNewsFromPush(id: Int) -> Void {
        makeKeyAndVisible()
        let vc = TabbarController()

        let newsDetailVC = NewsDetailViewController(id: id)
        vc.selectedIndex = 1
        (vc.viewControllers![1] as! UINavigationController).pushViewController(newsDetailVC, animated: true)
        setRootController(vc.inNavigation())
    }
    
    func getQuestionAnswerFromPush() -> Void {
        makeKeyAndVisible()
        let vc = TabbarController()
        vc.selectedIndex = 2
        setRootController(vc.inNavigation())

    }
    
    //MARK: - functions
    func addSubview(view: UIView) -> Void {
        window.addSubview(view)
    }
    
}
