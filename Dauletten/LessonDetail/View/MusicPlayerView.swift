//
//  MusicPlayerView.swift
//  VideoLessons
//
//  Created by Eldor Makkambayev on 3/26/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class MusicPlayerView: UIView {
    
//    MARK: - Properties
    
    lazy var playBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    lazy var playButtonView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "Vector-1"))
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .getSFProSemiboldFont(on: 13)
        label.textColor = .white
        
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .getSFProRegularFont(on: 13)
        label.textColor = #colorLiteral(red: 0.758, green: 0.809, blue: 0.862, alpha: 0.7)
        
        return label
    }()
    
    lazy var button = UIButton()

    
//    MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup function
    
    private func setupView() -> Void {
        self.backgroundColor = .upperColor
        self.layer.cornerRadius = 16
        
        addSubview(playBackView)
        playBackView.snp.makeConstraints { (make) in
            make.top.left.equalTo(12)
            make.height.width.equalTo(50)
            make.bottom.equalTo(-12)

        }
        
        playBackView.addSubview(playButtonView)
        playButtonView.snp.makeConstraints { (make) in
            make.height.equalTo(18)
            make.width.equalTo(15)
            make.center.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(playBackView.snp.right).offset(10)
            make.bottom.equalTo(playBackView.snp.centerY).offset(-3)
            make.right.equalTo(-10)
        }
        
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(playBackView.snp.right).offset(10)
            make.top.equalTo(playBackView.snp.centerY).offset(3)
            make.right.equalTo(-10)
        }
        
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
