//
//  LoaderBaseViewController.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/15/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class LoaderBaseViewController: ScrollViewController {
    //    MARK: - Properties
    var messageTimer: Timer?
    
    var messageBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .backColor
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.mainColor.cgColor
        view.layer.cornerRadius = 15
        view.isHidden = true
        
        return view
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainColor
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 150
        label.textAlignment = .center
        label.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return label
    }()
    
    var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.layer.borderColor = UIColor.mainColor.cgColor
        loader.layer.borderWidth = 1
        loader.layer.cornerRadius = 15
        loader.layer.masksToBounds = true
        loader.backgroundColor = .backColor
        loader.style = .whiteLarge
        loader.color = .mainColor
        loader.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return loader
    }()
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupLoaderView()
    }
    
    func configureViews() -> Void {
        
    }
    
    //    MARK: - Setup functions
    func setupLoaderView() -> Void {
        view.addSubview(loader)
        loader.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
        view.addSubview(messageBackView)
        messageBackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        messageBackView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
        }
        
    }
    
    func removeScrollView() -> Void {
        self.scrollView.removeFromSuperview()
    }
    
    func showLoader() -> Void {
        self.loader.startAnimating()
    }
    
    func hideLoader() -> Void {
        self.loader.stopAnimating()
    }
    
    func showErrorMessage(_ message: String) -> Void {
        self.hideLoader()
        let resultAttrString = NSMutableAttributedString()
        let simbolAttribute = NSAttributedString(string: "𝖷\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)])
        
        let messageAttribute = NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        resultAttrString.append(simbolAttribute)
        resultAttrString.append(messageAttribute)
        messageLabel.attributedText = resultAttrString//.text = "x\n\(message)"
        
        self.messageBackView.alpha = 1
        messageBackView.isHidden = false
        messageTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(hideMessageLabel), userInfo: nil, repeats: false)
        
    }
    
    func showSuccess(_ message: String? = nil) -> Void {
        self.hideLoader()
        if let message = message {
            let resultAttrString = NSMutableAttributedString()
            let simbolAttribute = NSAttributedString(string: "✓", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)])
            
            let messageAttribute = NSAttributedString(string: "\n\(message)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
            resultAttrString.append(simbolAttribute)
            resultAttrString.append(messageAttribute)
            messageLabel.attributedText = resultAttrString
        } else {
            let resultAttrString = NSMutableAttributedString()
            let simbolAttribute = NSAttributedString(string: "✓", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)])
            
            resultAttrString.append(simbolAttribute)
            messageLabel.attributedText = resultAttrString
            
        }
        
        self.messageBackView.alpha = 1
        messageBackView.isHidden = false
        messageTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(hideMessageLabel), userInfo: nil, repeats: false)
        
    }
    
    @objc private func hideMessageLabel() -> Void {
        UIView.animate(withDuration: 0.3, animations: {
            self.messageBackView.alpha = 0
        }) { (Bool) in
            self.messageBackView.isHidden = true
            
        }
        messageTimer?.invalidate()
        messageTimer = nil
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
