//
//  AinursSocNetworksView.swift
//  VideoLessons
//
//  Created by Eldor Makkambayev on 3/27/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class SocialAccountsView: UIView {

//    MARK: - Properties
    lazy var telegaButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Group 10476"), for: .normal)
        button.tag = 0
        
        return button
    }()
    
    lazy var instaButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Group 10478"), for: .normal)
        button.tag = 1

        return button
    }()

    lazy var youtubeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Group 10477"), for: .normal)
        button.tag = 2

        return button
    }()

//    MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK: - Setup functions
    
    private func setupView() -> Void {
        let distance = AppConstants.screenWidth * 60 / 375
        addSubview(youtubeButton)
        youtubeButton.snp.makeConstraints { (make) in
            make.top.bottom.centerX.equalToSuperview()
            make.height.width.equalTo(48)
        }
        
        addSubview(instaButton)
        instaButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.height.width.equalTo(48)
            make.right.equalTo(youtubeButton.snp.left).offset(-distance)
        }

        addSubview(telegaButton)
        telegaButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.height.width.equalTo(48)
            make.left.equalTo(youtubeButton.snp.right).offset(distance)
        }
    }
}
