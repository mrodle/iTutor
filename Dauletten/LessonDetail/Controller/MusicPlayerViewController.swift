//
//  MusicPlayerViewController.swift
//  VideoLessons
//
//  Created by Eldor Makkambayev on 3/26/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: LoaderBaseViewController {
    
    //    MARK: - Properties
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    
    var url: URL?
    var recordList: [String]
    var course: Category
    var position = 0
    
    
    var secs = Int()
    var fullsec = Int()
    lazy var navBarView: BackNavBarView = {
        let view = BackNavBarView()
        view.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        
        return view
    }()
    lazy var musicImageTitleView = MusicImageTitleView()
    lazy var soundSliderView = SoundSliderView()
    lazy var controllView = PlayerControlView()
    
    //    MARK: - Initialization
    
    init(video: Video, course: Category, isHomework: Bool = false) {
        self.course = course
        self.recordList = isHomework ? video.homework_audios ?? [] : video.audios ?? []
        super.init(nibName: nil, bundle: nil)
        self.setupData(video: video)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
        setupLoaderView()
        setupRecord(record: recordList[position])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.hideLoader()
        self.stopPlayer()
    }
    
    
    //    MARK: - Setup functions
    
    private func setupView() -> Void {
        view.backgroundColor = .mainColor
        view.addSubview(navBarView)
        navBarView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(AppConstants.navBarHeight+AppConstants.statusBarHeight)
        }
        
        contentView.addSubview(musicImageTitleView)
        musicImageTitleView.snp.makeConstraints { (make) in
            make.top.equalTo(AppConstants.navBarHeight+AppConstants.statusBarHeight+60)
            make.left.right.equalToSuperview()
        }
        
        contentView.addSubview(soundSliderView)
        soundSliderView.snp.makeConstraints { (make) in
            make.right.equalTo(-38)
            make.left.equalTo(38)
            make.top.equalTo(musicImageTitleView.snp.bottom).offset(42)
        }
        
        contentView.addSubview(controllView)
        controllView.snp.makeConstraints { (make) in
            make.top.equalTo(soundSliderView.snp.bottom).offset(32)
            make.left.right.equalToSuperview()
            make.bottom.lessThanOrEqualTo(-32)
        }
        
    }
    
    private func setupActions() -> Void {
        self.controllView.playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        self.soundSliderView.sliderView.addTarget(self, action: #selector(musicTimeChangeAction(sender:)), for: .touchUpInside)
        self.controllView.nextButton.addTarget(self, action: #selector(toNextAudio), for: .touchUpInside)
        self.controllView.previousButton.addTarget(self, action: #selector(toPreviousAudio), for: .touchUpInside)
        
    }
    
    private func setupData(video: Video) -> Void {
        if let url = video.video_fon {
            self.musicImageTitleView.musicImage.kf.setImage(with: url.serverUrlString.url)
        }
        self.musicImageTitleView.countLabel.text = "\(recordList.count) аудио"
        self.musicImageTitleView.titleLabel.text = video.title
        self.musicImageTitleView.subtitleLabel.text = course.author ?? ""
    }
    
    private func setupRecord(record: String) -> Void {
        controllView.nextButton(isActive: recordList.count - 1  > position)
        controllView.previousButton(isActive: position != 0)
        if let url = URL(string: record.serverUrlString) {
            self.url = url
        }
        try! AVAudioSession.sharedInstance().setCategory(.playback, options: [])
        player = nil
        self.showLoader()
        playerConfiguration()
        player!.play()
        controllView.playView.image = #imageLiteral(resourceName: "Vector-4")
    }
    
    
    //    MARK: - Simple functions
    
    private func playerConfiguration() -> Void {
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        self.showLoader()
        self.player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main, using: { (time) in
            if self.player!.currentItem?.status == .readyToPlay {
                self.hideLoader()
                let currentTime = CMTimeGetSeconds(self.player!.currentTime())
                let fullTime = CMTimeGetSeconds(self.player!.currentItem!.duration)
                
                self.secs = Int(currentTime)
                self.fullsec = Int(fullTime)
                self.soundSliderView.currentTime.text = String(format: "%02d:%02d", self.secs/60, self.secs%60)
                self.soundSliderView.sliderView.value = Float(self.secs*100/self.fullsec)
                self.soundSliderView.fullTime.text = String(format: "%02d:%02d", self.fullsec/60, self.fullsec%60)
                if self.secs == self.fullsec {
                    if self.position < self.recordList.count - 1 {
                        self.toNextAudio()
                    } else {
                        self.stopPlayer()
                    }
                }
            } else if self.player!.currentItem?.status == .failed {
                self.showErrorMessage("Аудионы жүктеуде бір қателік кетті")
            }
        })
        
    }
    
    private func stopPlayer() -> Void {
        self.player?.seek(to: .zero)
        self.player?.pause()
        self.controllView.playView.image = #imageLiteral(resourceName: "Vector")
    }
    
    //    MARK: - Objc functions
    
    @objc func playAction() -> Void {
        
        if player?.rate == 0 {
            player!.play()
            self.showLoader()
            controllView.playView.image = #imageLiteral(resourceName: "Vector-4")
        } else {
            player!.pause()
            self.hideLoader()
            controllView.playView.image = #imageLiteral(resourceName: "Vector")
        }
    }
    
    @objc func musicTimeChangeAction(sender: UISlider) -> Void {
        let myTime = CMTime(seconds: Double(Int(sender.value)*fullsec/100), preferredTimescale: 60000)
        
        player?.seek(to: myTime, toleranceBefore: .zero, toleranceAfter: .zero)
        
    }
    
    @objc func toNextAudio() -> Void {
        position += 1
        setupRecord(record: recordList[position])
    }
    
    @objc func toPreviousAudio() -> Void {
        position -= 1
        setupRecord(record: recordList[position])
    }

    
}
