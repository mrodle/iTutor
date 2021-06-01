//
//  LessonDetailViewController.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import WebKit

class LessonDetailViewController: LoaderBaseViewController {
    
    //    MARK: - Properties
    private var viewModel = LessonDetailViewModel()
    
    var id: Int
    var course: Category
    var previewActionBlock: (() -> ())?
    
    lazy var navBar: BackNavBarView = {
        let view = BackNavBarView()
        view.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        return view
    }()
    
    private var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Экран түсірілімі уақытында контентті көре алмайсыз. Контенті көру үшін экран түсірілімін өшіріңіз!"
        label.numberOfLines = 0
        label.textColor = .red
        label.textAlignment = .center
        label.font = .getMontserratSemiBoldFont(on: 15)
        label.isHidden = true
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .getSFProSemiboldFont(on: 24)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var musicPlayerView = MusicPlayerView()
    
    lazy var webView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = .backColor
        view.scrollView.backgroundColor = .clear
        view.uiDelegate = self
        view.navigationDelegate = self
        view.isOpaque = false
        return view
    }()
    
    
    lazy var homeworkButton: MainButton = {
        let button = MainButton(title: "Үй тапсырмасы".uppercased())
        button.layer.shadowColor = UIColor.mainColor.withAlphaComponent(0.6).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 24.0
        return button
    }()
    
    override var previewActionItems: [UIPreviewActionItem] {
        let action2 = UIPreviewAction(title: "Сабақты қарау", style: .default) {[unowned self] (action, viewController) in
            self.previewActionBlock?()
        }
        return [action2]
    }
    
    
    //MARK: -  lifecycle
    
    init(id: Int, course: Category) {
        self.course = course
        self.id = id
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
//        UIScreen.main.addObserver(self, forKeyPath: "captured", options: .new, context: nil)
//
//        var isCaptured = false
//
//        if #available(iOS 11.0, *) {
//            isCaptured = UIScreen.main.isCaptured
//        } else {
//            // Fallback on earlier versions
//        }
//        self.warningLabel.isHidden = !isCaptured
//        self.contentView.isHidden = isCaptured
//        UserDefaults.standard.set(isCaptured, forKey: "isCaptured")
//        if isCaptured {
//            self.webView.loadHTMLString("", baseURL: nil)
//        } else {
            self.bind(to: viewModel)
            self.viewModel.getVideo(id: id)
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
//            self.warningLabel.isHidden = !isCaptured
//            self.contentView.isHidden = isCaptured
//            UserDefaults.standard.set(isCaptured, forKey: "isCaptured")
//            if isCaptured {
//                self.webView.loadHTMLString("".webViewContextConfiguration(), baseURL: nil)
//            } else {
//                self.viewModel.getVideo(id: id)
//            }
//        }
//    }
    
    private func bind(to viewModel: LessonDetailViewModel) {
        viewModel.error.observe(on: self) { [weak self] in
            guard  let `self` = self else { return }
            self.showAlert(type: .error, $0)}
        viewModel.loading.observe(on: self) { loading in
            if (loading) {
                self.showLoader()
            } else {
                self.contentView.isHidden = false
                self.hideLoader()
            }
        }
        
        viewModel.video.observe(on: self) { lessons in
            if let video = lessons {
                self.setupData(data: video)
            }
        }
    }

    //    MARK: Setup functions
    
    private func setupView() -> Void {
        contentView.backgroundColor = .backColor
        view.backgroundColor = .backColor
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(AppConstants.statusBarHeight + AppConstants.navBarHeight)
        }
        addSubview(warningLabel)
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
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
        }
        
        contentView.addSubview(homeworkButton)
        homeworkButton.snp.makeConstraints { (make) in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.height.equalTo(72)
            make.top.equalTo(webView.snp.bottom).offset(24)
            make.bottom.lessThanOrEqualTo(-24)
        }
        
    }
    
    private func setupData(data: Video) -> Void {
        hideAudioPlayer(is: data.audios == nil)
        hideHomework(is: data.homework == nil)
        self.titleLabel.text = data.title
        self.webView.loadHTMLString((data.description ?? "").webViewContextConfiguration(), baseURL: nil)
        self.musicPlayerView.titleLabel.text = data.title
        self.musicPlayerView.subtitleLabel.text = course.author
    }
    
    private func setupAction() -> Void {
        musicPlayerView.button.addTarget(self, action: #selector(toMusicPlayerPage), for: .touchUpInside)
        homeworkButton.addTarget(self, action: #selector(toHomework), for: .touchUpInside)
    }
    
    //    MARK: - Simple functions
    
    
    private func hideAudioPlayer(is bool: Bool) -> Void {
        if bool {
            musicPlayerView.isHidden = bool
            musicPlayerView.snp.remakeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom)
                make.left.equalTo(24)
                make.right.equalTo(-24)
                make.height.equalTo(0)
            }
        }
    }
    
    private func hideHomework(is bool: Bool) -> Void {
        if bool {
            homeworkButton.isHidden = true
            homeworkButton.snp.remakeConstraints { (make) in
                make.left.equalTo(24)
                make.right.equalTo(-24)
                make.top.equalTo(webView.snp.bottom)
                make.height.equalTo(0)
                make.bottom.lessThanOrEqualToSuperview()
            }
            
        }
    }
    
    //    MARK: - Objc functions
    
    @objc func toMusicPlayerPage() -> Void {
        guard let video = viewModel.video.value else { return }
        self.navigationController?.pushViewController(MusicPlayerViewController(video: video, course: course), animated: true)
    }
    
    @objc func toHomework() -> Void {
        guard let video = viewModel.video.value else { return }
        self.navigationController?.pushViewController(HomeworkViewController(video: video, course: course), animated: true)
    }
    
}
extension LessonDetailViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.showLoader()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoader()
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(.zero)
        webView.scrollView.isScrollEnabled = false;
        
        webView.snp.remakeConstraints { (make) in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.top.equalTo(musicPlayerView.snp.bottom).offset(30)
            make.height.equalTo(webView.scrollView.contentSize.height)
        }
    }
    
}
