//
//  Extension.swift
//  VideoHosting
//
//  Created by Eldor Makkambayev on 11/13/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIFont
extension UIFont {
    static func getSFProSemiboldFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Semibold", size: size)!
    }
    static func getSFProBoldFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Bold", size: size)!
    }
    static func getSFProRegularFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Regular", size: size)!
    }
    static func getSFProMediumFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Medium", size: size)!
    }
    static func getMontserratMediumFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: size)!
    }
    static func getMontserratSemiBoldFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-SemiBold", size: size)!
    }
    static func getMontserratBoldFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: size)!
    }
    static func getMontserratRegularFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }
}

extension UIView {
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
extension UIColor {
    static let mainColor = #colorLiteral(red: 0.247, green: 0.765, blue: 0.502, alpha: 1)
    static let backColor = #colorLiteral(red: 0.153, green: 0.161, blue: 0.176, alpha: 1)
    static let upperColor = #colorLiteral(red: 0.22, green: 0.231, blue: 0.251, alpha: 1)
    static let textColor = #colorLiteral(red: 0.929, green: 0.922, blue: 0.969, alpha: 1)
    static let selectionColor = #colorLiteral(red: 1, green: 0.875, blue: 0.22, alpha: 1)
    static let anotherBlue = #colorLiteral(red: 0.631372549, green: 0.7215686275, blue: 0.8117647059, alpha: 1)
}

//MARK : - UIVIewController
extension UIViewController {
    
    func addSubview(_ view: UIView) -> Void {
        self.view.addSubview(view)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func inNavigation() -> UIViewController {
        return UINavigationController(rootViewController: self)
    }

    func showAlertWithAction(title: String, message: String, completion: @escaping (()->())) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Бас тарту", style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: "Иә", style: .destructive) { (action) in
            completion()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    enum AlertMessageType: String {
        case error = "Ошибка"
        case warning = "Внимание"
        case success = "Успешно"
        case none = ""
    }

    func showAlert(type: AlertMessageType, _ message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        guard !message.isEmpty else { return }
        let alert = UIAlertController(title: type.rawValue, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }

    func showSubmitMessage(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Артқа", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }

    func setNavBarWithLarge(title: String, isLargeTitle: Bool = true) {
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.getMontserratBoldFont(on: 27) ]
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

        self.navigationItem.title = title
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationItem.prompt = nil
        self.navigationController?.navigationBar.prefersLargeTitles = isLargeTitle
        self.navigationController?.navigationBar.barTintColor = .backColor
        self.navigationController?.navigationBar.backgroundColor = .backColor
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.sizeToFit()
        }
    }

}

//MARK: - UIImage

extension UIImage {

}

//MARK:- UITableViewCell
extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

//MARK:- UICollectionViewCell
extension UICollectionViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}


//MARK: - String

extension String {
    var serverUrlString: String {
        return "http://194.146.43.145:9989/" + self
    }
    
    var url: URL {
        return URL(string: self)!
    }
    
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        return (self as NSString).substring(with: result.range)
    }
    
    func webViewContextConfiguration() -> String {
        return "<!DOCTYPE html><html><head><meta charset='UTF-8'><meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'><style>iframe{width: 100%;min-height: 150px;}img{display: block;max-width: 100%; height: auto;}</style></head><body>\(self)</body></html>"
    }

}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

//MARK: - UITableViewHeaderFooterView

