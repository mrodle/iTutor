//
//  NewsDetailViewController.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: LoaderBaseViewController {
    
    //    MARK: - Properties
    
    var id: Int
    var news: News?
    
    lazy var webView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self
        view.backgroundColor = .backColor
        view.scrollView.backgroundColor = .clear
        view.isOpaque = false
        view.tintColor = .clear
        
        return view
    }()
    
    //    MARK: - Lifecycle
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getNews(by: id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavBarWithLarge(title: news?.title ?? "", isLargeTitle: false)
        self.navigationController?.navigationBar.tintColor = .mainColor
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let bottomOffset = CGPoint(x: 0, y: webView.scrollView.contentSize.height - webView.scrollView.bounds.size.height)
        
        webView.scrollView.setContentOffset(bottomOffset, animated: false)
    }
    
    override func configureViews() {
        setupView()
        setupAction()
        removeScrollView()
    }
    
    
    //    MARK: Setup functions
    
    private func setupView() -> Void {
        view.backgroundColor = .backColor
        
        addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
    }
    
    
    private func setupAction() -> Void {
    }
    

    private func getNews(by id: Int) -> Void {
        self.showLoader()
        ParseManager.shared.getRequest(url: AppConstants.API.getNewsById, parameters: ["post_id": id], token: nil, success: { (result: News) in
            self.setupData(news: result)
            self.hideLoader()
        }) { (error) in
            self.showErrorMessage(error)
        }
    }
    
    private func setupData(news: News) -> Void {
        self.title = news.title
        self.news = news
        
        self.webView.loadHTMLString((news.description ?? "").webViewContextConfiguration(), baseURL: nil)
//        self.getImageList(news.images)
    }
    
//    private func getImageList(_ imageList: [String?]) -> Void {
//        for image in imageList {
//            if let url = image {
//                downloadImage(with: url)
//            }
//        }
//    }
//
//    func downloadImage(`with` urlString : String){
//        guard let url = URL.init(string: urlString.serverUrlString) else {
//            return
//        }
//        let resource = ImageResource(downloadURL: url)
//
//        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
//            switch result {
//            case .success(let value):
//                print("Image: \(value.image). Got from: \(value.cacheType)")
//            //                self.sliderView.sliders.append(value.image)
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
//    }
}

extension NewsDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.showLoader()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoader()
        
    }
}
