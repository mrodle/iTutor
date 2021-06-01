//
//  HomeworkViewController.swift
//  VideoLessons
//
//  Created by Eldor Makkambayev on 4/15/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import WebKit

class HomeworkViewController: LoaderBaseViewController {
    
    //    MARK: - Properties
    var video: Video
    var course: Category
    var previewActionBlock: (() -> ())?
    
    lazy var navBar: BackNavBarView = {
        let view = BackNavBarView()
        view.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .getSFProSemiboldFont(on: 24)
        label.numberOfLines = 0
        //        label.text = "Түпсана сабағы"
        
        return label
    }()
    
    lazy var musicPlayerView = MusicPlayerView()
    
    lazy var webView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = .backColor
        view.scrollView.backgroundColor = .clear
        view.navigationDelegate = self
        view.isOpaque = false
        
        return view
    }()

    //MARK: -  lifecycle
    
    init(video: Video, course: Category) {
        self.course = course
        self.video = video
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        setupLoaderView()
        setupData(data: video)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
//        
//        UIScreen.main.addObserver(self, forKeyPath: "captured", options: .new, context: nil)
//        
//        var isCaptured = false
//        
//        if #available(iOS 11.0, *) {
//            isCaptured = UIScreen.main.isCaptured
//        } else {
//            // Fallback on earlier versions
//        }
//        self.view.isHidden = isCaptured
//        UserDefaults.standard.set(isCaptured, forKey: "isCaptured")
//        if isCaptured {
//            self.playerView.playerView.stopVideo()
//        }
        
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
//        if (keyPath == "captured") {
//            var isCaptured = false
//
//            if #available(iOS 11.0, *) {
//                isCaptured = UIScreen.main.isCaptured
//            } else {
//                // Fallback on earlier versions
//            }
//            self.view.isHidden = isCaptured
//            UserDefaults.standard.set(isCaptured, forKey: "isCaptured")
//            if isCaptured {
////                self.playerView.playerView.stopVideo()
//            }
//            print(isCaptured)
//
//        }
//    }
    
    //    MARK: Setup functions
    
    private func setupView() -> Void {
        contentView.backgroundColor = .backColor
        view.backgroundColor = .backColor
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(AppConstants.statusBarHeight + AppConstants.navBarHeight)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(AppConstants.statusBarHeight + AppConstants.navBarHeight + 24)
            make.left.equalTo(24)
            make.right.equalTo(-24)
        }
        
        contentView.addSubview(musicPlayerView)
        musicPlayerView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.left.equalTo(24)
            make.right.equalTo(-24)
        }
        
        contentView.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.height.equalTo(200)
            make.top.equalTo(musicPlayerView.snp.bottom).offset(30)
            make.bottom.lessThanOrEqualTo(-24)
        }

//        contentView.addSubview(musicPlayerView)
//        musicPlayerView.snp.makeConstraints { (make) in
//            make.top.equalTo(AppConstants.statusBarHeight + AppConstants.navBarHeight + 24)
//            make.left.equalTo(24)
//            make.right.equalTo(-24)
//        }
//
//        contentView.addSubview(aboutLessonView)
//        aboutLessonView.snp.makeConstraints { (make) in
//            make.left.equalTo(24)
//            make.right.equalTo(-24)
//            make.top.equalTo(musicPlayerView.snp.bottom).offset(30)
//        }
        
        
    }
    
    private func setupData(data: Video) -> Void {
        hideAudioPlayer(is: data.homework_audios == nil)
        
        self.titleLabel.text = "Үй тапсырмасы"
        self.webView.loadHTMLString((data.homework ?? "").webViewContextConfiguration(), baseURL: nil)
        self.musicPlayerView.titleLabel.text = data.title
        self.musicPlayerView.subtitleLabel.text = course.author
    }
    
    private func setupAction() -> Void {
        musicPlayerView.button.addTarget(self, action: #selector(toMusicPlayerPage), for: .touchUpInside)
    }
    
    //    MARK: - Simple functions
        
    private func hideAudioPlayer(is bool: Bool) -> Void {
        if bool {
            musicPlayerView.isHidden = bool
            musicPlayerView.snp.remakeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom)
                make.height.equalTo(0)
                make.left.equalTo(24)
                make.right.equalTo(-24)
            }
        }
    }
    
    //    MARK: - Objc functions
    
    @objc func toMusicPlayerPage() -> Void {
        self.navigationController?.pushViewController(MusicPlayerViewController(video: video, course: course, isHomework: true), animated: true)
    }
}


extension HomeworkViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.showLoader()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoader()
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(.zero)
        webView.scrollView.isScrollEnabled=false;
        
        webView.snp.remakeConstraints { (make) in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.top.equalTo(musicPlayerView.snp.bottom).offset(30)
            make.height.equalTo(webView.scrollView.contentSize.height + 100)
            make.bottom.lessThanOrEqualTo(-24)
        }
    }
}
