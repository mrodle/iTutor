//
//  PopupTableViewCell.swift
//  VideoLessons
//
//  Created by Eldor Makkambayev on 4/14/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import WebKit

class PopupTableViewCell: UITableViewCell {
    
    //    MARK: - Properties
    var reloadSection: (() -> ())?
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .upperColor
        view.layer.cornerRadius = 16
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }

        return view
    }()
    
    var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.layer.masksToBounds = true
        loader.style = .whiteLarge
        
        return loader
    }()

    lazy var webView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = .upperColor
        view.scrollView.backgroundColor = .clear
        view.navigationDelegate = self
        view.isOpaque = false
        
        return view
    }()
    

    
    //    MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: _ Setup functions
    
    private func setupView() -> Void {
        selectionStyle = .none
        backgroundColor = .clear
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-16)
            make.top.equalToSuperview()
        }

        backView.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.left.equalTo(22)
            make.right.equalTo(-12)
            make.top.equalTo(24)
            make.height.equalTo(100)
            make.bottom.equalTo(-175)
        }
        

        backView.addSubview(loader)
        loader.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

    }
    func payButtonIsActive(_ bool: Bool) -> Void {
        if bool {
            webView.snp.remakeConstraints { (make) in
                make.left.equalTo(22)
                make.right.equalTo(-12)
                make.top.equalTo(24)
                make.height.equalTo(100)
                make.bottom.equalTo(-40)
            }

        }
    }
    
    func configure(course: Category) -> Void {
        
        self.webView.loadHTMLString((course.description ?? "").webViewContextConfiguration(), baseURL: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension PopupTableViewCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.loader.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loader.stopAnimating()
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(.zero)
        webView.scrollView.isScrollEnabled=false;

        webView.snp.remakeConstraints { (make) in
            make.left.equalTo(22)
            make.right.equalTo(-12)
            make.top.equalTo(24)
            make.height.equalTo(webView.scrollView.contentSize.height)
            make.bottom.equalTo(-40)

        }
        reloadSection?()
    }
    


}
