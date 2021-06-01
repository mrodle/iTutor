//
//  MusicImageView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 11/18/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class MusicImageTitleView: UIView {
    
    //    MARK: - Properties
    lazy var musicImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Rectangle 90"))
        image.layer.cornerRadius = 90
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .getSFProSemiboldFont(on: 16)
        label.text = ""
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .getSFProRegularFont(on: 15)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)
        label.text = ""
        label.textAlignment = .center

        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .getSFProRegularFont(on: 15)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)
        label.text = ""
        label.textAlignment = .center

        return label
    }()



    //    MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupActions()
        setupRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    MARK: - Lifecycle
    
    //    MARK: - Setup functions
    
    
    private func setupView() -> Void {

        addSubview(musicImage)
        musicImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(180)
            make.top.centerX.equalToSuperview()
            
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(musicImage.snp.bottom).offset(18)
            make.right.equalTo(-16)
        }
        
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.right.equalTo(-16)
        }

        addSubview(countLabel)
        countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview()
        }

    }
    
    private func setupActions() -> Void {
    }
    
    private func setupRecognizer() -> Void {
    }
    
    @objc func titleAction() -> Void {
    }

    
    //    MARK: - Simple functions
    
    
    
    //    MARK: - Objc functions
    
}
